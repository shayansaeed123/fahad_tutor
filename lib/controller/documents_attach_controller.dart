import 'dart:convert';
import 'dart:io';

import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/model/documentmodel.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/views/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
class DocumentsAttachController extends StateNotifier<DocumentsAttachState> {
   final Ref ref;
  final ImagePicker _picker = ImagePicker();
  late TutorRepository repository;

  DocumentsAttachController(this.ref) : super(DocumentsAttachState.initial()) {
    repository = TutorRepository();
    loadExistingDocuments(); // auto call when provider created
  }

  /// Fetch existing documents from backend
  void loadExistingDocuments() async {
  state = DocumentsAttachState(isLoading: true);

  try {
    await repository.documentsAttach(); // ye API call tumhara TutorRepo ka
    state = state.copyWith(isLoading: false);
  } catch (e) {
    state = state.copyWith(isLoading: false);
    debugPrint("loadExistingDocuments error: $e");
  }
}

  /// Pick image from camera or gallery, compress if needed, then show preview dialog
  Future<void> pickImage(BuildContext context, String type, ImageSource source) async {
    try {
      final picked = await _picker.pickImage(source: source);
      if (picked == null) {
        debugPrint('No image selected');
        return;
      }
      File selectedImage = File(picked.path);

      // Only compress if from camera
      if (source == ImageSource.camera) {
        selectedImage = await _compressImage(selectedImage);
      }

      // Update local state for UI preview
      state = _updateStateWithImage(type, selectedImage);

      // Show preview dialog
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
              await uploadSingleFile(type,selectedImage,context);
              if (mounted) Navigator.of(context).pop(); // close dialog only
              if (mounted) Navigator.of(context).pop(); // close dialog only
            }),
          ),
        ],
      ),
    );
    } catch (e) {
      debugPrint('PickImage error: $e');
      Utils.snakbar(context, 'Error picking image');
    }
  }

  Future<File> _compressImage(File file) async {
    try {
      if (!Platform.isAndroid && !Platform.isIOS) return file;
      final dir = await getTemporaryDirectory();
      final targetPath = path.join(
        dir.path,
        'cmp_${DateTime.now().millisecondsSinceEpoch}_${path.basename(file.path)}',
      );
      final compressed = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 70,
        minWidth: 1080,
        minHeight: 1080,
      );
      return compressed != null ? File(compressed.path) : file;
    } catch (e) {
      debugPrint('Compression error: $e');
      return file;
    }
  }

  DocumentsAttachState _updateStateWithImage(String type, File file) {
    switch (type) {
      case 'profile':
        return state.copyWith(profile: file);
      case 'front':
        return state.copyWith(cnicFront: file);
      case 'back':
        return state.copyWith(cnicBack: file);
      case 'qualification':
        return state.copyWith(qualification: file);
      case 'other1':
        return state.copyWith(other1: file);
      case 'other2':
        return state.copyWith(other2: file);
      case 'other3':
        return state.copyWith(other3: file);
      case 'other4':
        return state.copyWith(other4: file);
      case 'other5':
        return state.copyWith(other5: file);
      case 'other6':
        return state.copyWith(other6: file);
      default:
        return state;
    }
  }

  /// Upload a single file to the server and update repository values
  Future<void> uploadSingleFile(String type, File file, BuildContext context) async {
    final fieldName = _mapFieldName(type);
    if (fieldName.isEmpty) {
      Utils.snakbar(context, 'Invalid field type');
      return;
    }

    try {
      state = state.copyWith(isLoading: true);
      final uploadUrl = '${Utils.baseUrl}upload_doc_4.php';
      var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
      request.files.add(await http.MultipartFile.fromPath(fieldName, file.path));

      final streamed = await request.send();
      final respStr = await streamed.stream.bytesToString();

      if (streamed.statusCode == 200) {
        final jsonResp = json.decode(respStr);
        // update repository values accordingly
        if (jsonResp.containsKey('profile_pic')) repository.profile_image.value = jsonResp['profile_pic'];
        if (jsonResp.containsKey('CNIC_F')) repository.cnic_f.value = jsonResp['CNIC_F'];
        if (jsonResp.containsKey('CNIC_B')) repository.cnic_b.value = jsonResp['CNIC_B'];
        if (jsonResp.containsKey('Qualification')) repository.last_document.value = jsonResp['Qualification'];
        if (jsonResp.containsKey('other_1')) repository.other_1.value = jsonResp['other_1'];
        if (jsonResp.containsKey('other_2')) repository.other_2.value = jsonResp['other_2'];
        if (jsonResp.containsKey('other_3')) repository.other_3.value = jsonResp['other_3'];
        if (jsonResp.containsKey('other_4')) repository.other_4.value = jsonResp['other_4'];
        if (jsonResp.containsKey('other_5')) repository.other_5.value = jsonResp['other_5'];
        if (jsonResp.containsKey('other_6')) repository.other_6.value = jsonResp['other_6'];

        Utils.snakbar(context, 'Upload successful');
      } else {
        Utils.snakbar(context, 'Upload failed with status ${streamed.statusCode}');
      }
    } catch (e) {
      debugPrint('UploadSingleFile error: $e');
      Utils.snakbar(context, 'Error uploading file');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  String _mapFieldName(String type) {
    switch (type) {
      case 'profile':
        return 'profile_pic';
      case 'front':
        return 'CNIC_F';
      case 'back':
        return 'CNIC_B';
      case 'qualification':
        return 'Qualification';
      case 'other1':
        return 'other_1';
      case 'other2':
        return 'other_2';
      case 'other3':
        return 'other_3';
      case 'other4':
        return 'other_4';
      case 'other5':
        return 'other_5';
      case 'other6':
        return 'other_6';
      default:
        return '';
    }
  }

  Future<void> uploadAllAndSubmit(BuildContext context) async {
  // Required field check
  if (state.profile == null && 
      repository.profile_image.value == 'https://www.fahadtutors.com/fta_admin/' ||
      state.cnicFront == null && 
      repository.cnic_f.value == 'https://www.fahadtutors.com/fta_admin/' ||
      state.cnicBack == null && 
      repository.cnic_b.value == 'https://www.fahadtutors.com/fta_admin/' ||
      state.qualification == null && 
      repository.last_document.value == 'https://www.fahadtutors.com/fta_admin/') {
    Utils.snakbar(context, 'Please attach all required documents');
    return;
  }

  final mapping = <String, File?>{
    'profile': state.profile,
    'front': state.cnicFront,
    'back': state.cnicBack,
    'qualification': state.qualification,
    'other1': state.other1,
    'other2': state.other2,
    'other3': state.other3,
    'other4': state.other4,
    'other5': state.other5,
    'other6': state.other6,
  };

  state = state.copyWith(isLoading: true);

  try {
    // 🔹 Step 1: Upload only NEW (not already uploaded) files
    for (final entry in mapping.entries) {
      final type = entry.key;
      final file = entry.value;

      // Skip nulls
      if (file == null) continue;

      // Check if already uploaded
      final existingUrl = _getRepoUrl(type);
      if (existingUrl != null &&
          existingUrl.isNotEmpty &&
          existingUrl != 'https://www.fahadtutors.com/fta_admin/') {
        debugPrint('Skipping already uploaded file for $type');
        continue; // skip already uploaded
      }

      // Otherwise upload fresh
      await uploadSingleFile(type, file, context);
    }

    // 🔹 Step 2: Call final submit API only once
    final url = Uri.parse('${Utils.baseUrl}step_4_update.php');
    final body = {
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
    };

    final response = await http.post(url, body: body);

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      Utils.snakbar(context, 'All documents submitted successfully');

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Profile()),
        );
      }
    } else {
      Utils.snakbar(context, 'Submission failed, please try again');
    }
  } catch (e) {
    debugPrint('uploadAllAndSubmit error: $e');
    Utils.snakbar(context, 'Error submitting documents');
  } finally {
    state = state.copyWith(isLoading: false);
  }
}

/// Helper: Get current repository URL by type
String? _getRepoUrl(String type) {
  switch (type) {
    case 'profile':
      return repository.profile_image.value;
    case 'front':
      return repository.cnic_f.value;
    case 'back':
      return repository.cnic_b.value;
    case 'qualification':
      return repository.last_document.value;
    case 'other1':
      return repository.other_1.value;
    case 'other2':
      return repository.other_2.value;
    case 'other3':
      return repository.other_3.value;
    case 'other4':
      return repository.other_4.value;
    case 'other5':
      return repository.other_5.value;
    case 'other6':
      return repository.other_6.value;
    default:
      return null;
  }
}


//   Future<void> validateAndSubmit(BuildContext context) async {
//   // Access repository directly (since it's not a provider)
//   final repo = repository;

//   // Access selected (local) files from Riverpod state
//   final profile = state.profile;
//   final cnicF = state.cnicFront;
//   final cnicB = state.cnicBack;
//   final qualification = state.qualification;

//   // Helper function to check if repository URL is valid
//   bool isValidRepoImage(String? value) {
//     return value != null &&
//         value.isNotEmpty &&
//         value != 'https://www.fahadtutors.com/fta_admin/';
//   }

//   // ✅ Required fields validation
//   if ((profile != null || isValidRepoImage(repo.profile_image.value)) &&
//       (cnicF != null || isValidRepoImage(repo.cnic_f.value)) &&
//       (cnicB != null || isValidRepoImage(repo.cnic_b.value)) &&
//       (qualification != null || isValidRepoImage(repo.last_document.value))) {
    
//     // ✅ Everything okay → upload + submit
//     await uploadAllAndSubmit(context);
//   } else {
//     // ❌ Missing field → show specific error
//     String message = '';

//     if ((profile == null) && !isValidRepoImage(repo.profile_image.value)) {
//       message = "Select Profile Image";
//     } else if ((cnicF == null) && !isValidRepoImage(repo.cnic_f.value)) {
//       message = "Select CNIC FRONT Image";
//     } else if ((cnicB == null) && !isValidRepoImage(repo.cnic_b.value)) {
//       message = "Select CNIC BACK Image";
//     } else if ((qualification == null) && !isValidRepoImage(repo.last_document.value)) {
//       message = "Select Last Document Image";
//     } else {
//       message = "Fill Correct Fields";
//     }

//     Utils.snakbar(context, message);
//   }
// }


}