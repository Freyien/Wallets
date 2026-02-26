import 'package:flutter_test/flutter_test.dart';
import 'package:montebit/features/profile/domain/entities/profile_entity.dart';

void main() {
  group('ProfileEntity', () {
    const tProfileEntity = ProfileEntity(
      id: '123',
      fullName: 'Test User',
      email: 'test@example.com',
      phone: '1234567890',
      imageUrl: 'https://example.com/avatar.png',
    );

    test('initial() should return an empty default ProfileEntity', () {
      final result = ProfileEntity.initial();
      expect(result.id, equals(''));
      expect(result.fullName, equals(''));
      expect(result.email, equals(''));
      expect(result.phone, equals(''));
      expect(result.imageUrl, equals(''));
    });

    test('fromJson() should return a valid model from JSON', () {
      final jsonMap = {
        'id': '123',
        'full_name': 'Test User',
        'email': 'test@example.com',
        'phone': '1234567890',
        'image_url': 'https://example.com/avatar.png',
      };
      final result = ProfileEntity.fromJson(jsonMap);
      expect(result, equals(tProfileEntity));
    });

    test('fromJson() should gracefully handle missing/null JSON values', () {
      final jsonMap = <String, dynamic>{
        'id': null,
        'full_name': null,
        'email': null,
      };
      final result = ProfileEntity.fromJson(jsonMap);
      expect(result.id, equals(''));
      expect(result.fullName, equals(''));
      expect(result.email, equals(''));
      expect(result.phone, equals(''));
      expect(result.imageUrl, equals(''));
    });

    test('toJson() should return a proper JSON map', () {
      final result = tProfileEntity.toJson();
      final expectedJson = {
        'id': '123',
        'full_name': 'Test User',
        'email': 'test@example.com',
        'phone': '1234567890',
        'image_url': 'https://example.com/avatar.png',
      };
      expect(result, equals(expectedJson));
    });

    test('copyWith() should return a new updated ProfileEntity', () {
      final updated = tProfileEntity.copyWith(
        id: '456',
        fullName: 'Updated Name',
        email: 'updated@example.com',
        phone: '0987654321',
        imageUrl: 'https://example.com/new_avatar.png',
      );

      expect(updated.id, equals('456'));
      expect(updated.fullName, equals('Updated Name'));
      expect(updated.email, equals('updated@example.com'));
      expect(updated.phone, equals('0987654321'));
      expect(updated.imageUrl, equals('https://example.com/new_avatar.png'));

      final same = updated.copyWith();
      expect(same, equals(updated));
    });

    test('props should contain all relevant properties', () {
      expect(
        tProfileEntity.props,
        equals([
          '123',
          'Test User',
          'test@example.com',
          '1234567890',
          'https://example.com/avatar.png',
        ]),
      );
    });
  });
}
