
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_go_app/features/filter/data/models/filter_request_model.dart';
import 'package:servi_go_app/features/filter/data/repositories/filter_repository_impl.dart';
import 'package:servi_go_app/features/filter/presentation/view_models/filter/filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  final FilterRepository filterRepository;
  int? _mainServiceId;

  FilterCubit({required this.filterRepository}) : super(FilterState());

  Future<void> loadTopProviders(int mainServiceId) async {
    _mainServiceId = mainServiceId;
    emit(state.copyWith(status: FilterStatus.loading));
    try {
      final topProviders =
          await filterRepository.getTopFiveProviders(mainServiceId);
      emit(state.copyWith(
          status: FilterStatus.success, topProviders: topProviders));
    } catch (e) {
      emit(state.copyWith(
          status: FilterStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> fetchFilteredProviders(FilterRequestModel request) async {
    emit(state.copyWith(status: FilterStatus.loading));
    try {
      final results = await filterRepository.getFilteredProviders(request);
      emit(state.copyWith(
          status: FilterStatus.success, filteredProviders: results));
    } catch (e) {
      emit(state.copyWith(
          status: FilterStatus.error, errorMessage: e.toString()));
    }
  }

  
  Future<void> fetchFilteredProvidersAndSortByLocation({
    required FilterRequestModel request,
    required double userLat,
    required double userLng,
  }) async {
    emit(state.copyWith(status: FilterStatus.loading));
    try {
      // نجلب بدون sort_by لتجنب خطأ acos في SQLite
      final results = await filterRepository.getFilteredProviders(request);

      // ✅ نرتب محلياً: الأقرب أولاً
      results.sort((a, b) {
        final distA = _calculateDistance(
          userLat,
          userLng,
          a.latitude ?? 0.0,
          a.longitude ?? 0.0,
        );
        final distB = _calculateDistance(
          userLat,
          userLng,
          b.latitude ?? 0.0,
          b.longitude ?? 0.0,
        );
        return distA.compareTo(distB);
      });

      emit(state.copyWith(
          status: FilterStatus.success, filteredProviders: results));
    } catch (e) {
      emit(state.copyWith(
          status: FilterStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> loadSubServices(int mainServiceId) async {
    if (state.subServices.isNotEmpty) return;
    try {
      final subServices =
          await filterRepository.getSubServices(mainServiceId);
      emit(state.copyWith(
          status: FilterStatus.success, subServices: subServices));
    } catch (e) {
      emit(state.copyWith(
          status: FilterStatus.error, errorMessage: e.toString()));
    }
  }

  int get mainServiceId => _mainServiceId ?? 0;

 
  double _calculateDistance(
      double lat1, double lng1, double lat2, double lng2) {
    const R = 6371.0; // نصف قطر الأرض بالكيلومتر
    final dLat = _toRad(lat2 - lat1);
    final dLng = _toRad(lng2 - lng1);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRad(lat1)) * cos(_toRad(lat2)) *
            sin(dLng / 2) * sin(dLng / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  double _toRad(double deg) => deg * (pi / 180);
}