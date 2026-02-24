import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String email;
  final String password;

  const LoginEntity({required this.email, required this.password});

  factory LoginEntity.initial() => const LoginEntity(email: '', password: '');

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }

  LoginEntity copyWith({String? email, String? password}) {
    return LoginEntity(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [email, password];
}
