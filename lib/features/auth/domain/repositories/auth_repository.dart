import '../entities/auth_user.dart';

abstract class AuthRepository {
  Future<(AuthUser user, String accessToken)> login({
    required String email,
    required String password,
  });

  Future<(AuthUser user, String accessToken)> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<void> sendEmailOtp({required String email});

  Future<void> checkEmailOtp({required String email, required String otp});

  Future<void> forgotPassword({required String email});

  Future<(String email, String activationToken)> checkForgotPasswordOtp({
    required String email,
    required String otp,
  });

  Future<void> resetPassword({
    required String token,
    required String newPassword,
    required String confirmPassword,
  });
}
