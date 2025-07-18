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
import 'package:fahad_tutor/res/reusabledocuments.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/res/reusablevisibility.dart';
import 'package:fahad_tutor/views/profile/profile.dart';
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
    bool visible = true;
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
  void doc()async{
    setState(() {
      isLoading = true;
    });
    await repository.documentsAttach();
    setState(() {
      isLoading = false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    registerText();
    repository.check_msg();
    doc();
  }
  Future<void> _pickImage(ImageSource source,) async {
  final pickedFile = await picker.pickImage(source: source);

  if (pickedFile != null) {
    File? selectedImage;
    setState(() {
      _chargesSlip = File(pickedFile.path);
      selectedImage = _chargesSlip;
      });
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
      // String uploadUrl = 'https://fahadtutors.com/upload_doc_5.php';
      String uploadUrl = '${MySharedPrefrence().get_baseUrl()}upload_doc_5.php';
    var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
    // ✅ Add the field Registration_Quran_check = 1
    request.fields['Registration_check'] = '1';
        if (_chargesSlip != null) {
          request.files.add(await http.MultipartFile.fromPath('Registration', _chargesSlip!.path));
        }
    var response = await request.send();
    if (response.statusCode == 200) {
       final responseString = await response.stream.bytesToString();
      final responseData = json.decode(responseString);
      print('Response Data: $responseData');
      setState(() {
        // chargesSlip = responseData['Registration'] ?? chargesSlip;
        repository.charges_image.value = responseData['Registration'] ?? repository.charges_image.value;
      });
      print('fdgkdfg ${repository.charges_image.value}');
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

  void _validateForm() {
  if (repository.charges_image.value != 'https://www.fahadtutors.com/fta_admin/' &&
      repository.charges_image.value.isNotEmpty ) {
    _uploadData();
  } else {
    Utils.snakbar(
      context,
      repository.charges_image.value == 'https://www.fahadtutors.com/fta_admin/' || repository.charges_image.value.isEmpty
          ? "Select Charges Image"
                      : "Fill Correct Fields",
    );
  }
}

  Future<void> _uploadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.post(
          Uri.parse('${MySharedPrefrence().get_baseUrl()}step_5_update.php'),
          body: {
        'code': '10',
        'update_status': '4',
        'tutor_id': MySharedPrefrence().get_user_ID().toString(),
        'payment_recipt': repository.charges_image.value.toString(),
      },);
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final Map<String, dynamic> jsonResponse = json.decode(response.body);
          print('helloooo $jsonResponse');
          // Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Profile(),));
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
                          reusableText(repository.registration_heading,color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold),
                          reusablaSizaBox(context, 0.020),
                          ValueListenableBuilder(valueListenable: repository.popup, builder: (context, value, child) {
              if(value == 1){
                return reusableVisiblityMesage(context, MySharedPrefrence().get_popup_text(), (){setState(() {visible=false;});}, visible);
                }else{return Container();}
            },),
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
                reusableText('Slip Image', color: colorController.btnColor,fontsize: 16),
          reusableDocuments1(context, '', '', repository.charges_image.value.toString(), (){
              reuablebottomsheet(context, 'Choose Charges Slip Image', (){
                _pickImage(ImageSource.gallery);
              }, (){
                _pickImage(ImageSource.camera);
              });
            }, 'assets/images/add_img_placeholder.png'),
                // reusablaSizaBox(context, .010),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * .16),
              child: reusableBtn(context, 'Update', (){
                setState(() {});
                _validateForm();
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