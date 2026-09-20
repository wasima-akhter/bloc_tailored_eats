import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/home_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeModel> getHomeData();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient apiClient;

  const HomeRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<HomeModel> getHomeData() async {
    final response = await apiClient.dio.get(ApiEndpoints.userDetail);

    final responseData = response.data as Map<String, dynamic>;

    final data = responseData['data'] as Map<String, dynamic>? ?? {};

    return HomeModel.fromJson(data);
  }
}
