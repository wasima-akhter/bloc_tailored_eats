import '../entities/user_profile.dart';
import '../repositories/profile_repository.dart';

class UpdateProfile {
  final ProfileRepository repository;

  const UpdateProfile(this.repository);

  Future<Profile> call({
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
  }) {
    return repository.updateProfile(
      profileImagePath: profileImagePath,
      firstName: firstName,
      lastName: lastName,
      age: age,
      gender: gender,
      height: height,
      activityLevel: activityLevel,
      foodVibe: foodVibe,
      mainGoal: mainGoal,
      result: result,
      training: training,
    );
  }
}
