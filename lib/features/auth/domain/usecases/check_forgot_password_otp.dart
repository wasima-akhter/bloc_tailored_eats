import '../repositories/auth_repository.dart';

class CheckForgotPasswordOtp {
  final AuthRepository repository;

  const CheckForgotPasswordOtp(this.repository);

  Future<(String email, String activationToken)> call({
    required String email,
    required String otp,
  }) {
    return repository.checkForgotPasswordOtp(email: email, otp: otp);
  }
}
