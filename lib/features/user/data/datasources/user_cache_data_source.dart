import 'package:the_resident_zombie/features/user/data/models/user_model.dart';

abstract class UserCacheDataSource{
  /// Gets the cached [UserModel] which was saved after the successful registration.
  /// 
  /// Throws [CacheException] if no cached data is present.
  Future<UserModel> getUser();

  Future<void> cacheNumberTrivia(UserModel userToCache);
}