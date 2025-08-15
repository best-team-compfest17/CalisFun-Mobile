import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'child_profile_add_state.dart';

final childProfileAddControllerProvider =
StateNotifierProvider<ChildProfileAddController, ChildProfileAddState>(
      (ref) => ChildProfileAddController(),
);

class ChildProfileAddController extends StateNotifier<ChildProfileAddState> {
  ChildProfileAddController() : super(const ChildProfileAddState());

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

  // === Validation ===
  String? validateName(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Tidak boleh kosong';
    if (v.length < 2) return 'Minimal 2 karakter';
    return null;
  }

  // === Submit ===
  Future<void> submit() async {
    final form = formKey.currentState;
    if (form == null) return;
    if (!form.validate()) return;

    state = state.copyWith(
      name: nameController.text.trim(),
      createValue: const AsyncLoading(),
    );

    try {
      // TODO: ganti bagian ini dengan upload foto & simpan ke DB / API
      await Future<void>.delayed(const Duration(milliseconds: 600));

      // Jika sukses
      state = state.copyWith(createValue: const AsyncData(null));
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

