import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_go_app/features/home/data/repositories/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;

  HomeCubit(this._homeRepository) : super(HomeInitial());

  Future<void> fetchHomeData() async {
    emit(HomeLoading());
    try {
      final data = await _homeRepository.getHomeData();
      emit(HomeSuccess(data));
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }
}