import '../../../../core/utils/json_parser.dart';
import '../../domain/entities/auth_user.dart';

class AuthUserModel extends AuthUser {
  const AuthUserModel({
    required super.id,
    required super.name,
    required super.firstName,
    required super.lastName,
    required super.email,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: JsonParser.string(json['_id'] ?? json['id']),
      name: JsonParser.string(json['name']),
      firstName: JsonParser.string(json['firstName']),
      lastName: JsonParser.string(json['lastName']),
      email: JsonParser.string(json['email']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }
}

class LoginResponseModel {
  final AuthUserModel user;
  final String accessToken;

  const LoginResponseModel({required this.user, required this.accessToken});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};

    return LoginResponseModel(
      user: AuthUserModel.fromJson(data['user'] as Map<String, dynamic>? ?? {}),
      accessToken: JsonParser.string(data['accessToken']),
    );
  }
}

class RegisterResponseModel {
  final AuthUserModel user;
  final String accessToken;

  const RegisterResponseModel({required this.user, required this.accessToken});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};

    return RegisterResponseModel(
      user: AuthUserModel.fromJson(data['user'] as Map<String, dynamic>? ?? {}),
      accessToken: JsonParser.string(data['accessToken']),
    );
  }
}

class ForgotPasswordOtpResponseModel {
  final String email;
  final String activationToken;

  const ForgotPasswordOtpResponseModel({
    required this.email,
    required this.activationToken,
  });

  factory ForgotPasswordOtpResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};

    return ForgotPasswordOtpResponseModel(
      email: JsonParser.string(data['email']),
      activationToken: JsonParser.string(data['activationToken']),
    );
  }
}
