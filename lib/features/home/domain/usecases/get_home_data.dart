import '../entities/home_data.dart';
import '../repositories/home_repository.dart';

class GetHomeData {
  final HomeRepository repository;

  const GetHomeData(this.repository);

  Future<HomeData> call() {
    return repository.getHomeData();
  }
}
