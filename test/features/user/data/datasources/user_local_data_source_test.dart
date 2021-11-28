import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_resident_zombie/core/error/exceptions.dart';
import 'package:the_resident_zombie/features/user/data/datasources/user_cache_data_source.dart';
import 'package:the_resident_zombie/features/user/data/models/user_model.dart';

import '../../../../fixture/fixture_reader.dart';
import 'user_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late UserCacheDataSource datasource;

  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    datasource =
        UserCacheDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group(
    'User local datasource:',
    () {
      final userJson = fixture('user_cached.json');
      final tUserModel = UserModel.fromJson(json.decode(userJson));

      test(
        'return User data from shared preferences when there is one cached',
        () async {
          // arrange
          when(mockSharedPreferences.getString(any)).thenReturn(userJson);
          // act
          final result = await datasource.getUser();
          // assert
          verify(mockSharedPreferences.getString(CACHED_USER));
          expect(result, equals(tUserModel));
        },
      );

      test(
        'throw CachedExpection when there is not a cached value',
        () async {
          // arrange
          when(mockSharedPreferences.getString(any)).thenReturn(null);
          // act
          final call = datasource.getUser;
          // assert
          expect(() => call(), throwsA(TypeMatcher<CacheException>()));
        },
      );

      group(
        'Save connection -',
        () {
          final tIdentifier = 'test';

          test(
            'return the tIdentifier if shared preferences return null',
            () async {
              // arrange
              when(mockSharedPreferences.getString(any)).thenReturn(null);
              when(mockSharedPreferences.setString(any, any))
                  .thenAnswer((_) async => true);
              // act
              final result = await datasource.saveContact(tIdentifier);
              // assert
              verify(mockSharedPreferences.getString(CACHED_CONTACT));
              verify(
                  mockSharedPreferences.setString(CACHED_CONTACT, tIdentifier));
              expect(result, equals(tIdentifier));
            },
          );

          test(
            'return the tIdentifier if shared preferences return a string',
            () async {
              // arrange
              when(mockSharedPreferences.getString(any)).thenReturn('test');
              when(mockSharedPreferences.setString(any, any))
                  .thenAnswer((_) async => true);
              // act
              final result = await datasource.saveContact(tIdentifier);
              // assert
              verify(mockSharedPreferences.getString(CACHED_CONTACT));
              verify(mockSharedPreferences.setString(
                  CACHED_CONTACT, "$tIdentifier;$tIdentifier"));
              expect(result, equals(tIdentifier));
            },
          );

          test(
            'throw a [CacheException] if the sharedPreferences return false when its set',
            () async {
              // arrange
              when(mockSharedPreferences.getString(any)).thenReturn(null);
              when(mockSharedPreferences.setString(any, any))
                  .thenThrow(CacheException());
              // act
              final call = () => datasource.saveContact(tIdentifier);
              // assert

              expect(() => call(), throwsA(TypeMatcher<CacheException>()));
            },
          );

          test(
            'throw a [CacheException] if the sharedPreferences thows an error on get',
            () async {
              // arrange
              when(mockSharedPreferences.getString(any))
                  .thenThrow(CacheException());
              when(mockSharedPreferences.setString(any, any))
                  .thenThrow(CacheException());
              // act
              final call = () => datasource.saveContact(tIdentifier);
              // assert

              expect(() => call(), throwsA(TypeMatcher<CacheException>()));
            },
          );
        },
      );
      group(
        'Get all connections id:',
        () {
          final tTest = "test;test;test";
          final tResult = ["test", "test", "test"];
          test(
            'return a list of arrays',
            () async {
              // arrange
              when(mockSharedPreferences.getString(any)).thenReturn(tTest);
              // act
              final result = await datasource.getAllContactsIds();
              // assert
              expect(result, tResult);
              expect(result.length, 3);
            },
          );

          test(
            'return a empty list when the shared preferences return null',
            () async {
              // arrange
              when(mockSharedPreferences.getString(any)).thenReturn(null);
              // act
              final result = await datasource.getAllContactsIds();
              // assert
              expect(result, []);
              expect(result.length, 0);
            },
          );

          test(
            'throws a [CacheException]',
            () async {
              // arrange
              when(mockSharedPreferences.getString(any)).thenThrow(CacheException());
              // act
              final call = datasource.getAllContactsIds;
              // assert
              expect(() => call(), throwsA(TypeMatcher<CacheException>()));
            },
          );
        },
      );
    },
  );
}
