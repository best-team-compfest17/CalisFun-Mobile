import 'package:equatable/equatable.dart';
import '../../../domain/domain.dart';

class HomeParentState extends Equatable {
  final User? user;
  final List<Child> children;
  final bool loading;
  final String? error;

  const HomeParentState({
    this.user,
    this.children = const [],
    this.loading = false,
    this.error,
  });

  HomeParentState copyWith({
    User? user,
    List<Child>? children,
    bool? loading,
    String? error,
    bool clearError = false,
  }) {
    return HomeParentState(
      user: user ?? this.user,
      children: children ?? this.children,
      loading: loading ?? this.loading,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [user, children, loading, error];
}