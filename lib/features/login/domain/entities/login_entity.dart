
import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final int id;

  const LoginEntity({
    required this.id,
  });

  factory LoginEntity.initial() => const LoginEntity(
        id: 0,
      );

  LoginEntity copyWith({
    int? id,
  }) {
    return LoginEntity(
      id: id ?? this.id,
    );
  }

  @override
  List<Object> get props => [id];
}
