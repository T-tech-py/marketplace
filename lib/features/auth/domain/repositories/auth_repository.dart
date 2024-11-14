import 'package:dartz/dartz.dart';
import 'package:marketplace/core/utils/failure.dart';
import 'package:marketplace/features/auth/domain/entities/login/login_request.dart';
import 'package:marketplace/features/auth/domain/entities/login/login_response.dart';
import 'package:marketplace/features/auth/domain/entities/signup/sign_up_request.dart';
import 'package:marketplace/features/auth/domain/entities/user/user_data.dart';

abstract class AuthRepository{
  Future<Either<Failure,LoginResponse>> login(LoginRequest param);
  Future<Either<Failure,UserData>> signup(SignUpRequest param);
  Future<Either<Failure,UserData>> getProfile();
  Future<Either<Failure,UserData>> editProfile(UserData param);
}
