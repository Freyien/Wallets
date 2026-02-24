import 'package:equatable/equatable.dart';

class SignupEntity extends Equatable {
  final String fullname;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;

  const SignupEntity({
    required this.fullname,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirmPassword,
  });

  factory SignupEntity.initial() => const SignupEntity(
    fullname: '',
    email: '',
    phone: '',
    password: '',
    confirmPassword: '',
  );

  SignupEntity copyWith({
    String? fullname,
    String? email,
    String? phone,
    String? password,
    String? confirmPassword,
  }) {
    return SignupEntity(
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  Map<String, dynamic> toJson() => {
    'fullName': fullname,
    'email': email,
    'phoneNumber': phone,
    'password': password,
  };

  @override
  List<Object?> get props => [
    fullname,
    email,
    phone,
    password,
    confirmPassword,
  ];
}
