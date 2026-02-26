import 'package:flutter_test/flutter_test.dart';
import 'package:montebit/features/login/domain/entities/login_response_entity.dart';

void main() {
  group('LoginResponseEntity', () {
    const tLoginResponseEntity = LoginResponseEntity(token: 'valid_token_123');

    test('fromJson() should return a valid model', () {
      final jsonMap = {'token': 'valid_token_123'};
      final result = LoginResponseEntity.fromJson(jsonMap);
      expect(result, equals(tLoginResponseEntity));
    });

    test('props should contain the token', () {
      expect(tLoginResponseEntity.props, equals(['valid_token_123']));
    });
  });
}
