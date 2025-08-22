import 'package:equatable/equatable.dart';

import '../../../core.dart';

class LeaderboardState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<LeaderboardUser> users;
  final int? yourRank;

  const LeaderboardState({
    this.isLoading = false,
    this.error,
    this.users = const [],
    this.yourRank,
  });

  LeaderboardState copyWith({
    bool? isLoading,
    String? error,
    List<LeaderboardUser>? users,
    int? yourRank,
  }) {
    return LeaderboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      users: users ?? this.users,
      yourRank: yourRank ?? this.yourRank,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, users, yourRank];
}
