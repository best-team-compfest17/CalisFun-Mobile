import 'dart:async';
import 'dart:io';

import 'package:calisfun/src/network/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core.dart';
import 'child_profile_add_state.dart';

final childProfileAddControllerProvider =
StateNotifierProvider<ChildProfileAddController, ChildProfileAddState>(
      (ref) => ChildProfileAddController(ref),
);

class ChildProfileAddController extends StateNotifier<ChildProfileAddState> {
  ChildProfileAddController(this.ref) : super(const ChildProfileAddState());

  final Ref ref;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final _picker = ImagePicker();

  // === Input handlers ===
  void onNameChanged(String v) => state = state.copyWith(
    name: v.trim(),
    createValue: const AsyncData(null),
  );

  // === Image actions ===
  Future<void> pickImage({ImageSource source = ImageSource.gallery}) async {
    final picked = await _picker.pickImage(source: source);
    if (picked != null) {
      state = state.copyWith(imageFile: File(picked.path));
    }
  }

  void removeImage() => state = state.copyWith(imageFile: null);

  String? validateName(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Tidak boleh kosong';
    if (v.length < 2) return 'Minimal 2 karakter';
    return null;
  }

  Future<void> submit() async {
    final form = formKey.currentState;
    if (form == null || !form.validate()) return;

    state = state.copyWith(
      name: nameController.text.trim(),
      createValue: const AsyncLoading(),
    );

    try {
      final service = ref.read(userServiceProvider);
      final res = await service.createChildProfile(
        name: state.name,
        imageFile: state.imageFile,
      );

      res.when(
        success: (_) => state = state.copyWith(createValue: const AsyncData(null)),
        failure: (e, st) => state = state.copyWith(createValue: AsyncError(e, st)),
      );
    } catch (e, st) {
      state = state.copyWith(createValue: AsyncError(e, st));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}

