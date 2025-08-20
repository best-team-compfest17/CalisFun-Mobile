part of '../data.dart';

class UserConverter {
  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: _s(json['_id'] ?? json['id']),
      username: _s(json['username']),
      email: _s(json['email']),
      phoneNumber: _s(json['phone_number'] ?? json['phoneNumber']),
      role: _s(json['role']),
      children: ChildConverter.fromList(json['children']),
    );
  }

  static List<User> fromList(dynamic data) {
    final list = (data is List) ? data : const <dynamic>[];
    return list
        .whereType<Map<String, dynamic>>()
        .map(fromJson)
        .toList(growable: false);
  }

  static Map<String, dynamic> toJson(User u) => {
    'id': u.id,
    'username': u.username,
    'email': u.email,
    'phone_number': u.phoneNumber,
    'role': u.role,
    'children': u.children.map(ChildConverter.toJson).toList(),
  };

  static String _s(dynamic v) => (v ?? '').toString();
}
