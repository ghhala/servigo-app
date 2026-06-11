import 'package:servi_go_app/features/provider_profile/data/data_sources/complete_profile_remote_data_source.dart';
import 'package:servi_go_app/features/provider_profile/data/models/complete_profile_model.dart';
import 'package:servi_go_app/features/provider_profile/data/models/complete_profile_response.dart';



class CompleteProfileRepository {
  final CompleteProfileRemoteDataSource _remoteDataSource;

  CompleteProfileRepository(this._remoteDataSource);

  Future<CompleteProfileResponse> completeProfile(CompleteProfileModel params) async {
    try {
      return await _remoteDataSource.completeProfile(params);
    } catch (e) {
      // الـ ApiService يقوم بعمل handle للـ DioException مسبقاً لذا نمرر الخطأ كما هو
      rethrow;
    }
  }
}