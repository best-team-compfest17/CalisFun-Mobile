import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChildProfileAddState {
  final AsyncValue<void> createValue;
  final String name;
  final File? imageFile;

  const ChildProfileAddState({
    this.createValue = const AsyncData(null),
    this.name = '',
    this.imageFile,
  });

  bool get isLoading => createValue.isLoading;
  bool get isValidName => name.trim().length >= 2;
  bool get canSubmit => isValidName && !isLoading;

  ChildProfileAddState copyWith({
    AsyncValue<void>? createValue,
    String? name,
    File? imageFile,
  }) {
    return ChildProfileAddState(
      createValue: createValue ?? this.createValue,
      name: name ?? this.name,
      imageFile: imageFile == null && !(imageFile == this.imageFile)
          ? imageFile
          : (imageFile ?? this.imageFile),
    );
  }
}
