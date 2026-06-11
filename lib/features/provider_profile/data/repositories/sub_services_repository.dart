import '../data_sources/sub_services_remote_data_source.dart';
import '../models/sub_services_response.dart';

class SubServicesRepository {
  final SubServicesRemoteDataSource _remoteDataSource;

  SubServicesRepository(this._remoteDataSource);

  Future<SubServicesResponse> getSubServices(int mainServiceId) async {
    try {
      return await _remoteDataSource.getSubServices(mainServiceId);
    } catch (e) {
      rethrow;
    }
  }
}