import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:marketplace/core/networking/interceptors/dio_interceptors.dart';
import 'package:marketplace/core/services/local_storage_service.dart';
import 'package:marketplace/core/services/network_service.dart';
import 'package:marketplace/core/services/user_storage_service.dart';
import 'package:marketplace/core/utils/app_env.dart';
import 'package:marketplace/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:marketplace/features/auth/domain/repositories/auth_repository.dart';
import 'package:marketplace/features/auth/domain/use_cases/edit_profile_use_case.dart';
import 'package:marketplace/features/auth/domain/use_cases/get_profile_use_case.dart';
import 'package:marketplace/features/auth/domain/use_cases/login_usecase.dart';
import 'package:marketplace/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:marketplace/features/auth/presentation/manager/auth_riverpod.dart';

GetIt sl = GetIt.instance;


Future<void> authDependencies() async {

  sl..registerLazySingleton<AuthRiverPod>(() =>
      AuthRiverPod( sl<LoginUseCase>(), sl<SignUpUseCase>(),
      sl<GetProfileUseCase>(),sl<EditProfileUseCase>())
  )..registerLazySingleton<LoginUseCase>(()=>
      LoginUseCase(sl<AuthRepository>()))
    ..registerLazySingleton<SignUpUseCase>(()=>
        SignUpUseCase(sl<AuthRepository>()))
    ..registerLazySingleton<GetProfileUseCase>(()=>
        GetProfileUseCase(sl<AuthRepository>()))
    ..registerLazySingleton<EditProfileUseCase>(()=>
        EditProfileUseCase(sl<AuthRepository>()))
    ..registerLazySingleton<AuthRepository>(()=>
      AuthRepositoryImpl(sl<NetworkApiService>()))
  ..registerLazySingleton<NetworkApiService>(()=>
      NetworkApiService(sl<Dio>()))
    ..registerLazySingleton<UserStorageService>(()=>
      UserStorageServiceImpl(sl<LocalStorageService>()))
    ..registerLazySingleton<Dio>(()=>Dio(
    BaseOptions(
      baseUrl: AppEnv.apiBaseURL
    )
  )..interceptors.addAll([ TokenInterceptor(
    storageService: sl<UserStorageService>(),
  ),LoggingInterceptor(
        storageService: sl<UserStorageService>(),
    logger: sl<Logger>())]))
  ..registerLazySingleton<LocalStorageService>(
          ()=> LocalStorageServiceImpl())
    ..registerLazySingleton<Logger>(
    Logger.new,
  );
}
