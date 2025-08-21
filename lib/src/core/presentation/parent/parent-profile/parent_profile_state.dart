// parent_profile_state.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/domain.dart';

class ParentProfileState extends Equatable {
  final AsyncValue<User?> profileValue;
  final bool isEditMode;

  const ParentProfileState({
    this.profileValue = const AsyncData<User?>(null),
    this.isEditMode = false,
  });

  ParentProfileState copyWith({
    AsyncValue<User?>? profileValue,
    bool? isEditMode,
  }) {
    return ParentProfileState(
      profileValue: profileValue ?? this.profileValue,
      isEditMode: isEditMode ?? this.isEditMode,
    );
  }

  @override
  List<Object?> get props => [
    profileValue,
    isEditMode,
  ];
}