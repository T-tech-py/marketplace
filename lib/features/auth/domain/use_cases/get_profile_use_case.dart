import 'package:dartz/dartz.dart';
import 'package:marketplace/core/utils/failure.dart';
import 'package:marketplace/core/utils/use_case.dart';
import 'package:marketplace/features/auth/domain/entities/user/user_data.dart';
import 'package:marketplace/features/auth/domain/repositories/auth_repository.dart';

class GetProfileUseCase implements UseCase<UserData,Null>{
  final AuthRepository _authRepository;
  GetProfileUseCase(this._authRepository);

  @override
  Future<Either<Failure,UserData>> call(Null params) {
    return _authRepository.getProfile();
  }
}
