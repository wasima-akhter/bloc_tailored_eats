import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/auth_models.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  });

  Future<RegisterResponseModel> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<void> sendEmailOtp({required String email});

  Future<void> checkEmailOtp({required String email, required String otp});

  Future<void> forgotPassword({required String email});

  Future<ForgotPasswordOtpResponseModel> checkForgotPasswordOtp({
    required String email,
    required String otp,
  });

  Future<void> resetPassword({
    required String token,
    required String newPassword,
    required String confirmPassword,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  const AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.login,
      data: {'email': email, 'password': password},
    );

    return LoginResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<RegisterResponseModel> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.register,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      },
    );

    return RegisterResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<void> sendEmailOtp({required String email}) async {
    await apiClient.dio.post(ApiEndpoints.sendEmailOtp, data: {'email': email});
  }

  @override
  Future<void> checkEmailOtp({
    required String email,
    required String otp,
  }) async {
    await apiClient.dio.post(
      ApiEndpoints.checkEmailOtp,
      data: {'email': email, 'otp': otp},
    );
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await apiClient.dio.post(
      ApiEndpoints.forgotPassword,
      data: {'email': email},
    );
  }

  @override
  Future<ForgotPasswordOtpResponseModel> checkForgotPasswordOtp({
    required String email,
    required String otp,
  }) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.checkForgotPasswordOtp,
      data: {'email': email, 'otp': otp},
    );

    return ForgotPasswordOtpResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    await apiClient.dio.patch(
      ApiEndpoints.resetPassword,
      data: {
        'token': token,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      },
    );
  }
}
