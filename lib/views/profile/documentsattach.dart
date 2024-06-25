import 'dart:convert';
import 'dart:io';

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusablebottomsheet.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusabledocuments.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/res/reusablevisibility.dart';
import 'package:fahad_tutor/views/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class DocumentsAttach extends StatefulWidget {
  const DocumentsAttach({super.key});

  @override
  State<DocumentsAttach> createState() => _DocumentsAttachState();
}

class _DocumentsAttachState extends State<DocumentsAttach> {

  bool isLoading = false;
  int doc_error = 0;
  String docs_msg = '';
  bool visible = true;
  bool updateprofileimage = false;
  String base64updateprofileimage = '';

  File? _cnicFront;
  File? _cnicBack;
  File? _profile;
  File? _last_document;
  File? _other1;
  File? _other2;
  final picker = ImagePicker();
  String profile = '';
  String cnic_f = '';
  String cnic_b = '';
  String last_document = '';
  String other1 = '';
  String other2 = '';
  Future<void> documentsAttach() async {

    isLoading = true;

    try {
      String url =
          '${Utils.baseUrl}mobile_app/get_ducoments.php?code=10&tutors_ids=${MySharedPrefrence().get_user_ID()}';
      final response = await http.get(Uri.parse(url));
      print('url $url');

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        setState(() {});
      MySharedPrefrence().set_profile_img(jsonResponse['personal_image']);
      MySharedPrefrence().set_cnic_front(jsonResponse['cnic_front']);
      MySharedPrefrence().set_cnic_back(jsonResponse['cnic_back']);
      MySharedPrefrence().set_last_document(jsonResponse['last_document']);
      MySharedPrefrence().set_other_1(jsonResponse['other_1']);
      MySharedPrefrence().set_other_2(jsonResponse['other_2']);
      doc_error = jsonResponse['docs_error'];
      docs_msg = jsonResponse['docs_msg'];
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void doc()async{
    await documentsAttach();
  }

  Future<void> _pickImage(ImageSource source, String imageType) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        switch (imageType) {
          case 'front':
            _cnicFront = File(pickedFile.path);
            break;
          case 'back':
            _cnicBack = File(pickedFile.path);
            break;
          case 'profile':
            _profile = File(pickedFile.path);
            break;
          case 'qualification':
            _last_document = File(pickedFile.path);
            break;
          case 'other1':
            _other1 = File(pickedFile.path);
            break;
          case 'other2':
            _other2 = File(pickedFile.path);
            break;
        }
      });
      showUpdateProfileImageDialog(imageType);
    } else {
      print('No image selected');
    }
  }

  Future<void> _uploadImages() async {

    String uploadUrl = 'https://fahadtutors.com/mobile_app/upload_doc_4.php';
    var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));

    if (_cnicFront != null)
      request.files.add(await http.MultipartFile.fromPath('CNIC_F', _cnicFront!.path));
    if (_cnicBack != null)
      request.files.add(await http.MultipartFile.fromPath('CNIC_B', _cnicBack!.path));
    if (_profile != null)
      request.files.add(await http.MultipartFile.fromPath('profile_pic', _profile!.path));
    if (_last_document != null)
      request.files.add(await http.MultipartFile.fromPath('Qualification', _last_document!.path));
    if (_other1 != null)
      request.files.add(await http.MultipartFile.fromPath('other_1', _other1!.path));
    if (_other2 != null)
      request.files.add(await http.MultipartFile.fromPath('other_2', _other2!.path));

    var response = await request.send();

    if (response.statusCode == 200) {
       final responseString = await response.stream.bytesToString();
      final responseData = json.decode(responseString);
      setState(() {
      if (responseData.containsKey('profile_pic')) {
        profile = responseData['profile_pic'];
      }
      if (responseData.containsKey('Qualification')) {
        last_document = responseData['Qualification'];
      }
      if (responseData.containsKey('CNIC_F')) {
        cnic_f = responseData['CNIC_F'];
      }
      if (responseData.containsKey('CNIC_B')) {
        cnic_b = responseData['CNIC_B'];
      }
    });
      print(responseData);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed')),
      );
    }
  }

  Future<void> _uploadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.post(
          Uri.parse('${Utils.baseUrl}mobile_app/step_4_update.php'),
          body: {
        'code': '10',
        'update_status': '4',
        'tutor_id': MySharedPrefrence().get_user_ID().toString(),
        'is_term_accepted': '1',
        'profile_img': profile.toString(),
        'cnic_f': cnic_f.toString(),
        'cnic_b': cnic_b.toString(),
        'last_document': last_document.toString(),
        'other_1': other1.toString(),
        'other_2': other2.toString(),
      },);
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final Map<String, dynamic> jsonResponse = json.decode(response.body);
          print('helloooo $jsonResponse');
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

  //  Future<void> _uploadData() async {
  //   String uploadUrl = 'https://fahadtutors.com/mobile_app/step_4_update.php';
  //   var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
  //   request.fields['code'] = '10';
  //   request.fields['update_status'] = '4';
  //   request.fields['tutor_id'] = MySharedPrefrence().get_user_ID().toString();
  //   request.fields['is_term_accepted'] = "1";

  //   if (_profile != null) {
  //     request.files.add(await http.MultipartFile.fromPath(
  //       'profile_img',
  //       _profile!.path,
  //     ));
  //   }
  //   if (_cnicFront != null) {
  //     request.files.add(await http.MultipartFile.fromPath(
  //       'cnic_f',
  //       _cnicFront!.path,
  //     ));
  //   }
  //   if (_cnicBack != null) {
  //     request.files.add(await http.MultipartFile.fromPath(
  //       'cnic_b',
  //       _cnicBack!.path,
  //     ));
  //   }
  //   if (_last_document != null) {
  //     request.files.add(await http.MultipartFile.fromPath(
  //       'last_document',
  //       _last_document!.path,
  //     ));
  //   }
  //   if (_other1 != null) {
  //     request.files.add(await http.MultipartFile.fromPath(
  //       'other_1',
  //       _other1!.path,
  //     ));
  //   }
  //   if (_other2 != null) {
  //     request.files.add(await http.MultipartFile.fromPath(
  //       'other_2',
  //       _other2!.path,
  //     ));
  //   }

  //   var response = await request.send();

  //   if (response.statusCode == 200) {
  //     final responseString = await response.stream.bytesToString();
  //     final responseData = json.decode(responseString);
  //     print(responseData);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Upload successful')),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Upload failed')),
  //     );
  //   }
  // }

   void showUpdateProfileImageDialog(String imageType) {
    File? selectedImage;

    switch (imageType) {
      case 'front':
        selectedImage = _cnicFront;
        break;
      case 'back':
        selectedImage = _cnicBack;
        break;
      case 'profile':
        selectedImage = _profile;
        break;
      case 'qualification':
        selectedImage = _last_document;
        break;
      case 'other1':
        selectedImage = _other1;
        break;
      case 'other2':
        selectedImage = _other2;
        break;
    }

    if (selectedImage != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Image Updated'),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(selectedImage!),
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doc();
  }

  @override
  Widget build(BuildContext context) {
    return 
    reusableprofileidget(
    //   Scaffold(
    //     backgroundColor: colorController.whiteColor,
    // appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,),
    //     body: Stack(
    //       children: [
    //         SafeArea(
    //           child: SingleChildScrollView(
    //             child: 
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .032),
                  child: 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              reusableText('Documents \nAttachment',color: colorController.blackColor,fontsize: 25,fontweight: FontWeight.bold),
                              reusablaSizaBox(context, 0.020),
                              doc_error == 1 ? reusableVisiblityWarning(context, '${docs_msg}', (){setState(() {visible=false;});}, visible) : Container(),
                              reusablaSizaBox(context, 0.020),
                              reusableDocuments(context,'','Add Image (Front)','Add Image (Back)' ,'Profile', 'CNIC Image', MySharedPrefrence().get_profile_img(), MySharedPrefrence().get_cnic_front(),MySharedPrefrence().get_cnic_back(), (){
                                reuablebottomsheet(context, "Choose Profile Image",(){
                                  // selectupdateprofileimage(ImageSource.gallery,);
                                  _pickImage(ImageSource.gallery, 'profile');
                                },(){
                                  _pickImage(ImageSource.camera,'profile');
                                });
                              },(){reuablebottomsheet(context, "Choose CNIC Front Image",(){
                                _pickImage(ImageSource.gallery,'front');
                              },(){
                                _pickImage(ImageSource.camera,'front');
                              });},
                              (){reuablebottomsheet(context, "Choose CNIC Back Image",(){
                                _pickImage(ImageSource.gallery,'back');
                              },(){
                                _pickImage(ImageSource.camera,'back');
                              });}
                              ),
                               reusablaSizaBox(context, 0.020),
                              reusableDocuments(context, 'Add Image', '', '', 'Last Qualification Proof', 'Attach other Documents(Optional)', MySharedPrefrence().get_last_document(), MySharedPrefrence().get_other_1(), MySharedPrefrence().get_other_2(), (){
                                reuablebottomsheet(context, "Choose Qualification Image",(){
                                  _pickImage(ImageSource.gallery,'qualification');
                                },(){
                                  _pickImage(ImageSource.camera,'qualification');
                                });
                              },(){reuablebottomsheet(context, "Choose Other Image 1",(){
                                _pickImage(ImageSource.gallery,'other1');
                              },(){
                                _pickImage(ImageSource.camera,'other1');
                              });},
                              (){reuablebottomsheet(context, "Choose Other Image 2",(){
                                _pickImage(ImageSource.gallery,'other2');
                              },(){
                                _pickImage(ImageSource.camera,'other2');
                              });}),
                              reusablaSizaBox(context, 0.010),
                              reusableBtn(context, 'Submit',(){
                                setState(() {
                                  
                                });
                                _uploadData();
                                setState(() {
                                  
                                });
                                }),
                              reusablaSizaBox(context, 0.010),
                            ],
                          ),
                         
                ),
                reusableloadingrow(context, isLoading),
      //         ),
      //       ),
            // if(isLoading == true)
            // reusableloadingrow(context, isLoading),
      //     ],
      //   ),
      // // )
    );
  }
}