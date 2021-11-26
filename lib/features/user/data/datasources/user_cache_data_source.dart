import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_resident_zombie/core/error/exceptions.dart';
import 'package:the_resident_zombie/features/user/data/models/user_model.dart';

abstract class UserCacheDataSource{
  /// Gets the cached [UserModel] which was saved after the successful registration.
  /// 
  /// Throws [CacheException] if no cached data is present.
  Future<UserModel> getUser();

  Future<void> cacheUser(UserModel userToCache);
}

const String CACHED_USER = 'CACHED_USER';


class UserCacheDataSourceImpl implements UserCacheDataSource{
  final SharedPreferences sharedPreferences;

  UserCacheDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> cacheUser(UserModel userToCache) async {
    sharedPreferences.setString(CACHED_USER, userToCache.toString());
  }

  @override
  Future<UserModel> getUser() async {
     final jsonString = sharedPreferences.getString(CACHED_USER);

    if(jsonString!=null){
      return await Future.value(UserModel.fromJson(json.decode(jsonString)));
    }else{
      throw CacheException();
    }

  }

}