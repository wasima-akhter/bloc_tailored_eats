import '../repositories/auth_repository.dart';

class ResetPassword {
  final AuthRepository repository;

  const ResetPassword(this.repository);

  Future<void> call({
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) {
    return repository.resetPassword(
      token: token,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}
