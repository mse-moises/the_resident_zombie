import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';
import 'package:the_resident_zombie/features/user/domain/repositories/user_repository.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/create_user_usecase.dart';

import 'create_user_usecase_test.mocks.dart';

@GenerateMocks([UserRepository])
void main(){
    late CreateUserUsecase usecase;
    late MockUserRepository mockUserRepository;

    setUp((){
      mockUserRepository = MockUserRepository();
      usecase = CreateUserUsecase(mockUserRepository);
    });

    final tName = "teste";
    final int tAge = 30;
    final tGender = "M";
    

    final UserEntity tUser = UserEntity(name:tName,age:tAge,gender:tGender);


    test('get User Entity for the UserRepository when request to create a user',
      () async {
        // arrange
        when(mockUserRepository.createUser(any, any, any)).thenAnswer((_) async => Right(tUser));

        // act
        final result = await usecase(name:tName,age:tAge,gender:tGender);

        // assert
        expect(result,Right(tUser));
        verify(mockUserRepository.createUser(tName,tAge,tGender));
      
      }
    );

}