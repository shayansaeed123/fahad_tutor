import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablebottomsheet.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class RegistrationCharges extends StatefulWidget {
  const RegistrationCharges({super.key});

  @override
  State<RegistrationCharges> createState() => _RegistrationChargesState();
}

class _RegistrationChargesState extends State<RegistrationCharges> {
  bool isLoading = false;
  TutorRepository repository = TutorRepository();
  File? _chargesSlip;
  final picker = ImagePicker();
  String chargesSlip = '';
  Future<void> registerText() async {
    setState(() {
      isLoading = true;
    });
    await repository.Check_popup();
    setState(() {
      isLoading = false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    registerText();
  }
  Future<void> _pickImage(ImageSource source,) async {
  final pickedFile = await picker.pickImage(source: source);

  if (pickedFile != null) {
    setState(() {_chargesSlip = File(pickedFile.path);});
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Image Updated'),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(_chargesSlip!),
                fit: BoxFit.contain,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.all(5),
              child: reusableBtn(context, 'Cancel', () {
                Navigator.pop(context);
              }),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: reusableBtn(context, 'Submit', () {
                setState(() {
                  _uploadImages();
                });
                Navigator.pop(context);
                Navigator.pop(context);
              }),
            ),
          ],
        ),
      );
    } else {
      print('No image selected');
    }
}
Future<void> _uploadImages() async {
    setState(() {
      isLoading = true;
    });
    try{
      String uploadUrl = 'https://fahadtutors.com/mobile_app/upload_doc_5.php';
    var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
        if (_chargesSlip != null) {
          request.files.add(await http.MultipartFile.fromPath('Registration', _chargesSlip!.path));
        }
    var response = await request.send();
    if (response.statusCode == 200) {
       final responseString = await response.stream.bytesToString();
      final responseData = json.decode(responseString);
      print('Response Data: $responseData');
      setState(() {
        chargesSlip = responseData['CNIC_F'] ?? chargesSlip;
      });
      print(responseData);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed')),
      );
    }
    }catch(e){
      print(e);
    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _uploadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.post(
          Uri.parse('${Utils.baseUrl}mobile_app/step_5_update.php'),
          body: {
        'code': '10',
        'update_status': '4',
        'tutor_id': MySharedPrefrence().get_user_ID().toString(),
        'payment_recipt': chargesSlip.toString(),
      },);
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final Map<String, dynamic> jsonResponse = json.decode(response.body);
          print('helloooo $jsonResponse');
          Navigator.pop(context);
        } else {
          throw Exception('Empty response body');
        }
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load country details');
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return reusableprofileidget( context,
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .032),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reusableText("Registration Charges Slip",color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold),
                          reusablaSizaBox(context, 0.020),
                          reusableText(repository.Registration_text,color: colorController.blackColor,fontsize: 14),
                          reusablaSizaBox(context, 0.005),
                          Row(children: [reusableText('see ',fontsize: 13.5,fontweight: FontWeight.bold),
                          InkWell(
                            onTap: (){launch('https://fahadtutors.com/payment');},
                            child: reusableText('Bank Details',fontsize: 13.5,color: colorController.btnColor,fontweight: FontWeight.bold))],),
                          reusablaSizaBox(context, 0.020),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                reusableText('Add Slip', color: colorController.btnColor,fontsize: 16,fontweight: FontWeight.bold),
                DottedBorder(
                  color: colorController.blackColor,
                    strokeWidth: 2,
                    dashPattern: [6, 3],
                    radius: Radius.circular(15),
                    child:  InkWell(
            onTap: (){
              reuablebottomsheet(context, 'Choose Charges Slip Image', (){
                _pickImage(ImageSource.gallery);
              }, (){
                _pickImage(ImageSource.camera);
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width * .43,
              height: MediaQuery.of(context).size.height * .18,
              decoration: BoxDecoration(
                color: colorController.whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * .013,),
                child: _chargesSlip != null
                                ? Image.file(_chargesSlip!, fit: BoxFit.cover) : 
                Center(child: Image.asset('assets/images/add_img_placeholder.png',fit: BoxFit.contain,)
                // : Image.network(image,fit: BoxFit.contain,)
                  ),
              ),
            ),
          ),
                    // reusableSelectImage2(context, (){}, '')
                ),
                reusablaSizaBox(context, .010),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * .16),
              child: reusableBtn(context, 'Update', (){
                setState(() {});
                _uploadData();
              }),
            )
                ],
                      ),
                    ],
                  ),
                ),
                Center(child: reusableloadingrow(context, isLoading))
    );
  }
}