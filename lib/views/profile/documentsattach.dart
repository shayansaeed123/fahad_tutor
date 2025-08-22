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
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

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
  File? _other3;
  File? _other4;
  File? _other5;
  File? _other6;
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

  Future<File> compressImage(File file) async {
  try {
    if (!Platform.isAndroid && !Platform.isIOS) {
      // Web/Desktop fallback
      debugPrint("Compression not supported on this platform");
      return file;
    }

    final dir = await getTemporaryDirectory();
    final targetPath =
        path.join(dir.path, 'temp_${DateTime.now().millisecondsSinceEpoch}_${path.basename(file.path)}');

    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 70,
      minWidth: 1080,
      minHeight: 1080,
    );

    return compressedFile != null ? File(compressedFile.path) : file;
  } catch (e) {
    debugPrint('Compression error: $e');
    return file;
  }
}

Future<void> _pickImage(ImageSource source, String imageType) async {
  try {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) {
      debugPrint('No image selected');
      return;
    }

    File selectedImage = File(pickedFile.path);

    // Compress only if camera
    if (source == ImageSource.camera) {
      selectedImage = await compressImage(selectedImage);
    }

    setState(() {
      switch (imageType) {
        case 'front':
          _cnicFront = selectedImage;
          break;
        case 'back':
          _cnicBack = selectedImage;
          break;
        case 'profile':
          _profile = selectedImage;
          break;
        case 'qualification':
          _last_document = selectedImage;
          break;
        case 'other1':
          _other1 = selectedImage;
          break;
        case 'other2':
          _other2 = selectedImage;
          break;
        case 'other3':
          _other3 = selectedImage;
          break;
        case 'other4':
          _other4 = selectedImage;
          break;
        case 'other5':
          _other5 = selectedImage;
          break;
        case 'other6':
          _other6 = selectedImage;
          break;
      }
    });

    // Preview Dialog
    if (!mounted) return; // safety check
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Image Updated'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.3,
          child: Image.file(selectedImage, fit: BoxFit.contain),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: reusableBtn(context, 'Cancel', () {
              Navigator.of(context).pop();
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: reusableBtn(context, 'Submit', () async {
              await _uploadImages(imageType);
              if (mounted) Navigator.of(context).pop(); // close dialog only
              if (mounted) Navigator.of(context).pop(); // close dialog only
            }),
          ),
        ],
      ),
    );
  } catch (e) {
    debugPrint("Pick Image Error: $e");
  }
}

Future<void> _uploadImages(String imageType) async {
  setState(() {
    isLoading = true;
  });

  try {
    String uploadUrl = '${Utils.baseUrl}upload_doc_4.php';
    var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));

    // Map imageType to file field
    final fileMap = <String, File?>{
      'front': _cnicFront,
      'back': _cnicBack,
      'profile': _profile,
      'qualification': _last_document,
      'other1': _other1,
      'other2': _other2,
      'other3': _other3,
      'other4': _other4,
      'other5': _other5,
      'other6': _other6,
    };

    final fieldMap = <String, String>{
      'front': 'CNIC_F',
      'back': 'CNIC_B',
      'profile': 'profile_pic',
      'qualification': 'Qualification',
      'other1': 'other_1',
      'other2': 'other_2',
      'other3': 'other_3',
      'other4': 'other_4',
      'other5': 'other_5',
      'other6': 'other_6',
    };

    final fileToUpload = fileMap[imageType];
    if (fileToUpload != null) {
      request.files.add(
        await http.MultipartFile.fromPath(fieldMap[imageType]!, fileToUpload.path),
      );
    }

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final responseData = json.decode(responseString);
      debugPrint('Response Data: $responseData');

      setState(() {
        switch (imageType) {
          case 'front':
            repository.cnic_f.value =
                responseData['CNIC_F'] ?? repository.cnic_f.value;
            break;
          case 'back':
            repository.cnic_b.value =
                responseData['CNIC_B'] ?? repository.cnic_b.value;
            break;
          case 'profile':
            repository.profile_image.value =
                responseData['profile_pic'] ?? repository.profile_image.value;
            break;
          case 'qualification':
            repository.last_document.value =
                responseData['Qualification'] ?? repository.last_document.value;
            break;
          case 'other1':
            repository.other_1.value =
                responseData['other_1'] ?? repository.other_1.value;
            break;
          case 'other2':
            repository.other_2.value =
                responseData['other_2'] ?? repository.other_2.value;
            break;
          case 'other3':
            repository.other_3.value =
                responseData['other_3'] ?? repository.other_3.value;
            break;
          case 'other4':
            repository.other_4.value =
                responseData['other_4'] ?? repository.other_4.value;
            break;
          case 'other5':
            repository.other_5.value =
                responseData['other_5'] ?? repository.other_5.value;
            break;
          case 'other6':
            repository.other_6.value =
                responseData['other_6'] ?? repository.other_6.value;
            break;
        }
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Upload failed')));
    }
  } catch (e) {
    debugPrint("Upload Error: $e");
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Error uploading image')));
  } finally {
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }
}


//   Future<void> _pickImage(ImageSource source, String imageType) async {
//   final pickedFile = await picker.pickImage(source: source);

//   if (pickedFile != null) {
//     File? selectedImage;

//     setState(() {
//       switch (imageType) {
//         case 'front':
//           _cnicFront = File(pickedFile.path);
//           selectedImage = _cnicFront;
//           break;
//         case 'back':
//           _cnicBack = File(pickedFile.path);
//           selectedImage = _cnicBack;
//           break;
//         case 'profile':
//           _profile = File(pickedFile.path);
//           selectedImage = _profile;
//           break;
//         case 'qualification':
//           _last_document = File(pickedFile.path);
//           selectedImage = _last_document;
//           break;
//         case 'other1':
//           _other1 = File(pickedFile.path);
//           selectedImage = _other1;
//           break;
//         case 'other2':
//           _other2 = File(pickedFile.path);
//           selectedImage = _other2;
//           break;
//         case 'other3':
//           _other3 = File(pickedFile.path);
//           selectedImage = _other3;
//           break;
//         case 'other4':
//           _other4 = File(pickedFile.path);
//           selectedImage = _other4;
//           break;
//         case 'other5':
//           _other5 = File(pickedFile.path);
//           selectedImage = _other5;
//           break;
//         case 'other6':
//           _other6 = File(pickedFile.path);
//           selectedImage = _other6;
//           break;
//       }
//       print(imageType);
//     });

//     if (selectedImage != null) {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Image Updated'),
//           content: Container(
//             width: MediaQuery.of(context).size.width * 0.3,
//             height: MediaQuery.of(context).size.height * 0.3,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: FileImage(selectedImage!),
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//           actions: [
//             Padding(
//               padding: EdgeInsets.all(5),
//               child: reusableBtn(context, 'Cancel', () {
//                 Navigator.pop(context);
//               }),
//             ),
//             Padding(
//               padding: EdgeInsets.all(5),
//               child: reusableBtn(context, 'Submit', () {
//                 setState(() {
//                   _uploadImages(imageType);
//                 });
//                 Navigator.pop(context);
//                 Navigator.pop(context);
//               }),
//             ),
//           ],
//         ),
//       );
//     } else {
//       print('No image selected');
//     }
//   } else {
//     print('No image selected');
//   }
// }

//   Future<void> _uploadImages(String imageType) async {
//     setState(() {
//       isLoading = true;
//     });

//     try{
//       // String uploadUrl = 'https://fahadtutors.com/upload_doc_4.php';
//       String uploadUrl = '${Utils.baseUrl}upload_doc_4.php';
//     var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));

//     switch (imageType) {
//       case 'front':
//         if (_cnicFront != null) {
//           request.files.add(await http.MultipartFile.fromPath('CNIC_F', _cnicFront!.path));
//         }
//         break;
//       case 'back':
//         if (_cnicBack != null) {
//           request.files.add(await http.MultipartFile.fromPath('CNIC_B', _cnicBack!.path));
//         }
//         break;
//       case 'profile':
//         if (_profile != null) {
//           request.files.add(await http.MultipartFile.fromPath('profile_pic', _profile!.path));
//         }
//         break;
//       case 'qualification':
//         if (_last_document != null) {
//           request.files.add(await http.MultipartFile.fromPath('Qualification', _last_document!.path));
//         }
//         break;
//       case 'other1':
//         if (_other1 != null) {
//           request.files.add(await http.MultipartFile.fromPath('other_1', _other1!.path));
//         }
//         break;
//       case 'other2':
//         if (_other2 != null) {
//           request.files.add(await http.MultipartFile.fromPath('other_2', _other2!.path));
//         }
//         break;
//       case 'other3':
//         if (_other3 != null) {
//           request.files.add(await http.MultipartFile.fromPath('other_3', _other3!.path));
//         }
//         break;
//       case 'other4':
//         if (_other4 != null) {
//           request.files.add(await http.MultipartFile.fromPath('other_4', _other4!.path));
//         }
//         break;
//       case 'other5':
//         if (_other5 != null) {
//           request.files.add(await http.MultipartFile.fromPath('other_5', _other5!.path));
//         }
//         break;
//       case 'other6':
//         if (_other6 != null) {
//           request.files.add(await http.MultipartFile.fromPath('other_6', _other6!.path));
//         }
//         break;
//     }

//     var response = await request.send();

//     if (response.statusCode == 200) {
//        final responseString = await response.stream.bytesToString();
//       final responseData = json.decode(responseString);
//       print('Response Data: $responseData');

//       // Update state variables based on response
//       setState(() {
//         switch (imageType) {
//           case 'front':
//             // cnic_f = responseData['CNIC_F'] ?? cnic_f;
//             repository.cnic_f.value = responseData['CNIC_F'] ?? repository.cnic_f.value;
//             break;
//           case 'back':
//             // cnic_b = responseData['CNIC_B'] ?? cnic_b;
//             repository.cnic_b.value = responseData['CNIC_B'] ?? repository.cnic_b.value;
//             break;
//           case 'profile':
//             // profile = responseData['profile_pic'] ?? profile;
//             repository.profile_image.value = responseData['profile_pic'] ?? repository.profile_image.value;
//             break;
//           case 'qualification':
//             // last_document = responseData['Qualification'] ?? last_document;
//             repository.last_document.value = responseData['Qualification'] ?? repository.last_document.value;
//             break;
//           case 'other1':
//             repository.other_1.value = responseData['other_1'] ?? repository.other_1.value;
//             break;
//           case 'other2':
//             repository.other_2.value = responseData['other_2'] ?? repository.other_2.value;
//             break;
//           case 'other3':
//             repository.other_3.value = responseData['other_3'] ?? repository.other_3.value;
//             break;
//           case 'other4':
//             repository.other_4.value = responseData['other_4'] ?? repository.other_4.value;
//             break;
//           case 'other5':
//             repository.other_5.value = responseData['other_5'] ?? repository.other_5.value;
//             break;
//           case 'other6':
//             repository.other_6.value = responseData['other_6'] ?? repository.other_6.value;
//             break;
//         }
//       });
//       // print('State Updated: profile=$profile, cnic_f=$cnic_f, cnic_b=$cnic_b, last_document=$last_document, other1=$other1, other2=$other2');
//       print(responseData);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Upload failed')),
//       );
//     }
//     }catch(e){
//       print(e);
//     }finally{
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

  void _validateForm() {
  if (repository.profile_image.value != 'https://www.fahadtutors.com/fta_admin/' &&
      repository.cnic_f.value != 'https://www.fahadtutors.com/fta_admin/' &&
      repository.cnic_b.value != 'https://www.fahadtutors.com/fta_admin/' &&
      repository.last_document.value != 'https://www.fahadtutors.com/fta_admin/' &&
      repository.profile_image.value.isNotEmpty &&
      repository.cnic_f.value.isNotEmpty &&
      repository.cnic_b.value.isNotEmpty &&
      repository.last_document.value.isNotEmpty) {
    _uploadData();
  } else {
    Utils.snakbar(
      context,
      repository.profile_image.value == 'https://www.fahadtutors.com/fta_admin/' || repository.profile_image.value.isEmpty
          ? "Select Profile Image"
          : repository.cnic_f.value == 'https://www.fahadtutors.com/fta_admin/' || repository.cnic_f.value.isEmpty
              ? "Select CNIC FRONT Image"
              : repository.cnic_b.value == 'https://www.fahadtutors.com/fta_admin/' || repository.cnic_b.value.isEmpty
                  ? "Select CNIC BACK Image"
                  : repository.last_document.value == 'https://www.fahadtutors.com/fta_admin/' || repository.last_document.value.isEmpty
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
        'other_3': repository.other_3.value.toString(),
        'other_4': repository.other_4.value.toString(),
        'other_5': repository.other_5.value.toString(),
        'other_6': repository.other_6.value.toString(),
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
    print(MySharedPrefrence().get_user_ID());
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
                              reusableDocuments1(context, '', 'Profile', repository.profile_image.value.toString(), 
                              (){
                                reuablebottomsheet(context, "Choose Profile Image",(){
                                  _pickImage(ImageSource.gallery, 'profile');
                                },(){
                                  _pickImage(ImageSource.camera,'profile');
                                });
                              }, 'assets/images/profile.png'),
                              // reusableDocuments(context,'','Add Image (Front)','Add Image (Back)' ,'Profile', 'CNIC Image', 
                              // // profile,cnic_f,cnic_b,
                              // repository.profile_image.value.toString(),repository.cnic_f.value.toString(),repository.cnic_b.value.toString(),
                              //  (){
                              //   reuablebottomsheet(context, "Choose Profile Image",(){
                              //     _pickImage(ImageSource.gallery, 'profile');
                              //   },(){
                              //     _pickImage(ImageSource.camera,'profile');
                              //   });
                              // },(){reuablebottomsheet(context, "Choose CNIC Front Image",(){
                              //     _pickImage(ImageSource.gallery,'front');
                              // },(){
                              //     _pickImage(ImageSource.camera,'front');
                              // });},
                              // (){reuablebottomsheet(context, "Choose CNIC Back Image",(){
                              //     _pickImage(ImageSource.gallery,'back');
                              // },(){
                              //     _pickImage(ImageSource.camera,'back');
                              // });},
                              // 'assets/images/profile.png'
                              // ),
                               reusablaSizaBox(context, 0.010),
                               reusableDocuments2(context, 'Add Image (Front)','Add Image (Back)', 'CNIC Image', repository.cnic_f.value.toString(),repository.cnic_b.value.toString(), 
                               (){reuablebottomsheet(context, "Choose CNIC Front Image",(){
                                  _pickImage(ImageSource.gallery,'front');
                              },(){
                                  _pickImage(ImageSource.camera,'front');
                              });},
                              (){reuablebottomsheet(context, "Choose CNIC Back Image",(){
                                  _pickImage(ImageSource.gallery,'back');
                              },(){
                                  _pickImage(ImageSource.camera,'back');
                              });},
                               'assets/images/add_img_placeholder.png'),
                              // reusableDocuments(context, 'Add Image', '', '', 'Last Qualification Proof', 'Attach other Documents(Optional)', 
                              // // last_document ,other1,other2,
                              // repository.last_document.value.toString(),repository.other_1.value.toString(),repository.other_2.value.toString(),
                              // (){
                              //   reuablebottomsheet(context, "Choose Qualification Image",(){
                              //     _pickImage(ImageSource.gallery,'qualification');
                              //   },(){
                              //     _pickImage(ImageSource.camera,'qualification');
                              //   });
                              // },(){reuablebottomsheet(context, "Choose Other Image 1",(){
                              //   _pickImage(ImageSource.gallery,'other1');
                              // },(){
                              //   _pickImage(ImageSource.camera,'other1');
                              // });},
                              // (){reuablebottomsheet(context, "Choose Other Image 2",(){
                              //   _pickImage(ImageSource.gallery,'other2');
                              // },(){
                              //   _pickImage(ImageSource.camera,'other2');
                              // });},
                              // 'assets/images/add_img_placeholder.png'
                              // ),
                              reusablaSizaBox(context, 0.020),
                              reusableDocuments1(context, 'Add Image', 'Last Qualification Proof', repository.last_document.value.toString(), 
                              (){
                                reuablebottomsheet(context, "Choose Qualification Image",(){
                                  _pickImage(ImageSource.gallery,'qualification');
                                },(){
                                  _pickImage(ImageSource.camera,'qualification');
                                });
                              }, 'assets/images/add_img_placeholder.png'),
                              reusablaSizaBox(context, 0.010),
                              reusableDocuments2(context, '','', 'Attach other Documents(Optional)', repository.other_1.value.toString(),repository.other_2.value.toString(),
                               (){reuablebottomsheet(context, "Choose Other Image 1",(){
                                _pickImage(ImageSource.gallery,'other1');
                              },(){
                                _pickImage(ImageSource.camera,'other1');
                              });},
                              (){reuablebottomsheet(context, "Choose Other Image 2",(){
                                _pickImage(ImageSource.gallery,'other2');
                              },(){
                                _pickImage(ImageSource.camera,'other2');
                              });},
                               'assets/images/add_img_placeholder.png'),
                              reusableDocuments2(context, '','', '', repository.other_3.value.toString(),repository.other_4.value.toString(),
                               (){reuablebottomsheet(context, "Choose Other Image 3",(){
                                _pickImage(ImageSource.gallery,'other3');
                              },(){
                                _pickImage(ImageSource.camera,'other3');
                              });},
                              (){reuablebottomsheet(context, "Choose Other Image 4",(){
                                _pickImage(ImageSource.gallery,'other4');
                              },(){
                                _pickImage(ImageSource.camera,'other4');
                              });},
                               'assets/images/add_img_placeholder.png'),
                              reusableDocuments2(context, '','', '', repository.other_5.value.toString(),repository.other_6.value.toString(),
                               (){reuablebottomsheet(context, "Choose Other Image 5",(){
                                _pickImage(ImageSource.gallery,'other5');
                              },(){
                                _pickImage(ImageSource.camera,'other5');
                              });},
                              (){reuablebottomsheet(context, "Choose Other Image 6",(){
                                _pickImage(ImageSource.gallery,'other6');
                              },(){
                                _pickImage(ImageSource.camera,'other6');
                              });},
                               'assets/images/add_img_placeholder.png'),
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