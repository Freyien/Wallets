import 'package:equatable/equatable.dart';
import 'package:montebit/core/domain/failures/failure.dart';

class Response<T> extends Equatable {
  factory Response.failed(Failure failure) =>
      Response._(status: ResponseStatus.failed, failure: failure);

  factory Response.success(T data) =>
      Response._(status: ResponseStatus.success, data: data);

  factory Response.voidSuccess() =>
      const Response._(status: ResponseStatus.success);

  const Response._({required this.status, this.data, this.failure});

  final ResponseStatus status;
  final T? data;
  final Failure? failure;

  bool get isSuccess => status == ResponseStatus.success;

  bool get isFailed => status == ResponseStatus.failed;

  @override
  List<Object> get props => [status];
}

enum ResponseStatus { success, failed }
