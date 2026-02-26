


import 'dart:io';

import 'package:fahad_tutor/controller/documents_attach_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final documentsAttachProvider =
    StateNotifierProvider.autoDispose<DocumentsAttachController, DocumentsAttachState>(
  (ref) => DocumentsAttachController(ref),
);


class DocumentsAttachState {
  final bool isLoading;
  final File? profile;
  final File? cnicFront;
  final File? cnicBack;
  final File? qualification;
  final File? other1;
  final File? other2;
  final File? other3;
  final File? other4;
  final File? other5;
  final File? other6;
  final File? proof1;
  final File? proof2;
  final File? proof3;
  final File? image1;

  DocumentsAttachState({
    this.isLoading = false,
    this.profile,
    this.cnicFront,
    this.cnicBack,
    this.qualification,
    this.other1,
    this.other2,
    this.other3,
    this.other4,
    this.other5,
    this.other6,
    this.proof1,
    this.proof2,
    this.proof3,
    this.image1,
  });

  DocumentsAttachState copyWith({
    bool? isLoading,
    File? profile,
    File? cnicFront,
    File? cnicBack,
    File? qualification,
    File? other1,
    File? other2,
    File? other3,
    File? other4,
    File? other5,
    File? other6,
    File? proof1,
    File? proof2,
    File? proof3,
    File? image1,
  }) {
    return DocumentsAttachState(
      isLoading: isLoading ?? this.isLoading,
      profile: profile ?? this.profile,
      cnicFront: cnicFront ?? this.cnicFront,
      cnicBack: cnicBack ?? this.cnicBack,
      qualification: qualification ?? this.qualification,
      other1: other1 ?? this.other1,
      other2: other2 ?? this.other2,
      other3: other3 ?? this.other3,
      other4: other4 ?? this.other4,
      other5: other5 ?? this.other5,
      other6: other6 ?? this.other6,
      proof1: proof1 ?? this.proof1,
      proof2: proof2 ?? this.proof2,
      proof3: proof3 ?? this.proof3,
      image1: image1 ?? this.image1,
    );
  }
  factory DocumentsAttachState.initial() => DocumentsAttachState();
}
