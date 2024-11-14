import 'package:dartz/dartz.dart';
import 'package:marketplace/core/utils/failure.dart';
import 'package:marketplace/core/utils/use_case.dart';
import 'package:marketplace/features/auth/domain/entities/login/login_request.dart';
import 'package:marketplace/features/auth/domain/entities/login/login_response.dart';
import 'package:marketplace/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase implements UseCase<LoginResponse,LoginRequest>{
  final AuthRepository _authRepository;
  LoginUseCase(this._authRepository);

  @override
  Future<Either<Failure,LoginResponse>> call(LoginRequest params) {
  return _authRepository.login(params);
  }
}
