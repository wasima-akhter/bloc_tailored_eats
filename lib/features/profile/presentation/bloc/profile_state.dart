import 'package:equatable/equatable.dart';

import '../../domain/entities/user_profile.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  final Profile profile;

  const ProfileLoaded({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class ProfileActionLoading extends ProfileState {
  final Profile? profile;

  const ProfileActionLoading({this.profile});

  @override
  List<Object?> get props => [profile];
}

class ProfileSuccess extends ProfileState {
  final String message;

  const ProfileSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class ProfileFailure extends ProfileState {
  final String message;

  const ProfileFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
