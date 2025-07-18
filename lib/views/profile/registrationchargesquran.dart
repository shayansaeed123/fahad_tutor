
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

class RegistrationChargesQuran extends StatefulWidget {
  const RegistrationChargesQuran({super.key});

  @override
  State<RegistrationChargesQuran> createState() => _RegistrationChargesQuranState();
}

class _RegistrationChargesQuranState extends State<RegistrationChargesQuran> {
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
      // String uploadUrl = 'https://fahadtutors.com/upload_doc_5.php';
      String uploadUrl = '${MySharedPrefrence().get_baseUrl()}upload_doc_5.php';
    var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
    // ✅ Add the field Registration_Quran_check = 1
    request.fields['Registration_Quran_check'] = '1';
        if (_chargesSlip != null) {
          request.files.add(await http.MultipartFile.fromPath('Registration_Quran', _chargesSlip!.path));
        }
    var response = await request.send();
    if (response.statusCode == 200) {
       final responseString = await response.stream.bytesToString();
      final responseData = json.decode(responseString);
      print('Response Data: $responseData');
      setState(() {
        // chargesSlip = responseData['Registration_Quran'] ?? chargesSlip;
        repository.charges_image_quran.value = responseData['Registration_Quran'] ?? repository.charges_image_quran.value;
      });
      print('fdgkdfg $chargesSlip');
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
  if (repository.charges_image_quran.value != 'https://www.fahadtutors.com/fta_admin/' &&
      repository.charges_image_quran.value.isNotEmpty ) {
    _uploadData();
  } else {
    Utils.snakbar(
      context,
      repository.charges_image_quran.value == 'https://www.fahadtutors.com/fta_admin/' || repository.charges_image_quran.value.isEmpty
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
        'payment_recipt_quran': repository.charges_image_quran.value.toString(),
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
                          Text(repository.registration_heading_quran,
                          style: TextStyle(
                            color: colorController.blackColor,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'tutorPhi'),
                          ),
                          // reusableText(repository.registration_heading_quran,color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold),
                          reusablaSizaBox(context, 0.020),
                          ValueListenableBuilder(valueListenable: repository.popup, builder: (context, value, child) {
              if(value == 1){
                return reusableVisiblityMesage(context, MySharedPrefrence().get_popup_text(), (){setState(() {visible=false;});}, visible);
                }else{return Container();}
            },),
            reusablaSizaBox(context, 0.020),
                          reusableText(repository.Registration_text_quran,color: colorController.blackColor,fontsize: 14),
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
          //       reusablaSizaBox(context, 0.01),
          //       DottedBorder(
          //         color: colorController.blackColor,
          //           strokeWidth: 2,
          //           dashPattern: [6, 3],
          //           radius: Radius.circular(15),
          //           child:  InkWell(
          //   onTap: (){
          //     reuablebottomsheet(context, 'Choose Charges Slip Image', (){
          //       _pickImage(ImageSource.gallery);
          //     }, (){
          //       _pickImage(ImageSource.camera);
          //     });
          //   },
          //   child: Container(
          //     width: MediaQuery.of(context).size.width * .43,
          //     height: MediaQuery.of(context).size.height * .18,
          //     decoration: BoxDecoration(
          //       color: colorController.whiteColor,
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //     child: Padding(
          //       padding: EdgeInsets.all(MediaQuery.of(context).size.width * .013,),
          //       child: _chargesSlip != null
          //                       ? Image.file(_chargesSlip!, fit: BoxFit.cover) : 
          //       Center(child: Image.asset('assets/images/add_img_placeholder.png',fit: BoxFit.contain,)
          //       // : Image.network(image,fit: BoxFit.contain,)
          //         ),
          //     ),
          //   ),
          // ),
          //           // reusableSelectImage2(context, (){}, '')
          //       ),
          //       reusablaSizaBox(context, .010),
          reusableDocuments1(context, '', '', repository.charges_image_quran.value.toString(), (){
              reuablebottomsheet(context, 'Choose Charges Slip Image', (){
                _pickImage(ImageSource.gallery);
              }, (){
                _pickImage(ImageSource.camera);
              });
            }, 'assets/images/add_img_placeholder.png'),
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