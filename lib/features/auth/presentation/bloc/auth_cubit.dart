import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/storage/secure_storage.dart';
import '../../domain/usecases/check_email_otp.dart';
import '../../domain/usecases/check_forgot_password_otp.dart';
import '../../domain/usecases/forgot_password.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/register.dart';
import '../../domain/usecases/reset_password.dart';
import '../../domain/usecases/send_email_otp.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final Login login;
  final Register register;
  final SendEmailOtp sendEmailOtp;
  final CheckEmailOtp checkEmailOtp;
  final ForgotPassword forgotPassword;
  final CheckForgotPasswordOtp checkForgotPasswordOtp;
  final ResetPassword resetPassword;
  final SecureStorage secureStorage;

  String? forgotPasswordActivationToken;

  AuthCubit({
    required this.login,
    required this.register,
    required this.sendEmailOtp,
    required this.checkEmailOtp,
    required this.forgotPassword,
    required this.checkForgotPasswordOtp,
    required this.resetPassword,
    required this.secureStorage,
  }) : super(const AuthInitial());

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());

    try {
      final result = await login(email: email, password: password);

      final user = result.$1;
      final accessToken = result.$2;

      await secureStorage.saveAccessToken(accessToken);

      emit(AuthAuthenticated(user: user, accessToken: accessToken));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(const AuthLoading());

    try {
      final result = await register(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

      final user = result.$1;
      final accessToken = result.$2;

      await secureStorage.saveAccessToken(accessToken);

      emit(AuthAuthenticated(user: user, accessToken: accessToken));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> sendOtp({required String email}) async {
    emit(const AuthLoading());

    try {
      await sendEmailOtp(email: email);

      emit(const AuthSuccess(message: 'OTP sent successfully.'));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> verifyEmailOtp({
    required String email,
    required String otp,
  }) async {
    emit(const AuthLoading());

    try {
      await checkEmailOtp(email: email, otp: otp);

      emit(const AuthSuccess(message: 'Email verified successfully.'));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> requestForgotPassword({required String email}) async {
    emit(const AuthLoading());

    try {
      await forgotPassword(email: email);

      emit(const AuthSuccess(message: 'OTP sent successfully.'));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> verifyForgotPasswordOtp({
    required String email,
    required String otp,
  }) async {
    emit(const AuthLoading());

    try {
      final result = await checkForgotPasswordOtp(email: email, otp: otp);

      forgotPasswordActivationToken = result.$2;

      emit(AuthSuccess(message: result.$2));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> resetUserPassword({
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(const AuthLoading());

    try {
      await resetPassword(
        token: token,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      forgotPasswordActivationToken = null;

      emit(const AuthSuccess(message: 'Password reset successfully.'));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> logout() async {
    await secureStorage.removeAccessToken();

    emit(const AuthUnauthenticated());
  }
}
