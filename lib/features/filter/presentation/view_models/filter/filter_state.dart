import 'package:servi_go_app/features/filter/data/models/provider_filter_model.dart';
import 'package:servi_go_app/features/filter/domain/entities/sub_service_entity.dart';

// تمثيل حالات التحميل والخطأ والنجاح عبر enum لجعل الملف نظيفاً وموحداً
enum FilterStatus { initial, loading, success, error }

class FilterState {
  final FilterStatus status;
  final List<ProviderFilterModel> topProviders;
  final List<ProviderFilterModel> filteredProviders;
  final List<SubServiceEntity> subServices;
  final String? errorMessage;

  FilterState({
    this.status = FilterStatus.initial,
    this.topProviders = const [],
    this.filteredProviders = const [],
    this.subServices = const [],
    this.errorMessage,
  });

 
  FilterState copyWith({
    FilterStatus? status,
    List<ProviderFilterModel>? topProviders,
    List<ProviderFilterModel>? filteredProviders,
    List<SubServiceEntity>? subServices,
    String? errorMessage,
  }) {
    return FilterState(
      status: status ?? this.status,
      topProviders: topProviders ?? this.topProviders,
      filteredProviders: filteredProviders ?? this.filteredProviders,
      subServices: subServices ?? this.subServices,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}