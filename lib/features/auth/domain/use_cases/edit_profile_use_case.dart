import 'package:dartz/dartz.dart';
import 'package:marketplace/core/utils/failure.dart';
import 'package:marketplace/core/utils/use_case.dart';
import 'package:marketplace/features/auth/domain/entities/user/user_data.dart';
import 'package:marketplace/features/auth/domain/repositories/auth_repository.dart';

class EditProfileUseCase implements UseCase<UserData,UserData>{
  final AuthRepository _authRepository;
  EditProfileUseCase(this._authRepository);

  @override
  Future<Either<Failure,UserData>> call(UserData params) {
    return _authRepository.editProfile(params);
  }
}
