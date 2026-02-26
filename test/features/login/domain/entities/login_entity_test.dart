import 'package:flutter_test/flutter_test.dart';
import 'package:montebit/features/login/domain/entities/login_entity.dart';

void main() {
  group('LoginEntity', () {
    const tLoginEntity = LoginEntity(
      email: 'test@example.com',
      password: 'password123',
    );

    test('initial() should return an empty LoginEntity', () {
      final result = LoginEntity.initial();
      expect(result.email, equals(''));
      expect(result.password, equals(''));
    });

    test('toJson() should return a valid Map containing proper data', () {
      final result = tLoginEntity.toJson();
      final expectedJson = {
        'email': 'test@example.com',
        'password': 'password123',
      };
      expect(result, equals(expectedJson));
    });

    test(
      'copyWith() should return a new LoginEntity with updated properties',
      () {
        final updated = tLoginEntity.copyWith(email: 'updated@example.com');
        expect(updated.email, equals('updated@example.com'));
        expect(
          updated.password,
          equals('password123'),
        ); // ensure others are unchanged
      },
    );

    test('props should contain email and password', () {
      expect(tLoginEntity.props, equals(['test@example.com', 'password123']));
    });
  });
}
