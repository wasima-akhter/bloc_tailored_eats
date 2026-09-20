import '../repositories/profile_repository.dart';

class CompleteProfile {
  final ProfileRepository repository;

  const CompleteProfile(this.repository);

  Future<void> call({
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
  }) {
    return repository.completeProfile(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      age: age,
      gender: gender,
      height: height,
      weight: weight,
      activityLevel: activityLevel,
      foodVibe: foodVibe,
      mainGoal: mainGoal,
      result: result,
      training: training,
    );
  }
}
