part of 'domain.dart';

class User {
  final String id;
  final String username;
  final String email;
  final String phoneNumber;
  final String role;
  final List<Child> children;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.role,
    this.children = const [],
  });
}
