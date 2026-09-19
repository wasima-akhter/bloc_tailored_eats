import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<(AuthUser user, String accessToken)> login({
    required String email,
    required String password,
  }) async {
    final response = await remoteDataSource.login(
      email: email,
      password: password,
    );

    return (response.user, response.accessToken);
  }

  @override
  Future<(AuthUser user, String accessToken)> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await remoteDataSource.register(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );

    return (response.user, response.accessToken);
  }

  @override
  Future<void> sendEmailOtp({required String email}) {
    return remoteDataSource.sendEmailOtp(email: email);
  }

  @override
  Future<void> checkEmailOtp({required String email, required String otp}) {
    return remoteDataSource.checkEmailOtp(email: email, otp: otp);
  }

  @override
  Future<void> forgotPassword({required String email}) {
    return remoteDataSource.forgotPassword(email: email);
  }

  @override
  Future<(String email, String activationToken)> checkForgotPasswordOtp({
    required String email,
    required String otp,
  }) async {
    final response = await remoteDataSource.checkForgotPasswordOtp(
      email: email,
      otp: otp,
    );

    return (response.email, response.activationToken);
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) {
    return remoteDataSource.resetPassword(
      token: token,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}
