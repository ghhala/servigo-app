import '../../domain/entities/sub_service_entity.dart'; 
import '../models/provider_filter_model.dart';
import '../models/filter_request_model.dart';
import 'package:servi_go_app/core/network/api_service.dart'; 

abstract class FilterRemoteDataSource {
  Future<List<ProviderFilterModel>> getTopFiveProviders(int mainServiceId);
  Future<List<ProviderFilterModel>> getFilteredProviders(FilterRequestModel request);
  Future<List<SubServiceEntity>> getSubServices(int mainServiceId); 
}

class FilterRemoteDataSourceImpl implements FilterRemoteDataSource {
  final ApiService apiService; 

  FilterRemoteDataSourceImpl({required this.apiService});

  @override
 Future<List<ProviderFilterModel>> getTopFiveProviders(int mainServiceId) async {
  print("📡 [DataSource] calling search/top-providers/$mainServiceId");
  final response = await apiService.get('search/top-providers/$mainServiceId');
  print("📦 [DataSource] response: $response");

  if (response['success'] == true) {
    final List<dynamic> data = response['data'];
    print("📋 [DataSource] parsing ${data.length} items...");
    try {
      final result = data.map((json) {
        print("🔍 parsing: $json");
        return ProviderFilterModel.fromJson(json);
      }).toList();
      print("✅ parsing done successfully");
      return result;
    } catch (e) {
   
      rethrow;
    }
  } else {
    throw Exception(response['message'] ?? 'فشل في جلب أعلى مزودي الخدمة');
  }
}

  @override
  Future<List<ProviderFilterModel>> getFilteredProviders(FilterRequestModel request) async {
    final Map<String, dynamic> params = request.toJson();
    params.removeWhere((key, value) => value == null);
    final cleanParams = params.map((key, value) => MapEntry(key, value.toString()));
    final queryString = Uri(queryParameters: cleanParams).query;
    final response = await apiService.get('search/providers?$queryString'); 
    
    if (response['success'] == true) {
      final List<dynamic> data = response['data'];
      return data.map((json) => ProviderFilterModel.fromJson(json)).toList();
    } else {
      throw Exception(response['message'] ?? 'فشل في تطبيق الفلترة والترتيب');
    }
  }

  @override
  Future<List<SubServiceEntity>> getSubServices(int mainServiceId) async {
    final response = await apiService.get('search/sub-services/$mainServiceId');

    if (response['success'] == true) {
      final Map<String, dynamic> data = response['data'];
      final List<dynamic> subServices = data['sub_services'] ?? [];

      return subServices.map((json) {
        return SubServiceEntity(
          id: (json['id'] ?? 0) as int,
          nameAr: (json['name_ar'] ?? '') as String,
          nameEn: (json['name_en'] ?? json['name_ar'] ?? '') as String,
        );
      }).toList();
    } else {
      throw Exception(response['message'] ?? 'فشل في جلب الخدمات الفرعية');
    }
  }
}