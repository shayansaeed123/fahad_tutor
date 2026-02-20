

import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tutorRepositoryProvider = Provider<TutorRepository>((ref) {
  return TutorRepository();
});