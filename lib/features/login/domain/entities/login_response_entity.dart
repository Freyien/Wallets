import 'package:equatable/equatable.dart';

class LoginResponseEntity extends Equatable {
  final String token;

  const LoginResponseEntity({required this.token});

  factory LoginResponseEntity.fromJson(Map<String, dynamic> json) {
    return LoginResponseEntity(token: json['token'] as String);
  }

  @override
  List<Object?> get props => [token];
}
