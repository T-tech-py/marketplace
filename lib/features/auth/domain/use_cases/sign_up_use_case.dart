import 'package:dartz/dartz.dart';
import 'package:marketplace/core/utils/failure.dart';
import 'package:marketplace/core/utils/use_case.dart';
import 'package:marketplace/features/auth/domain/entities/signup/sign_up_request.dart';
import 'package:marketplace/features/auth/domain/entities/user/user_data.dart';
import 'package:marketplace/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase implements UseCase<UserData,SignUpRequest>{
  final AuthRepository _authRepository;
  SignUpUseCase(this._authRepository);

  @override
  Future<Either<Failure,UserData>> call(SignUpRequest params) {
    return _authRepository.signup(params);
  }
}