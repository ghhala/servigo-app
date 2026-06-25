import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_go_app/features/filter/data/models/filter_request_model.dart';
import 'package:servi_go_app/features/filter/data/repositories/filter_repository_impl.dart';
import 'package:servi_go_app/features/filter/presentation/view_models/filter/filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  final FilterRepository filterRepository;
  int? _mainServiceId; // ✅ نحفظه هنا

  FilterCubit({required this.filterRepository}) : super(FilterState());

  Future<void> loadTopProviders(int mainServiceId) async {
    _mainServiceId = mainServiceId; 
    emit(state.copyWith(status: FilterStatus.loading));
    try {
      final topProviders = await filterRepository.getTopFiveProviders(mainServiceId);
      print("🟢 [FilterCubit] Got ${topProviders.length} providers");
      emit(state.copyWith(status: FilterStatus.success, topProviders: topProviders));
    } catch (e) {
        print("🔴 [FilterCubit] Error: $e");
      emit(state.copyWith(status: FilterStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> fetchFilteredProviders(FilterRequestModel request) async {
    emit(state.copyWith(status: FilterStatus.loading));
    try {
      final results = await filterRepository.getFilteredProviders(request);
      emit(state.copyWith(status: FilterStatus.success, filteredProviders: results));
    } catch (e) {
      emit(state.copyWith(status: FilterStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> loadSubServices(int mainServiceId) async {
    if (state.subServices.isNotEmpty) return;
    try {
      final subServices = await filterRepository.getSubServices(mainServiceId);
      emit(state.copyWith(status: FilterStatus.success, subServices: subServices));
    } catch (e) {
      emit(state.copyWith(status: FilterStatus.error, errorMessage: e.toString()));
    }
  }

 
  int get mainServiceId => _mainServiceId ?? 0;
}