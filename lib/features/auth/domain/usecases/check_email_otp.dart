import '../repositories/auth_repository.dart';

class CheckEmailOtp {
  final AuthRepository repository;

  const CheckEmailOtp(this.repository);

  Future<void> call({required String email, required String otp}) {
    return repository.checkEmailOtp(email: email, otp: otp);
  }
}
