import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

class Register {
  final AuthRepository repository;

  const Register(this.repository);

  Future<(AuthUser user, String accessToken)> call({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    return repository.register(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
