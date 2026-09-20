import '../../domain/entities/home_data.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  const HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<HomeData> getHomeData() {
    return remoteDataSource.getHomeData();
  }
}
