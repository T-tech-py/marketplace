import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:marketplace/core/services/network_service.dart';
import 'package:marketplace/core/services/user_storage_service.dart';
import 'package:marketplace/core/utils/failure.dart';
import 'package:marketplace/features/auth/dl.dart';
import 'package:marketplace/features/auth/domain/entities/login/login_request.dart';
import 'package:marketplace/features/auth/domain/entities/login/login_response.dart';
import 'package:marketplace/features/auth/domain/entities/signup/sign_up_request.dart';
import 'package:marketplace/features/auth/domain/entities/user/user_data.dart';
import 'package:marketplace/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final NetworkApiService _networkApiService;

  AuthRepositoryImpl(this._networkApiService);

  @override
  Future<Either<Failure, LoginResponse>> login(LoginRequest param) async {
    try {
      final data = await _networkApiService.login(param.toJson());
      sl<UserStorageService>().saveToken(data.accessToken);
      return Right(data);
    } on DioException catch (e) {
      return const Left(ServerFailure(
        message: 'Unknown Error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, UserData>> signup(SignUpRequest param) async {
    try {
      final data = await _networkApiService.sign(param.toJson());

      return Right(data);
    } on DioException catch (e) {
      return const Left(ServerFailure(
        message: 'Unknown Error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, UserData>> editProfile(UserData param) async {
    try {
      final data = await _networkApiService.editProfile(param.toJson(),
      param.id.toString());

      return Right(data);
    } on DioException catch (e) {
      return const Left(ServerFailure(
        message: 'Unknown Error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, UserData>> getProfile() async {
    try {
      final data = await _networkApiService.getProfile();

      return Right(data);
    } on DioException catch (e) {
      return const Left(ServerFailure(
        message: 'Unknown Error occurred',
        statusCode: 500,
      ));
    }
  }
}
