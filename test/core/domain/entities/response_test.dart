import 'package:flutter_test/flutter_test.dart';
import 'package:montebit/core/domain/entities/response.dart';
import 'package:montebit/core/domain/failures/failure.dart';

void main() {
  group('Response', () {
    test('Response.success creates a successful response with data', () {
      final response = Response.success('test_data');
      expect(response.isSuccess, isTrue);
      expect(response.isFailed, isFalse);
      expect(response.data, equals('test_data'));
      expect(response.failure, isNull);
      expect(response.status, equals(ResponseStatus.success));
      expect(response.props, equals([ResponseStatus.success]));
    });

    test('Response.failed creates a failed response with a failure', () {
      final failure = UnexpectedFailure();
      final response = Response.failed(failure);
      expect(response.isFailed, isTrue);
      expect(response.isSuccess, isFalse);
      expect(response.data, isNull);
      expect(response.failure, equals(failure));
      expect(response.status, equals(ResponseStatus.failed));
      expect(response.props, equals([ResponseStatus.failed]));
    });

    test('Response.voidSuccess creates a successful response with no data', () {
      final response = Response.voidSuccess();
      expect(response.isSuccess, isTrue);
      expect(response.isFailed, isFalse);
      expect(response.data, isNull);
      expect(response.failure, isNull);
      expect(response.status, equals(ResponseStatus.success));
    });
  });
}
