import 'package:equatable/equatable.dart';

class ChildProfileState extends Equatable {
  final bool loading;
  final String? error;
  final bool deleteSuccess;

  const ChildProfileState({
    this.loading = false,
    this.error,
    this.deleteSuccess = false,
  });

  ChildProfileState copyWith({
    bool? loading,
    String? error,
    bool? deleteSuccess,
    bool clearError = false,
  }) {
    return ChildProfileState(
      loading: loading ?? this.loading,
      error: clearError ? null : (error ?? this.error),
      deleteSuccess: deleteSuccess ?? this.deleteSuccess,
    );
  }

  @override
  List<Object?> get props => [loading, error, deleteSuccess];
}