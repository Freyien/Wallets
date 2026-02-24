import 'package:equatable/equatable.dart';

class SignUpResponseEntity extends Equatable {
  final String token;

  const SignUpResponseEntity({required this.token});

  factory SignUpResponseEntity.fromJson(Map<String, dynamic> json) {
    return SignUpResponseEntity(token: json['token'] as String);
  }

  @override
  List<Object?> get props => [token];
}
