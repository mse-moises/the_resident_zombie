import 'package:the_resident_zombie/features/user/data/models/user_model.dart';

abstract class UserRemoteDataSource{
  ///Send a http post request for the http://zssn-backend-example.herokuapp.com/api/people.json endpoint.
  ///
  ///
  ///Throws a [ServerException] for all error codes.

  @override
  Future<UserModel> createUser(String name, int age, String gender);
}