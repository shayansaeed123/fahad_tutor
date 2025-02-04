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
  // int doc_error = 0;
  // String docs_msg = '';
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
  // String profile = '';
  // String cnic_f = '';
  // String cnic_b = '';
  // String last_document = '';
  // String other1 = '';
  // String other2 = '';
  TutorRepository repository = TutorRepository();
  // Future<void> documentsAttach() async {
  //   setState(() {
  //     isLoading = true;
  //   });

  //   try {
  //     String url =
  //         '${Utils.baseUrl}get_ducoments.php?code=10&tutors_ids=${MySharedPrefrence().get_user_ID()}';
  //     final response = await http.get(Uri.parse(url));
  //     print('url $url');

  //     if (response.statusCode == 200) {
  //       dynamic jsonResponse = jsonDecode(response.body);
  //     setState(() {
  //         profile = jsonResponse['personal_image'];
  //         cnic_f = jsonResponse['cnic_front'];
  //         cnic_b = jsonResponse['cnic_back'];
  //         last_document = jsonResponse['last_document'];
  //         other1 = jsonResponse['other_1'];
  //         other2 = jsonResponse['other_2'];
  //         doc_error = jsonResponse['docs_error'];
  //         docs_msg = jsonResponse['docs_msg'];
  //         is_term_accepted = jsonResponse['is_term_accepted'];
  //         // MySharedPrefrence().set_profile_img(profile);
  //       });
  //     } else {
  //       print('Error: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     throw Exception(e);
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  Future<void> _pickImage(ImageSource source, String imageType) async {
  final pickedFile = await picker.pickImage(source: source);

  if (pickedFile != null) {
    File? selectedImage;

    setState(() {
      switch (imageType) {
        case 'front':
          _cnicFront = File(pickedFile.path);
          selectedImage = _cnicFront;
          break;
        case 'back':
          _cnicBack = File(pickedFile.path);
          selectedImage = _cnicBack;
          break;
        case 'profile':
          _profile = File(pickedFile.path);
          selectedImage = _profile;
          break;
        case 'qualification':
          _last_document = File(pickedFile.path);
          selectedImage = _last_document;
          break;
        case 'other1':
          _other1 = File(pickedFile.path);
          selectedImage = _other1;
          break;
        case 'other2':
          _other2 = File(pickedFile.path);
          selectedImage = _other2;
          break;
      }
      print(imageType);
    });

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
                  _uploadImages(imageType);
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
  } else {
    print('No image selected');
  }
}

  Future<void> _uploadImages(String imageType) async {
    setState(() {
      isLoading = true;
    });

    try{
      // String uploadUrl = 'https://fahadtutors.com/upload_doc_4.php';
      String uploadUrl = '${Utils.baseUrl}upload_doc_4.php';
    var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));

    switch (imageType) {
      case 'front':
        if (_cnicFront != null) {
          request.files.add(await http.MultipartFile.fromPath('CNIC_F', _cnicFront!.path));
        }
        break;
      case 'back':
        if (_cnicBack != null) {
          request.files.add(await http.MultipartFile.fromPath('CNIC_B', _cnicBack!.path));
        }
        break;
      case 'profile':
        if (_profile != null) {
          request.files.add(await http.MultipartFile.fromPath('profile_pic', _profile!.path));
        }
        break;
      case 'qualification':
        if (_last_document != null) {
          request.files.add(await http.MultipartFile.fromPath('Qualification', _last_document!.path));
        }
        break;
      case 'other1':
        if (_other1 != null) {
          request.files.add(await http.MultipartFile.fromPath('other_1', _other1!.path));
        }
        break;
      case 'other2':
        if (_other2 != null) {
          request.files.add(await http.MultipartFile.fromPath('other_2', _other2!.path));
        }
        break;
    }

    var response = await request.send();

    if (response.statusCode == 200) {
       final responseString = await response.stream.bytesToString();
      final responseData = json.decode(responseString);
      print('Response Data: $responseData');

      // Update state variables based on response
      setState(() {
        switch (imageType) {
          case 'front':
            // cnic_f = responseData['CNIC_F'] ?? cnic_f;
            repository.cnic_f.value = responseData['CNIC_F'] ?? repository.cnic_f.value;
            break;
          case 'back':
            // cnic_b = responseData['CNIC_B'] ?? cnic_b;
            repository.cnic_b.value = responseData['CNIC_B'] ?? repository.cnic_b.value;
            break;
          case 'profile':
            // profile = responseData['profile_pic'] ?? profile;
            repository.profile_image.value = responseData['profile_pic'] ?? repository.profile_image.value;
            break;
          case 'qualification':
            // last_document = responseData['Qualification'] ?? last_document;
            repository.last_document.value = responseData['Qualification'] ?? repository.last_document.value;
            break;
          case 'other1':
            // other1 = responseData['other_1'] ?? other1;
            repository.other_1.value = responseData['other_1'] ?? repository.other_1.value;
            break;
          case 'other2':
            // other2 = responseData['other_2'] ?? other2;
            repository.other_2.value = responseData['other_2'] ?? repository.other_2.value;
            break;
        }
      });
      // print('State Updated: profile=$profile, cnic_f=$cnic_f, cnic_b=$cnic_b, last_document=$last_document, other1=$other1, other2=$other2');
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

  void _validateForm() {
  if (_profile != null &&
      _cnicFront != null &&
      _cnicBack != null &&
      _last_document != null &&
      _profile!.path.isNotEmpty &&
      _cnicFront!.path.isNotEmpty &&
      _cnicBack!.path.isNotEmpty &&
      _last_document!.path.isNotEmpty) {
    _uploadData();
  } else {
    Utils.snakbar(
      context,
      _profile == null || _profile!.path.isEmpty
          ? "Select Profile Image"
          : _cnicFront == null || _cnicFront!.path.isEmpty
              ? "Select CNIC FRONT Image"
              : _cnicBack == null || _cnicBack!.path.isEmpty
                  ? "Select CNIC BACK Image"
                  : _last_document == null || _last_document!.path.isEmpty
                      ? "Select Last Document Image"
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
          Uri.parse('${Utils.baseUrl}step_4_update.php'),
          body: {
        'code': '10',
        'update_status': '4',
        'tutor_id': MySharedPrefrence().get_user_ID().toString(),
        'is_term_accepted': repository.is_term_accept.value.toString(),
        'profile_img': repository.profile_image.value.toString(),
        'cnic_f': repository.cnic_f.value.toString(),
        'cnic_b': repository.cnic_b.value.toString(),
        'last_document': repository.last_document.value.toString(),
        'other_1': repository.other_1.value.toString(),
        'other_2': repository.other_2.value.toString(),
      },);
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final Map<String, dynamic> jsonResponse = json.decode(response.body);
          print('helloooo $jsonResponse');
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
  void initState() {
    super.initState();
    doc();
    repository.check_msg();
    
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
  Widget build(BuildContext context) {
    return 
    reusableprofileidget(context,
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .032),
                  child: 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              reusableText('Documents \nAttachment',color: colorController.blackColor,fontsize: 25,fontweight: FontWeight.bold),
                              reusablaSizaBox(context, 0.020),
                              ValueListenableBuilder(valueListenable: repository.popup, builder: (context, value, child) {
              if(value == 1){
                return reusableVisiblityMesage(context, MySharedPrefrence().get_popup_text(), (){setState(() {visible=false;});}, visible);
                }else{return Container();}
            },),
            reusablaSizaBox(context, 0.020),
                              repository.doc_error.value == 1 ? reusableVisiblityWarning(context, '${repository.doc_msg.value.toString()}', (){setState(() {visible=false;});}, visible) : Container(),
                              reusablaSizaBox(context, 0.020),
                              reusableDocuments(context,'','Add Image (Front)','Add Image (Back)' ,'Profile', 'CNIC Image', 
                              // profile,cnic_f,cnic_b,
                              repository.profile_image.value.toString(),repository.cnic_f.value.toString(),repository.cnic_b.value.toString(),
                               (){
                                reuablebottomsheet(context, "Choose Profile Image",(){
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
                              });},
                              'assets/images/profile.png'
                              ),
                               reusablaSizaBox(context, 0.020),
                              reusableDocuments(context, 'Add Image', '', '', 'Last Qualification Proof', 'Attach other Documents(Optional)', 
                              // last_document ,other1,other2,
                              repository.last_document.value.toString(),repository.other_1.value.toString(),repository.other_2.value.toString(),
                              (){
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
                              });},
                              'assets/images/add_img_placeholder.png'
                              ),
                              reusablaSizaBox(context, 0.010),
                              repository.doc_error.value == 1 ? Container() :
                              reusableBtn(context, 'Submit',(){
                                setState(() {
                                  
                                });
                                _validateForm();
                                setState(() {
                                  
                                });
                                }),
                              reusablaSizaBox(context, 0.010),
                            ],
                          ),
                         
                ),
                reusableloadingrow(context, isLoading),
    );
  }
}