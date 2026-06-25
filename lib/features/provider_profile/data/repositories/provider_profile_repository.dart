import 'package:servi_go_app/features/provider_profile/data/data_sources/provider_profile_remote_data_source.dart';
import 'package:servi_go_app/features/provider_profile/data/models/provider_profile_model.dart';

class ProviderProfileRepository {
  final ProviderProfileRemoteDataSource _remoteDataSource;

  ProviderProfileRepository(this._remoteDataSource);

  Future<ProviderProfileModel> getProviderProfile() async {
    try {
      final response = await _remoteDataSource.getProviderProfile();
      
      return ProviderProfileModel.fromJson(response);
    } catch (e) {
     
      rethrow;
    }
  }
}