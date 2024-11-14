import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/core/router/app_router.dart';
import 'package:marketplace/core/utils/extension.dart';
import 'package:marketplace/di.dart';
import 'package:marketplace/features/auth/domain/entities/login/login_request.dart';
import 'package:marketplace/features/auth/domain/entities/signup/sign_up_request.dart';
import 'package:marketplace/features/auth/domain/entities/user/user_data.dart';
import 'package:marketplace/features/auth/domain/use_cases/edit_profile_use_case.dart';
import 'package:marketplace/features/auth/domain/use_cases/get_profile_use_case.dart';
import 'package:marketplace/features/auth/domain/use_cases/login_usecase.dart';
import 'package:marketplace/features/auth/domain/use_cases/sign_up_use_case.dart';

class AuthRiverPod extends ChangeNotifier {
  AuthRiverPod(this._loginUseCase,this._signUpUseCase,
      this._getProfileUseCase, this._editProfileUseCase);

  final LoginUseCase _loginUseCase;
  final SignUpUseCase _signUpUseCase;
  final GetProfileUseCase _getProfileUseCase;
  final EditProfileUseCase _editProfileUseCase;
  UserData? userData;
  bool isBusy = false;
  bool isSuccessful = false;
  bool hasError = false;

  Future login(LoginRequest params,BuildContext context) async {
    isBusy = true;
    notifyListeners();
    await _loginUseCase.call(params).then((value) {
      value.fold((failure) {
        isBusy = false;
        hasError = true;
        isSuccessful = false;
        context.showSnackBar(
          message: failure.message ?? '',
          type: SnackBarType.error,
        );
        notifyListeners();
      }, (success) {
        isBusy = false;
        hasError = false;
        isSuccessful = true;
        getProfile(context);
        notifyListeners();
      });
    });
  }

  Future signUp(SignUpRequest params,BuildContext context) async {
    isBusy = true;
    notifyListeners();
    await _signUpUseCase.call(params).then((value) {
      value.fold((failure) {
        isBusy = false;
        hasError = true;
        isSuccessful = false;
        context.showSnackBar(
          message: failure.message ?? '',
          type: SnackBarType.error,
        );
        notifyListeners();
      }, (success) {
        isBusy = false;
        hasError = false;
        isSuccessful = true;
        login(LoginRequest(email: success.email,
            password: success.password), context);
        notifyListeners();
      });
    });
  }

  Future getProfile(BuildContext context) async {
    isBusy = true;
    notifyListeners();
    await _getProfileUseCase.call(null).then((value) {
      value.fold((failure) {
        isBusy = false;
        hasError = true;
        isSuccessful = false;
        context.showSnackBar(
          message: failure.message ?? '',
          type: SnackBarType.error,
        );
        notifyListeners();
      }, (success) {
        isBusy = false;
        hasError = false;
        isSuccessful = true;
        userData = success;
         context.router.push(const DashboardRoute());
        notifyListeners();
      });
    });
  }

  Future editProfile(UserData params,BuildContext context) async {
    isBusy = true;
    notifyListeners();
    await _editProfileUseCase.call(params).then((value) {
      value.fold((failure) {
        isBusy = false;
        hasError = true;
        isSuccessful = false;
        context.showSnackBar(
          message: failure.message ?? '',
          type: SnackBarType.error,
        );
        notifyListeners();
      }, (success) {
        isBusy = false;
        hasError = false;
        isSuccessful = true;
        context.showSnackBar(
          message: 'Successful',
          type: SnackBarType.success,
        );
        userData = userData;
         context.router.back();
        notifyListeners();
      });
    });
  }
}

final auth = ChangeNotifierProvider<AuthRiverPod>(
    (ref) => AuthRiverPod(
        sl<LoginUseCase>(),
        sl<SignUpUseCase>(),
        sl<GetProfileUseCase>(),
        sl<EditProfileUseCase>(),),);
