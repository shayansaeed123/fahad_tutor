import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/controller/repo_provider.dart';
import 'package:fahad_tutor/controller/text_field_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/model/documentmodel.dart';
import 'package:fahad_tutor/repo/classmodel.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableTextField.dart';
import 'package:fahad_tutor/res/reusablebottomsheet.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusabledocuments.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusableselecteditem.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/res/reusablevisibility.dart';
import 'package:fahad_tutor/views/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

// Extension to group list items by a key
extension GroupBy<T> on Iterable<T> {
  Map<K, List<T>> groupBy<K>(K Function(T) keyFn) {
    final Map<K, List<T>> map = {};
    for (var element in this) {
      final key = keyFn(element);
      map.putIfAbsent(key, () => []).add(element);
    }
    return map;
  }
}

class Qualification extends ConsumerStatefulWidget {
  const Qualification({super.key});

  @override
  ConsumerState<Qualification> createState() => _QualificationState();
}

class _QualificationState extends ConsumerState<Qualification> {
  bool isLoading = false;
  bool visible = true;
  final picker = ImagePicker();
  // TutorRepository repository = TutorRepository();
  

  File? _proof1;
  File? _proof2;
  File? _proof3;

//   Future<File> compressImage(File file) async {
//   try {
//     if (!Platform.isAndroid && !Platform.isIOS) {
//       // Web/Desktop fallback
//       debugPrint("Compression not supported on this platform");
//       return file;
//     }

//     final dir = await getTemporaryDirectory();
//     final targetPath =
//         path.join(dir.path, 'temp_${DateTime.now().millisecondsSinceEpoch}_${path.basename(file.path)}');

//     final compressedFile = await FlutterImageCompress.compressAndGetFile(
//       file.absolute.path,
//       targetPath,
//       quality: 70,
//       minWidth: 1080,
//       minHeight: 1080,
//     );

//     return compressedFile != null ? File(compressedFile.path) : file;
//   } catch (e) {
//     debugPrint('Compression error: $e');
//     return file;
//   }
// }


// Future<void> _pickImage(ImageSource source, String imageType) async {
//   try {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: source);

//     if (pickedFile == null) {
//       debugPrint('No image selected');
//       return;
//     }

//     File selectedImage = File(pickedFile.path);

//     // Compress only if camera
//     if (source == ImageSource.camera) {
//       selectedImage = await compressImage(selectedImage);
//     }

//     setState(() {
//       switch (imageType) {
//         case 'proof1':
//           _proof1 = selectedImage;
//           break;
//         case 'proof2':
//           _proof2 = selectedImage;
//           break;
//         case 'proof3':
//           _proof3 = selectedImage;
//           break;
//       }
//     });

//     // Preview Dialog
//     if (!mounted) return; // safety check
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Image Updated'),
//         content: SizedBox(
//           width: MediaQuery.of(context).size.width * 0.3,
//           height: MediaQuery.of(context).size.height * 0.3,
//           child: Image.file(selectedImage, fit: BoxFit.contain),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(5),
//             child: reusableBtn(context, 'Cancel', () {
//               Navigator.of(context).pop();
//             }),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(5),
//             child: reusableBtn(context, 'Submit', () async {
//               await _uploadImages(imageType);
//               if (mounted) Navigator.of(context).pop(); // close dialog only
//               if (mounted) Navigator.of(context).pop(); // close dialog only
//             }),
//           ),
//         ],
//       ),
//     );
//   } catch (e) {
//     debugPrint("Pick Image Error: $e");
//   }
// }


// Future<void> _uploadImages(String imageType) async {
//   setState(() {
//     isLoading = true;
//   });

//   try {
//     String uploadUrl = '${Utils.baseUrl}upload_doc_4.php';
//     var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));

//     // Map imageType to file field
//     final fileMap = <String, File?>{
//       'proof1': _proof1,
//       'proof2': _proof2,
//       'proof3': _proof3,
//     };

//     final fieldMap = <String, String>{
//       'proof1': 'proof1',
//       'proof2': 'proof2',
//       'proof3': 'proof3',
//     };

//     final fileToUpload = fileMap[imageType];
//     if (fileToUpload != null) {
//       request.files.add(
//         await http.MultipartFile.fromPath(fieldMap[imageType]!, fileToUpload.path),
//       );
//     }

//     final response = await request.send();

//     if (response.statusCode == 200) {
//       final responseString = await response.stream.bytesToString();
//       final responseData = json.decode(responseString);
//       debugPrint('Response Data: $responseData');

//       setState(() {
//         switch (imageType) {
//           case 'proof1':
//             repository.proof_image1.value =
//                 responseData['proof1'] ?? repository.proof_image1.value;
//             break;
//           case 'proof2':
//             repository.proof_image2.value =
//                 responseData['proof2'] ?? repository.proof_image2.value;
//             break;
//           case 'proof3':
//             repository.proof_image3.value =
//                 responseData['proof3'] ?? repository.proof_image3.value;
//             break;
//         }
//       });
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text('Upload failed')));
//     }
//   } catch (e) {
//     debugPrint("Upload Error: $e");
//     ScaffoldMessenger.of(context)
//         .showSnackBar(const SnackBar(content: Text('Error uploading image')));
//   } finally {
//     if (mounted) {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
// }


// List<dynamic> newItemsinstitute1 = [];
// List<Map<String, String>> selectedIdsinstitute1 = [];
// List<String> selectedNamesinstitute1 = [];

List<dynamic> newItemsQualification1 = [];
List<Map<String, String>> selectedIdsQualification1 = [];
List<String> selectedNamesQualification1 = [];

// List<dynamic> newItemsinstitute2 = [];
// List<Map<String, String>> selectedIdsinstitute2 = [];
// List<String> selectedNamesinstitute2 = [];

List<dynamic> newItemsQualification2 = [];
List<Map<String, String>> selectedIdsQualification2 = [];
List<String> selectedNamesQualification2 = [];


// List<dynamic> newItemsinstitute3 = [];
// List<Map<String, String>> selectedIdsinstitute3 = [];
// List<String> selectedNamesinstitute3 = [];

List<dynamic> newItemsQualification3 = [];
List<Map<String, String>> selectedIdsQualification3 = [];
List<String> selectedNamesQualification3 = [];

late TutorRepository repository;


@override
  void initState() {
    super.initState();
    repository = ref.read(tutorRepositoryProvider);
    repository.Check_popup();
    // repository.fetchData('Institute','Institute', newItemsinstitute1, selectedIdsinstitute1, updateSelectedNamesInstitute1,(val)=> setState(() {isLoading = val;}));
    repository.fetchData('Qualification1','Qualification', newItemsQualification1, selectedIdsQualification1, updateSelectedNamesQualification1,(val)=> setState(() {isLoading = val;}));
    // repository.fetchData('Institute','Institute', newItemsinstitute2, selectedIdsinstitute2, updateSelectedNamesInstitute2,(val)=> setState(() {isLoading = val;}));
    repository.fetchData('Qualification2','Qualification', newItemsQualification2, selectedIdsQualification2, updateSelectedNamesQualification2,(val)=> setState(() {isLoading = val;}));
    // repository.fetchData('Institute','Institute', newItemsinstitute3, selectedIdsinstitute3, updateSelectedNamesInstitute3,(val)=> setState(() {isLoading = val;}));
    repository.fetchData('Qualification3','Qualification', newItemsQualification3, selectedIdsQualification3, updateSelectedNamesQualification3,(val)=> setState(() {isLoading = val;}));
    saveQualificationData();
    repository.check_msg();
    allFunction();
  }
  void allFunction()async{
    //  repository.fetchData('Institute','Institute', newItemsinstitute1, selectedIdsinstitute1, updateSelectedNamesInstitute1,(val)=> setState(() {isLoading = val;}));
     repository.fetchData('Qualification1','Qualification', newItemsQualification1, selectedIdsQualification1, updateSelectedNamesQualification1,(val)=> setState(() {isLoading = val;}));
    //  repository.fetchData('Institute','Institute', newItemsinstitute2, selectedIdsinstitute2, updateSelectedNamesInstitute2,(val)=> setState(() {isLoading = val;}));
    repository.fetchData('Qualification2','Qualification', newItemsQualification2, selectedIdsQualification2, updateSelectedNamesQualification2,(val)=> setState(() {isLoading = val;}));
    // repository.fetchData('Institute','Institute', newItemsinstitute3, selectedIdsinstitute3, updateSelectedNamesInstitute3,(val)=> setState(() {isLoading = val;}));
    repository.fetchData('Qualification3','Qualification', newItemsQualification3, selectedIdsQualification3, updateSelectedNamesQualification3,(val)=> setState(() {isLoading = val;}));
    await saveQualificationData();
    await repository.check_msg();
  }

  bool isFilled(String? value) {
  return value != null && value.trim().isNotEmpty;
}

  void _validateForm() {

  bool isValidField(String? value) {
    return value != null &&
        value.isNotEmpty &&
        value != "0" &&
        value.toLowerCase() != "null" &&
        value != "Select Experience";
  }

  if (reusabletextfieldcontroller.institute1.text.isNotEmpty &&
      selectedIdsQualification1.isNotEmpty) {
    updateStatus();
  } else {
    Utils.snakbar(
      context,
      reusabletextfieldcontroller.institute1.text.isEmpty
          ? "Select Atleast 1 Institute"
          : selectedIdsQualification1.isEmpty
              ? "Select Atleast 1 Qualification"
              : "Fill Correct Fields",
    );
  }
}


  
  Future<void> updateStatus() async {
    setState(() {
      isLoading = true;
    });

    try {


      List<Map<String, dynamic>> qualificationId1 = selectedIdsQualification1.map((qualif) {
        return {'Qualification_id': qualif['id']};
      }).toList();
      String qualificationjson1 = jsonEncode(qualificationId1);


      // List<Map<String, dynamic>> institude_id1 = selectedIdsinstitute1.map((institute) {
      //   return {'Institute_id': institute['id']};
      // }).toList();
      // String institudejson1 = jsonEncode(institude_id1);

      List<Map<String, dynamic>> qualificationId2 = selectedIdsQualification2.map((qualif) {
        return {'Qualification_id': qualif['id']};
      }).toList();
      String qualificationjson2 = jsonEncode(qualificationId2);


      // List<Map<String, dynamic>> institude_id2 = selectedIdsinstitute2.map((institute) {
      //   return {'Institute_id': institute['id']};
      // }).toList();
      // String institudejson2 = jsonEncode(institude_id2);

      List<Map<String, dynamic>> qualificationId3 = selectedIdsQualification3.map((qualif) {
        return {'Qualification_id': qualif['id']};
      }).toList();
      String qualificationjson3 = jsonEncode(qualificationId3);


      // List<Map<String, dynamic>> institude_id3 = selectedIdsinstitute3.map((institute) {
      //   return {'Institute_id': institute['id']};
      // }).toList();
      // String institudejson3 = jsonEncode(institude_id3);
      // final repositoryy = ref.read(tutorRepositoryProvider);

      print('year ${year.toString()}');
      print('deg1 ${qualificationjson1}');
      print('deg2 ${qualificationjson2}');
      print('deg3 ${qualificationjson3}');
      print('ins1 ${reusabletextfieldcontroller.institute1.text}');
      print('ins2 ${reusabletextfieldcontroller.institute2.text}');
      print('ins3 ${reusabletextfieldcontroller.institute3.text}');
      print('p1 ${repository.proof_image1.value.toString()}');
      print('p2 ${repository.proof_image2.value.toString()}');
      print('p3 ${repository.proof_image3.value.toString()}');

      Map<String, String> body = {
        'code': '10',
        'update_status': MySharedPrefrence().get_update_status(),
        'tutor_id_edit': MySharedPrefrence().get_user_ID(),
        'startyear': year.toString(),
        'Degree1': qualificationjson1,
        'Institute1': reusabletextfieldcontroller.institute1.text,
        'proof1': repository.proof_image1.value.toString(),
        'Degree2': qualificationjson2,
        'Institute2': reusabletextfieldcontroller.institute2.text,
        'proof2': repository.proof_image2.value.toString(),
        'Degree3': qualificationjson3,
        'Institute3': reusabletextfieldcontroller.institute3.text,
        'proof3': repository.proof_image3.value.toString(),
      };
      final response = await http.post(
        Uri.parse('${Utils.baseUrl}qualification_update.php'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      print(response.body.toString());
      
      if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print('updateeeeeeeeeeeeeeeeeeeeeeeee $responseData');
      if (responseData['success'] == 1) {
        // Refetch data to update UI with the latest data
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Profile(),));
        // Utils.snakbarSuccess(context, apiMessage);
      } else {
        print('Error in response data: ${responseData['message']}');
      }
    } else {
      print('Error2: ' + response.statusCode.toString());
    }
  } catch (e) {
    print('error $e');
  } finally {
    setState(() {
      isLoading = false;
    });
  }
  }
 

Future<void> saveQualificationData() async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}qualification_select.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}'),
    );
    print('tutuor id ${MySharedPrefrence().get_user_ID()}');
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

          // selectedIdsinstitute1 = (jsonResponse['Institute_listing'] as List)
          //     .map<Map<String, String>>((item) => {'id': item['id'].toString()})
          //     .toList();

          selectedIdsQualification1 = (jsonResponse['Institute_Qualification1'] as List)
              .map<Map<String, String>>((item) => {'id': item['id'].toString()})
              .toList();

          // selectedIdsinstitute2 = (jsonResponse['Institute_listing'] as List)
          //     .map<Map<String, String>>((item) => {'id': item['id'].toString()})
          //     .toList();
              
          selectedIdsQualification2 = (jsonResponse['Institute_Qualification2'] as List)
              .map<Map<String, String>>((item) => {'id': item['id'].toString()})
              .toList();

          // selectedIdsinstitute3 = (jsonResponse['Institute_listing'] as List)
          //     .map<Map<String, String>>((item) => {'id': item['id'].toString()})
          //     .toList();

          selectedIdsQualification3 = (jsonResponse['Institute_Qualification3'] as List)
              .map<Map<String, String>>((item) => {'id': item['id'].toString()})
              .toList();    
          
          // updateSelectedNamesInstitute1();
          updateSelectedNamesQualification1();
          // updateSelectedNamesInstitute2();
          updateSelectedNamesQualification2();
          // updateSelectedNamesInstitute3();
          updateSelectedNamesQualification3();
        // });
      } else {
        throw Exception('Empty response body');
      }
    } else {
      throw Exception('Failed to load country details');
    }
  } catch (e) {
    print('gfksgdf$e');
  }
}


  



  // void updateSelectedNamesInstitute1() {
  // selectedNamesinstitute1 = selectedIdsinstitute1.map((selected) {
  //   return (newItemsinstitute1.firstWhere(
  //     (item) => item['id'] == selected['id'],
  //     orElse: () => {'names': 'Unknown'},
  //   )['names'] as String);
  // }).toList();
  // }

void updateSelectedNamesQualification1() {
  selectedNamesQualification1 = selectedIdsQualification1.map((selected) {
    return (newItemsQualification1.firstWhere(
      (item) => item['id1'] == selected['id1'],
      orElse: () => {'degree_title1': 'Unknown'},
    )['degree_title1'] as String);
  }).toList();
}

// void updateSelectedNamesInstitute2() {
//   selectedNamesinstitute2 = selectedIdsinstitute2.map((selected) {
//     return (newItemsinstitute2.firstWhere(
//       (item) => item['id'] == selected['id'],
//       orElse: () => {'names': 'Unknown'},
//     )['names'] as String);
//   }).toList();
//   }

void updateSelectedNamesQualification2() {
  selectedNamesQualification2 = selectedIdsQualification2.map((selected) {
    return (newItemsQualification2.firstWhere(
      (item) => item['id2'] == selected['id2'],
      orElse: () => {'degree_title2': 'Unknown'},
    )['degree_title2'] as String);
  }).toList();
}

// void updateSelectedNamesInstitute3() {
//   selectedNamesinstitute3 = selectedIdsinstitute3.map((selected) {
//     return (newItemsinstitute3.firstWhere(
//       (item) => item['id'] == selected['id'],
//       orElse: () => {'names': 'Unknown'},
//     )['names'] as String);
//   }).toList();
//   }

void updateSelectedNamesQualification3() {
  selectedNamesQualification3 = selectedIdsQualification3.map((selected) {
    return (newItemsQualification3.firstWhere(
      (item) => item['id3'] == selected['id3'],
      orElse: () => {'degree_title3': 'Unknown'},
    )['degree_title3'] as String);
  }).toList();
}



void toggleSelection(String id, String name, String itemType) {
  setState(() {
    List<Map<String, String>> selectedIds;
    List<String> selectedNames;
    List<dynamic> newItems;
    Function updateSelectedNames;

    switch (itemType) {
      // case 'names':
      //   selectedIds = selectedIdsinstitute1;
      //   selectedNames = selectedNamesinstitute1;
      //   newItems = newItemsinstitute1;
      //   updateSelectedNames = updateSelectedNamesInstitute1;
      //   break;
      case 'degree_title1':
        selectedIds = selectedIdsQualification1;
        selectedNames = selectedNamesQualification1;
        newItems = newItemsQualification1;
        updateSelectedNames = updateSelectedNamesQualification1;
        break;
      // case 'names':
      //   selectedIds = selectedIdsinstitute2;
      //   selectedNames = selectedNamesinstitute2;
      //   newItems = newItemsinstitute2;
      //   updateSelectedNames = updateSelectedNamesInstitute2;
      //   break;
      case 'degree_title2':
        selectedIds = selectedIdsQualification2;
        selectedNames = selectedNamesQualification2;
        newItems = newItemsQualification2;
        updateSelectedNames = updateSelectedNamesQualification2;
        break;
      // case 'names':
      //   selectedIds = selectedIdsinstitute3;
      //   selectedNames = selectedNamesinstitute3;
      //   newItems = newItemsinstitute3;
      //   updateSelectedNames = updateSelectedNamesInstitute3;
      //   break;
      case 'degree_title3':
        selectedIds = selectedIdsQualification3;
        selectedNames = selectedNamesQualification3;
        newItems = newItemsQualification3;
        updateSelectedNames = updateSelectedNamesQualification3;
        break;
      default:
        return;
    }

    if (selectedIds.any((element) => element['id'] == id)) {
      selectedIds.removeWhere((element) => element['id'] == id);
      selectedNames.remove(name);
    } else {
      // Check length constraint only for 'names' and 'degree_title'
      if (itemType == 'names' || itemType == 'degree_title1' || itemType == 'degree_title2' || itemType == 'degree_title3') {
        if (selectedIds.length < 1) {
          selectedIds.add({'id': id});
          selectedNames.add(name);
        } else {
          Utils.snakbar(context, 'Select only 1');
        }
      } else if (itemType == 'course_name') {
        if (selectedIds.length < 6) {
          selectedIds.add({'id': id});
          selectedNames.add(name);
        } else {
          Utils.snakbar(context, 'Select only 6');
        }
      } else {
        selectedIds.add({'id': id});
        selectedNames.add(name);
      }
    }

    updateSelectedNames();
  });
}

void showCustomSnackbar(BuildContext context, String message) {
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 20.0,
      left: 20.0,
      right: 20.0,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          decoration: BoxDecoration(
            color: Color(0xFFbe0000),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );

  // Insert the OverlayEntry into the Overlay
  Overlay.of(context)?.insert(overlayEntry);

  // Remove the overlay after a delay
  Future.delayed(Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}
  

                   int? year;
@override
  Widget build(BuildContext context) {
    final state = ref.watch(documentsAttachProvider);
    final controller = ref.read(documentsAttachProvider.notifier);
    return Scaffold(
      backgroundColor: colorController.whiteColor,
    appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,
    leading: Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
      child: InkWell(
        onTap: (){Navigator.pop(context);},
        child: Image.asset('assets/images/gradient_back.png',fit: BoxFit.contain,height: MediaQuery.of(context).size.height * 0.02,)),
    ),),
  body: SafeArea(
    child: Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .032),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (){},
                    child: Text("Qualification",
      style: TextStyle(
        color: colorController.blackColor,
        fontSize: 25,
        fontWeight: FontWeight.bold,
        fontFamily: 'tutorPhi'
        
      ),)),
      
                  reusablaSizaBox(context, 0.020),
                  ValueListenableBuilder(valueListenable: repository.popup, builder: (context, value, child) {
              if(value == 1){
                return reusableVisiblityMesage(context, MySharedPrefrence().get_popup_text(), (){setState(() {visible=false;});}, visible);
                }else{return Container();}
            },),
                  reusablaSizaBox(context, 0.020),
                  reusableText("OnGoing", color: colorController.blackColor, fontsize: 21),
                   reusablaSizaBox(context, 0.020),
                    reusableSelectYear(
                      context,
                      "Select Start Year",
                      year,
                      (y) {
                        setState(() {
                          year = y;
                        print(year);
                        });
                      },
                    ),
                   reusablaSizaBox(context, 0.020),
                   reusablemultilineTextField(reusabletextfieldcontroller.institute1, 5, 'Institute Name'),
                  // reusablequlification(context, 'Institute', () {
                  //   repository.search(context, newItemsinstitute1, selectedIdsinstitute1, 'names',toggleSelection);
                  // }),
                  // reusablaSizaBox(context, .020),
                  // Container(
                  //   constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.3),
                  //   child: ListView.builder(
                  //     shrinkWrap: true,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     itemCount: selectedNamesinstitute1.length,
                  //     itemBuilder: (context, index) {
                  //       return Container(
                  //         margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .012),
                  //         padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .05, vertical: MediaQuery.of(context).size.height * .01),
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(15),
                  //           color: colorController.qualificationItemsColors,
                  //         ),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Expanded(
                  //               child: Text(
                  //                 selectedNamesinstitute1[index],
                  //                 softWrap: true,
                  //                 overflow: TextOverflow.ellipsis,
                  //                 maxLines: 1,
                  //                 style: TextStyle(fontSize: 13, color: colorController.whiteColor),
                  //               ),
                  //             ),
                  //             InkWell(
                  //               onTap: () {
                  //                 setState(() {
                  //                   // Remove the selected item from the list
                  //                   selectedIdsinstitute1.removeAt(index);
                  //                   selectedNamesinstitute1.removeAt(index);
                  //                   // updateSelectedNames(); // Update the names here
                  //                   print('idddddddddddddd $selectedIdsinstitute1');
                  //                 });
                  //               },
                  //               child: Icon(Icons.cancel_outlined, color: colorController.whiteColor,size: MediaQuery.of(context).size.width*.050,),
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  reusablaSizaBox(context, .020),
                  reusablequlification(context, 'Qualification', () {
                    repository.search(context, newItemsQualification1, selectedIdsQualification1, 'degree_title1',toggleSelection);
                  }),
                  reusablaSizaBox(context, .020),
                  Container(
                    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.3),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: selectedNamesQualification1.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .012),
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .05, vertical: MediaQuery.of(context).size.height * .01),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: colorController.qualificationItemsColors,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  selectedNamesQualification1[index],
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 13, color: colorController.whiteColor),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    // Remove the selected item from the list
                                    selectedIdsQualification1.removeAt(index);
                                    selectedNamesQualification1.removeAt(index);
                                    // updateSelectedNames(); // Update the names here
                                  });
                                },
                                child: Icon(Icons.cancel_outlined, color: colorController.whiteColor,size: MediaQuery.of(context).size.width*.050,),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  reusablaSizaBox(context, 0.020),
                  reusableDocuments1(context, '', 'Proof', state.proof1 != null
              ? state.proof1!.path
              : repository.proof_image1.value.toString(),
                              (){
                                reuablebottomsheet(context, "Choose Profile Image",(){
                                  // _pickImage(ImageSource.gallery, 'profile');
                                  controller.pickImage(context, 'proof1', ImageSource.gallery);
                                },(){
                                  // _pickImage(ImageSource.camera,'profile');
                                  controller.pickImage(context, 'proof1', ImageSource.camera);
                                });
                                // controller.showImagePickerSheet(context, 'profile');
                              }, 'assets/images/add_img_placeholder.png'),
                  reusablaSizaBox(context, 0.020),
                  reusableText("Intermediate", color: colorController.blackColor, fontsize: 21),
                   reusablaSizaBox(context, 0.020),
                   reusablemultilineTextField(reusabletextfieldcontroller.institute2, 5, 'Institute Name'),
                  // reusablequlification(context, 'Institute', () {
                  //   repository.search(context, newItemsinstitute2, selectedIdsinstitute2, 'names',toggleSelection);
                  // }),
                  // reusablaSizaBox(context, .020),
                  // Container(
                  //   constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.3),
                  //   child: ListView.builder(
                  //     shrinkWrap: true,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     itemCount: selectedNamesinstitute2.length,
                  //     itemBuilder: (context, index) {
                  //       return Container(
                  //         margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .012),
                  //         padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .05, vertical: MediaQuery.of(context).size.height * .01),
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(15),
                  //           color: colorController.qualificationItemsColors,
                  //         ),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Expanded(
                  //               child: Text(
                  //                 selectedNamesinstitute2[index],
                  //                 softWrap: true,
                  //                 overflow: TextOverflow.ellipsis,
                  //                 maxLines: 1,
                  //                 style: TextStyle(fontSize: 13, color: colorController.whiteColor),
                  //               ),
                  //             ),
                  //             InkWell(
                  //               onTap: () {
                  //                 setState(() {
                  //                   // Remove the selected item from the list
                  //                   selectedIdsinstitute2.removeAt(index);
                  //                   selectedNamesinstitute2.removeAt(index);
                  //                   // updateSelectedNames(); // Update the names here
                  //                   print('idddddddddddddd $selectedIdsinstitute2');
                  //                 });
                  //               },
                  //               child: Icon(Icons.cancel_outlined, color: colorController.whiteColor,size: MediaQuery.of(context).size.width*.050,),
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  reusablaSizaBox(context, .020),
                  reusablequlification(context, 'Qualification', () {
                    repository.search(context, newItemsQualification2, selectedIdsQualification2, 'degree_title2',toggleSelection);
                  }),
                  reusablaSizaBox(context, .020),
                  Container(
                    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.3),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: selectedNamesQualification2.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .012),
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .05, vertical: MediaQuery.of(context).size.height * .01),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: colorController.qualificationItemsColors,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  selectedNamesQualification2[index],
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 13, color: colorController.whiteColor),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    // Remove the selected item from the list
                                    selectedIdsQualification2.removeAt(index);
                                    selectedNamesQualification2.removeAt(index);
                                    // updateSelectedNames(); // Update the names here
                                  });
                                },
                                child: Icon(Icons.cancel_outlined, color: colorController.whiteColor,size: MediaQuery.of(context).size.width*.050,),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  reusablaSizaBox(context, 0.020),
                  reusableDocuments1(context, '', 'Proof', state.proof2 != null
              ? state.proof2!.path
              : repository.proof_image2.value.toString(),
                              (){
                                reuablebottomsheet(context, "Choose Profile Image",(){
                                  // _pickImage(ImageSource.gallery, 'profile');
                                  controller.pickImage(context, 'proof2', ImageSource.gallery);
                                },(){
                                  // _pickImage(ImageSource.camera,'profile');
                                  controller.pickImage(context, 'proof2', ImageSource.camera);
                                });
                                // controller.showImagePickerSheet(context, 'profile');
                              }, 'assets/images/add_img_placeholder.png'),
                  reusablaSizaBox(context, 0.020),
                  reusableText("Higher Education", color: colorController.blackColor, fontsize: 21),
                   reusablaSizaBox(context, 0.020),
                   reusablemultilineTextField(reusabletextfieldcontroller.institute3, 5, 'Institute Name'),
                  // reusablequlification(context, 'Institute', () {
                  //   repository.search(context, newItemsinstitute3, selectedIdsinstitute3, 'names',toggleSelection);
                  // }),
                  // reusablaSizaBox(context, .020),
                  // Container(
                  //   constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.3),
                  //   child: ListView.builder(
                  //     shrinkWrap: true,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     itemCount: selectedNamesinstitute3.length,
                  //     itemBuilder: (context, index) {
                  //       return Container(
                  //         margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .012),
                  //         padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .05, vertical: MediaQuery.of(context).size.height * .01),
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(15),
                  //           color: colorController.qualificationItemsColors,
                  //         ),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Expanded(
                  //               child: Text(
                  //                 selectedNamesinstitute3[index],
                  //                 softWrap: true,
                  //                 overflow: TextOverflow.ellipsis,
                  //                 maxLines: 1,
                  //                 style: TextStyle(fontSize: 13, color: colorController.whiteColor),
                  //               ),
                  //             ),
                  //             InkWell(
                  //               onTap: () {
                  //                 setState(() {
                  //                   // Remove the selected item from the list
                  //                   selectedIdsinstitute3.removeAt(index);
                  //                   selectedNamesinstitute3.removeAt(index);
                  //                   // updateSelectedNames(); // Update the names here
                  //                   print('idddddddddddddd $selectedIdsinstitute3');
                  //                 });
                  //               },
                  //               child: Icon(Icons.cancel_outlined, color: colorController.whiteColor,size: MediaQuery.of(context).size.width*.050,),
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  reusablaSizaBox(context, .020),
                  reusablequlification(context, 'Qualification', () {
                    repository.search(context, newItemsQualification3, selectedIdsQualification3, 'degree_title3',toggleSelection);
                  }),
                  reusablaSizaBox(context, .020),
                  Container(
                    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.3),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: selectedNamesQualification3.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .012),
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .05, vertical: MediaQuery.of(context).size.height * .01),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: colorController.qualificationItemsColors,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  selectedNamesQualification3[index],
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 13, color: colorController.whiteColor),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    // Remove the selected item from the list
                                    selectedIdsQualification3.removeAt(index);
                                    selectedNamesQualification3.removeAt(index);
                                    // updateSelectedNames(); // Update the names here
                                  });
                                },
                                child: Icon(Icons.cancel_outlined, color: colorController.whiteColor,size: MediaQuery.of(context).size.width*.050,),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  reusablaSizaBox(context, 0.020),
                  reusableDocuments1(context, '', 'Proof', state.proof3 != null
              ? state.proof3!.path
              : repository.proof_image3.value.toString(),
                              (){
                                reuablebottomsheet(context, "Choose Profile Image",(){
                                  // _pickImage(ImageSource.gallery, 'profile');
                                  controller.pickImage(context, 'proof3', ImageSource.gallery);
                                },(){
                                  // _pickImage(ImageSource.camera,'profile');
                                  controller.pickImage(context, 'proof3', ImageSource.camera);
                                });
                                // controller.showImagePickerSheet(context, 'profile');
                              }, 'assets/images/add_img_placeholder.png'),
                  reusablaSizaBox(context, .050),
                  reusableBtn(context, 'Update', (){
                    setState(() {
                      // updateStatus();
                      _validateForm();
                    });
                  }),
                  reusablaSizaBox(context, .020),
                ],
              ),
            ),
          ),
        ),
        reusableloadingrow(context, isLoading),
      ],
    ),
  ),
);
}
}







        