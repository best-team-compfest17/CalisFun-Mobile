import 'package:equatable/equatable.dart';

import '../../../core.dart';

class SelectChildState extends Equatable {
  final List<Child> children;
  final String? selectedChildId;
  final bool loading;
  final String? error;

  const SelectChildState({
    this.children = const [],
    this.selectedChildId,
    this.loading = false,
    this.error,
  });

  SelectChildState copyWith({
    List<Child>? children,
    String? selectedChildId,
    bool? loading,
    String? error,
    bool clearError = false,
  }) {
    return SelectChildState(
      children: children ?? this.children,
      selectedChildId: selectedChildId ?? this.selectedChildId,
      loading: loading ?? this.loading,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [children, selectedChildId, loading, error];
}
