import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? name;
  final String? email;

  const User({required this.id, this.name, this.email});

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  factory User.fromSnapshot(Map<String, dynamic> snap) {
    return User(
        id: snap['id'] as String,
        name: snap['name'] as String?,
        email: snap['email'] as String?);
  }

  Map<String, dynamic> toDocument() {
    return {'id': id, 'name': name, 'email': email};
  }

  @override
  List<Object?> get props => [id, email, name];
}
