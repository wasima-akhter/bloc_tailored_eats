import '../repositories/auth_repository.dart';

class ForgotPassword {
  final AuthRepository repository;

  const ForgotPassword(this.repository);

  Future<void> call({required String email}) {
    return repository.forgotPassword(email: email);
  }
}
