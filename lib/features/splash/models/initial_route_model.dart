import 'package:equatable/equatable.dart';

class InitialRouteModel extends Equatable {
  const InitialRouteModel({required this.route});
  final String route;

  @override
  List<Object> get props => [route];
}
