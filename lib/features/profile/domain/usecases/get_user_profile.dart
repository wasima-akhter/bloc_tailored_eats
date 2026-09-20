import '../entities/user_profile.dart';
import '../repositories/profile_repository.dart';

class GetUserDetail {
  final ProfileRepository repository;

  const GetUserDetail(this.repository);

  Future<Profile> call() {
    return repository.getUserDetail();
  }
}
