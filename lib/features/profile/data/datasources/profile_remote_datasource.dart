import 'package:dio/dio.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/user_profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getUserDetail();

  Future<void> completeProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required int age,
    required String gender,
    required double height,
    required double weight,
    required String activityLevel,
    required String foodVibe,
    required String mainGoal,
    required String result,
    required String training,
  });

  Future<ProfileModel> updateProfile({
    String? profileImagePath,
    String? firstName,
    String? lastName,
    int? age,
    String? gender,
    double? height,
    String? activityLevel,
    String? foodVibe,
    String? mainGoal,
    String? result,
    String? training,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient apiClient;

  const ProfileRemoteDataSourceImpl({required this.apiClient});

  Map<String, dynamic> _extractData(dynamic responseData) {
    if (responseData is! Map<String, dynamic>) {
      return {};
    }

    final data = responseData['data'];

    if (data is Map<String, dynamic>) {
      return data;
    }

    return {};
  }

  @override
  Future<ProfileModel> getUserDetail() async {
    final response = await apiClient.dio.get(ApiEndpoints.userDetail);

    final data = _extractData(response.data);

    final user = data['user'];

    if (user is Map<String, dynamic>) {
      return ProfileModel.fromJson(user);
    }

    return ProfileModel.fromJson(data);
  }

  @override
  Future<void> completeProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required int age,
    required String gender,
    required double height,
    required double weight,
    required String activityLevel,
    required String foodVibe,
    required String mainGoal,
    required String result,
    required String training,
  }) async {
    await apiClient.dio.patch(
      ApiEndpoints.completeProfile,
      data: {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'age': age,
        'gender': gender,
        'height': height,
        'weight': weight,
        'activityLevel': activityLevel,
        'foodVibe': foodVibe,
        'mainGoal': mainGoal,
        'result': result,
        'training': training,
      },
    );
  }

  @override
  Future<ProfileModel> updateProfile({
    String? profileImagePath,
    String? firstName,
    String? lastName,
    int? age,
    String? gender,
    double? height,
    String? activityLevel,
    String? foodVibe,
    String? mainGoal,
    String? result,
    String? training,
  }) async {
    final formData = FormData();

    if (profileImagePath != null && profileImagePath.isNotEmpty) {
      formData.files.add(
        MapEntry(
          'profile_image',
          await MultipartFile.fromFile(profileImagePath),
        ),
      );
    }

    if (firstName != null) {
      formData.fields.add(MapEntry('firstName', firstName));
    }

    if (lastName != null) {
      formData.fields.add(MapEntry('lastName', lastName));
    }

    if (age != null) {
      formData.fields.add(MapEntry('age', age.toString()));
    }

    if (gender != null) {
      formData.fields.add(MapEntry('gender', gender));
    }

    if (height != null) {
      formData.fields.add(MapEntry('height', height.toString()));
    }

    if (activityLevel != null) {
      formData.fields.add(MapEntry('activityLevel', activityLevel));
    }

    if (foodVibe != null) {
      formData.fields.add(MapEntry('foodVibe', foodVibe));
    }

    if (mainGoal != null) {
      formData.fields.add(MapEntry('mainGoal', mainGoal));
    }

    if (result != null) {
      formData.fields.add(MapEntry('result', result));
    }

    if (training != null) {
      formData.fields.add(MapEntry('training', training));
    }

    final response = await apiClient.dio.patch(
      ApiEndpoints.updateProfile,
      data: formData,
    );

    final data = _extractData(response.data);

    return ProfileModel.fromJson(data);
  }
}
