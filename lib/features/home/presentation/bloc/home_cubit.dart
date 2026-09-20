import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_home_data.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeData getHomeData;

  HomeCubit({required this.getHomeData}) : super(const HomeInitial());

  Future<void> loadHome() async {
    emit(const HomeLoading());

    try {
      final data = await getHomeData();

      emit(HomeLoaded(data: data));
    } catch (e) {
      emit(HomeFailure(message: e.toString()));
    }
  }
}
