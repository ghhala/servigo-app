import '../../domain/entities/sub_service_entity.dart';
import '../data_sources/filter_remote_data_source.dart';
import '../models/provider_filter_model.dart';
import '../models/filter_request_model.dart';

class FilterRepository {
  final FilterRemoteDataSource remoteDataSource;

  FilterRepository({required this.remoteDataSource});

  
  Future<List<ProviderFilterModel>> getTopFiveProviders(int mainServiceId) async {
    try {
      return await remoteDataSource.getTopFiveProviders(mainServiceId);
    } catch (e) {
      rethrow;
    }
  }

 
  Future<List<ProviderFilterModel>> getFilteredProviders(FilterRequestModel request) async {
    try {
      return await remoteDataSource.getFilteredProviders(request);
    } catch (e) {
      rethrow;
    }
  }

  
  Future<List<SubServiceEntity>> getSubServices(int mainServiceId) async {
    try {
      return await remoteDataSource.getSubServices(mainServiceId);
    } catch (e) {
      rethrow;
    }
  }
}