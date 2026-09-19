import '../repositories/auth_repository.dart';

class SendEmailOtp {
  final AuthRepository repository;

  const SendEmailOtp(this.repository);

  Future<void> call({required String email}) {
    return repository.sendEmailOtp(email: email);
  }
}
