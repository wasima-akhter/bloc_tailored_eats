import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_profile.dart';
import '../../domain/usecases/complete_profile.dart';
import '../../domain/usecases/get_user_profile.dart';
import '../../domain/usecases/update_profile.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserDetail getUserDetail;
  final CompleteProfile completeProfile;
  final UpdateProfile updateProfile;

  ProfileCubit({
    required this.getUserDetail,
    required this.completeProfile,
    required this.updateProfile,
  }) : super(const ProfileInitial());

  Future<void> loadProfile() async {
    emit(const ProfileLoading());

    try {
      final profile = await getUserDetail();

      emit(ProfileLoaded(profile: profile));
    } catch (e) {
      emit(ProfileFailure(message: e.toString()));
    }
  }

  Future<void> completeUserProfile({
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
    emit(const ProfileLoading());

    try {
      await completeProfile(
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

      emit(const ProfileSuccess(message: 'Profile completed successfully.'));
    } catch (e) {
      emit(ProfileFailure(message: e.toString()));
    }
  }

  Future<void> updateUserProfile({
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
    final currentState = state;

    Profile? currentProfile;

    if (currentState is ProfileLoaded) {
      currentProfile = currentState.profile;
    }

    emit(ProfileActionLoading(profile: currentProfile));

    try {
      final profile = await updateProfile(
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

      emit(ProfileLoaded(profile: profile));
    } catch (e) {
      emit(ProfileFailure(message: e.toString()));
    }
  }
}
