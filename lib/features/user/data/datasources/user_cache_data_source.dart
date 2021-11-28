import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_resident_zombie/core/error/exceptions.dart';
import 'package:the_resident_zombie/features/user/data/models/user_model.dart';

abstract class UserCacheDataSource {
  /// Gets the cached [UserModel] which was saved after the successful registration.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<UserModel> getUser();

  Future<void> cacheUser(UserModel userToCache);

  Future<String> saveContact(String id);

  Future<List<String>> getAllContactsIds();
}

const String CACHED_USER = 'CACHED_USER';
const String CACHED_CONTACT = 'CACHED_CONTACT';

class UserCacheDataSourceImpl implements UserCacheDataSource {
  final SharedPreferences sharedPreferences;

  UserCacheDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> cacheUser(UserModel userToCache) async {
    sharedPreferences.setString(CACHED_USER, userToCache.toString());
  }

  @override
  Future<UserModel> getUser() async {
    final jsonString = sharedPreferences.getString(CACHED_USER);

    if (jsonString != null) {
      return await Future.value(UserModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<String> saveContact(String id) async {
    try {
      final getStoredContacts = sharedPreferences.getString(CACHED_CONTACT);

      String newContactString = "";
      if (getStoredContacts != null) {
        newContactString = "$getStoredContacts;$id";
      } else {
        newContactString = id;
      }

      final result = await sharedPreferences.setString(CACHED_CONTACT, newContactString);

      if(!result) throw CacheException();

      return id;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<String>> getAllContactsIds() async {
     try {
      final getStoredContacts = sharedPreferences.getString(CACHED_CONTACT);
      if(getStoredContacts==null) return [];
      return getStoredContacts.split(';');
    } catch (e) {
      throw CacheException();
    }
  }
}
