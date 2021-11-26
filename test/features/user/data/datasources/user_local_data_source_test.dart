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
    'get User Cached',
    () {
      final userJson = fixture('user_cached.json');
      final tUserModel =
          UserModel.fromJson(json.decode(userJson));

      test(
        'return User data from shared preferences when there is one cached',
        () async {
          // arrange
          when(mockSharedPreferences.getString(any))
              .thenReturn(userJson);
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
    },
  );
}
