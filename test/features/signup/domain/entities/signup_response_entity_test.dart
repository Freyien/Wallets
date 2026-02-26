import 'package:flutter_test/flutter_test.dart';
import 'package:montebit/features/signup/domain/entities/signup_response_entity.dart';

void main() {
  group('SignUpResponseEntity', () {
    const tSignUpResponseEntity = SignUpResponseEntity(
      token: 'signup_token_456',
    );

    test('fromJson() should return a valid model', () {
      final jsonMap = {'token': 'signup_token_456'};
      final result = SignUpResponseEntity.fromJson(jsonMap);
      expect(result, equals(tSignUpResponseEntity));
    });

    test('props should contain the token', () {
      expect(tSignUpResponseEntity.props, equals(['signup_token_456']));
    });
  });
}
