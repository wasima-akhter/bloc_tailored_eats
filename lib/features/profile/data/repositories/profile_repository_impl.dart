import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  const ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Profile> getUserDetail() {
    return remoteDataSource.getUserDetail();
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
  }) {
    return remoteDataSource.completeProfile(
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

  @override
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
  }) {
    return remoteDataSource.updateProfile(
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
