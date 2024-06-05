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
  String personal_image = '';
  String cnic_front = '';
  String cnic_back = '';
  String last_document = '';
  String other_1 = '';
  String other_2 = '';
  int doc_error = 0;
  String docs_msg = '';
  bool visible = true;
  File? _imageupdateprofileimage;
  bool updateprofileimage = false;
  String base64updateprofileimage = 'noimage';

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
        personal_image = jsonResponse['personal_image'];
        cnic_front = jsonResponse['cnic_front'];
        cnic_back = jsonResponse['cnic_back'];
        last_document = jsonResponse['last_document'];
        other_1 = jsonResponse['other_1'];
        other_2 = jsonResponse['other_2'];
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

  Future<void> selectupdateprofileimage(ImageSource source) async {
    setState(() {
      isLoading = true;
    });
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);

      setState(() {
        if (pickedFile != null) {
          _imageupdateprofileimage = File(pickedFile.path);

          List<int> imageBytes = _imageupdateprofileimage!.readAsBytesSync();
          base64updateprofileimage = base64Encode(imageBytes);

          print('Base64 Image: $base64updateprofileimage');
          updateprofileimage = true;

          if (updateprofileimage) {
            showUpdateProfileImageDialog();
          }
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      print('Error in selectupdateprofileimage: $e');
      // Handle error here
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showUpdateProfileImageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Profile Image Updated'),
        content: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(_imageupdateprofileimage!),
              fit: BoxFit.contain,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(5),
            child: reusableBtn(context, 'Cancel', () {
              Navigator.pop(context);
            },),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: reusableBtn(context, 'Submit', () {
              setState(() {
                updateProfileImage();
              });
              // Navigator.pop(context);
              Navigator.pop(context);
            },),
          ),
        ],
      ),
    );
  }

  Future<void> updateProfileImage() async {
    setState(() {
      isLoading = true;
    });

    final apiUrl =
        "https://digitance.turk.pk/super_api/update_profile_picture.php";
    try {
      final response = await http.post(Uri.parse(apiUrl), body: {
        'user_id': MySharedPrefrence().get_user_id(),
        'image': base64updateprofileimage,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['success'] == 1) {
          print(data['image']);
          MySharedPrefrence().set_user_image(data['image']);
          print("object");

          print("Image Updated Sucessfully");
          setState(() {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Profile()));
          });
        } else {
          print("Image not Updated Sucessfully");
        }
      } else {
        print("Image not Updated Sucessfully");

        print('Error: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
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
                              reusableDocuments(context,'','Add Image (Front)','Add Image (Back)' ,'Profile', 'CNIC Image', personal_image, cnic_front,cnic_back, (){
                                reuablebottomsheet(context, "Choose Profile Image",(){},(){});
                              },(){reuablebottomsheet(context, "Choose CNIC Front Image",(){},(){});},
                              (){reuablebottomsheet(context, "Choose CNIC Back Image",(){},(){});}
                              ),
                               reusablaSizaBox(context, 0.020),
                              reusableDocuments(context, 'Add Image', '', '', 'Last Qualification Proof', 'Attach other Documents(Optional)', last_document, other_1, other_2, (){
                                reuablebottomsheet(context, "Choose Qualification Image",(){},(){});
                              },(){reuablebottomsheet(context, "Choose Other Image",(){},(){});},
                              (){reuablebottomsheet(context, "Choose Other Image",(){},(){});}),
                              reusablaSizaBox(context, 0.010),
                              // reusableBtn(context, 'Submit',(){})
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