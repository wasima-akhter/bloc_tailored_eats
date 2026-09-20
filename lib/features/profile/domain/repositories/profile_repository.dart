import '../entities/user_profile.dart';

abstract class ProfileRepository {
  Future<Profile> getUserDetail();

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

  Future<Profile> updateProfile({
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
