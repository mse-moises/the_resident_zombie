import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_resident_zombie/core/platform/file_getter.dart';
import 'package:the_resident_zombie/core/platform/network_info.dart';
import 'package:the_resident_zombie/features/items/domain/usecase/compare_backpack_usecase.dart';
import 'package:the_resident_zombie/features/items/domain/usecase/get_backpack_from_numbers_usecase.dart';
import 'package:the_resident_zombie/features/items/domain/usecase/get_items_type_usecase.dart';
import 'package:the_resident_zombie/features/location/domain/usecases/compare_location_usecase.dart';
import 'package:the_resident_zombie/features/location/domain/usecases/get_location_usecase.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/trade_with_user_usecase.dart';

import 'core/platform/location_info.dart';
import 'features/items/data/datasource/items_local_datasource.dart';
import 'features/items/data/repository/items_repository.dart';
import 'features/location/data/datasources/local_location_data_source.dart';
import 'features/location/data/datasources/remote_location_data_source.dart';
import 'features/location/data/repositories/location_repository.dart';
import 'features/location/domain/usecases/get_location_from_id_usecase.dart';
import 'features/main/presentation/pages/splash_page/bloc/splash_page_bloc.dart';
import 'features/user/data/datasources/user_cache_data_source.dart';
import 'features/user/data/datasources/user_remote_data_source.dart';
import 'features/user/data/repositories/user_repository.dart';
import 'features/user/domain/usecases/create_user_usecase.dart';
import 'features/user/domain/usecases/flag_user_as_infected_usecase.dart';
import 'features/user/domain/usecases/get_all_contacts_usecase.dart';
import 'features/user/domain/usecases/get_local_user_usecase.dart';
import 'features/user/domain/usecases/get_user_by_id_usecase.dart';
import 'features/user/domain/usecases/save_contact_usecase.dart';
import 'features/user/domain/usecases/update_user_location_usecase.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  initBloc();
  initUsecase();
  initRepository();
  initDataSources();
  initCore();
  await initExternal();
}

void initBloc() {
  //! Bloc
  sl.registerFactory<SplashPageBloc>(
    () => SplashPageBloc(
      getLocalUser: sl(),
    ),
  );
}

void initUsecase() {
  //! Usecases
  // Items
  sl.registerLazySingleton<CompareBackpackUsecase>(
    () => CompareBackpackUsecase(),
  );
  sl.registerLazySingleton<GetItemsTypeUseCase>(
    () => GetItemsTypeUseCase(repository: sl()),
  );
  sl.registerLazySingleton<GetBackpackFromNumbersUsecase>(
    () => GetBackpackFromNumbersUsecase(getItemsType: sl()),
  );

  // Locations
  sl.registerLazySingleton<CompareLocationUseCase>(
    () => CompareLocationUseCase(),
  );
  sl.registerLazySingleton<GetLocationFromIdUseCase>(
    () => GetLocationFromIdUseCase(repository: sl()),
  );
  sl.registerLazySingleton<GetLocationUseCase>(
    () => GetLocationUseCase(repository: sl()),
  );

  // User
  sl.registerLazySingleton<CreateUserUsecase>(
    () => CreateUserUsecase(
        getBackpackUsecase: sl(), getLocationUsecase: sl(), repository: sl()),
  );

  sl.registerLazySingleton<FlagUserAsInfectedUseCase>(
    () => FlagUserAsInfectedUseCase(repository: sl()),
  );

  sl.registerLazySingleton<GetAllContactsUsecase>(
    () => GetAllContactsUsecase(getUserByIdUseCase: sl(), repository: sl()),
  );

  sl.registerLazySingleton<GetLocalUserUseCase>(
    () => GetLocalUserUseCase(repository: sl()),
  );

  sl.registerLazySingleton<GetUserByIdUseCase>(
    () => GetUserByIdUseCase(repository: sl()),
  );

  sl.registerLazySingleton<SaveContactUsecase>(
    () => SaveContactUsecase(repository: sl()),
  );

  sl.registerLazySingleton<TradeWithUserUseCase>(
    () => TradeWithUserUseCase(
        compareUsecase: sl(), getBackpackUsecase: sl(), repository: sl()),
  );

  sl.registerLazySingleton<UpdateUserLocationUsecase>(
    () => UpdateUserLocationUsecase(getLocationUsecase: sl(), repository: sl()),
  );
}

void initRepository() {
  //! Repository

  sl.registerLazySingleton<ItemsRepositoryImpl>(
    () => ItemsRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<LocationRepositoryImpl>(
    () => LocationRepositoryImpl(localDatasource: sl(), remoteDatasource: sl()),
  );

  sl.registerLazySingleton<UserRepositoryImpl>(
    () => UserRepositoryImpl(
        cacheDataSource: sl(), networkInfo: sl(), remoteDataSource: sl()),
  );
}

void initDataSources() {
  //! Data sources

  // Items
  sl.registerLazySingleton<ItemLocalDataSourceImpl>(
    () => ItemLocalDataSourceImpl(fileGetter: sl()),
  );

  // Location

  sl.registerLazySingleton<LocalLocationDataSourceImpl>(
    () => LocalLocationDataSourceImpl(localizationInfo: sl()),
  );

  sl.registerLazySingleton<RemoteLocationDataSourceImpl>(
    () => RemoteLocationDataSourceImpl(client: sl()),
  );

  // User

  sl.registerLazySingleton<UserCacheDataSourceImpl>(
    () => UserCacheDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<UserRemoteDataSourceImpl>(
    () => UserRemoteDataSourceImpl(client: sl()),
  );
}

void initCore() {
  //! Core
  sl.registerLazySingleton<FileGetterImpl>(
    () => FileGetterImpl(),
  );
  sl.registerLazySingleton<LocalizationInfoImpl>(
    () => LocalizationInfoImpl(),
  );
  sl.registerLazySingleton<NetworkInfoImpl>(
    () => NetworkInfoImpl(connectionChecker: sl()),
  );
}

Future<void> initExternal() async {
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(
    () => sharedPreferences,
  );
  sl.registerLazySingleton<http.Client>(
    () => http.Client(),
  );
  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker(),
  );
}
