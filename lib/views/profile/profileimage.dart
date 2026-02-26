
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/controller/repo_provider.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/model/documentmodel.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablebottomsheet.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusabledocuments.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/views/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Profileimage extends ConsumerStatefulWidget {
  const Profileimage({super.key});

  @override
  ConsumerState<Profileimage> createState() => _ProfileimageState();
}

class _ProfileimageState extends ConsumerState<Profileimage> {
  bool isLoading = false;
   late TutorRepository repository;
   final TextEditingController _biography = TextEditingController();
   int count =0; 
  @override
void initState() {
  repository = ref.read(tutorRepositoryProvider);
  super.initState();
  repository.getProfileImage().then((_) {
    if (mounted) setState(() {});
  });
  repository.documentsAttach();
}


   Future<void> uploadProfileImage() async {
    isLoading = false;

  try {

    isLoading = true;
    final rawUrl = repository.profile_image.value.toString();

    // 🔥 encode the URL properly
    final encodedUrl = Uri.encodeFull(rawUrl);

    print('p3 $encodedUrl');
    final url = Uri.parse('${Utils.baseUrl}check_popup.php');
    final body = {
      // 'profile_image_updated': repository.profile_image.value.toString(),
      'profile_image_updated': encodedUrl,
      'tutor_id': MySharedPrefrence().get_user_ID().toString(),
      // 'profile_img': repository.profile_image.value.toString(),
    };

    final response = await http.post(url, body: body);

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      print(response.body.toString());
      Utils.snakbarSuccess(context, 'Profile Image submitted successfully');

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Profile()),
        );
      }
     isLoading = false;
    } else {
      Utils.snakbar(context, 'Submission failed, please try again');
    }
  } catch (e) {
    debugPrint('uploadAllAndSubmit error: $e');
    Utils.snakbar(context, 'Error submitting documents');
  } finally {
  }
}
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(documentsAttachProvider);
    final controller = ref.read(documentsAttachProvider.notifier);
    print(repository.profile_image.value.toString());
    return 
    reusableprofileidget( context,
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .032),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // reusableText("FAQ's",color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold),
                          Text(
                            "Profile Image",
                                                    style: TextStyle(
                                color: colorController.blackColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'tutorPhi'
                                
                              ),
                                                  ),
                              reusablaSizaBox(context, 0.020),
                              reusableDocuments1(context, '', '', state.profile != null
                              ? state.profile!.path
                              : repository.profile_image.value.toString(),
                              (){
                                reuablebottomsheet(context, "Choose Profile Image",(){
                                  // _pickImage(ImageSource.gallery, 'profile');
                                  controller.pickImage(context, 'profile', ImageSource.gallery);
                                },(){
                                  // _pickImage(ImageSource.camera,'profile');
                                  controller.pickImage(context, 'profile', ImageSource.camera);
                                });
                                // controller.showImagePickerSheet(context, 'profile');
                              }, 'assets/images/profile.png'),
                              reusableBtn(context, 'Submit',()async{
                                setState(() {
                                  uploadProfileImage();
                                });
                                }),
                              reusablaSizaBox(context, 0.010),
                        ]
                      ),
                      
                    ],
                  ),
                ),
                Center(child: reusableloadingrow(context, isLoading))
    );
  }
}