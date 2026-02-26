import 'package:flutter_test/flutter_test.dart';
import 'package:montebit/features/signup/domain/entities/signup_entity.dart';

void main() {
  group('SignupEntity', () {
    const tSignupEntity = SignupEntity(
      fullname: 'Test User',
      email: 'test@test.com',
      dialCode: '+1',
      phone: '1234567890',
      password: 'password123',
      confirmPassword: 'password123',
    );

    test('initial() should return an empty default SignupEntity', () {
      final result = SignupEntity.initial();
      expect(result.fullname, equals(''));
      expect(result.email, equals(''));
      expect(result.dialCode, equals('+52'));
      expect(result.phone, equals(''));
      expect(result.password, equals(''));
      expect(result.confirmPassword, equals(''));
    });

    test('copyWith() should return a new updated SignupEntity', () {
      final updated = tSignupEntity.copyWith(fullname: 'Updated User');
      expect(updated.fullname, equals('Updated User'));
      expect(
        updated.email,
        equals('test@test.com'),
      ); // check others remain same
    });

    test('toJson() should return a valid JSON map', () {
      final result = tSignupEntity.toJson();
      final expectedJson = {
        'fullName': 'Test User',
        'email': 'test@test.com',
        'phoneNumber': '+11234567890',
        'password': 'password123',
      };
      expect(result, equals(expectedJson));
    });

    test('props should contain all relevant properties', () {
      expect(
        tSignupEntity.props,
        equals([
          'Test User',
          'test@test.com',
          '+1',
          '1234567890',
          'password123',
          'password123',
        ]),
      );
    });
  });
}
