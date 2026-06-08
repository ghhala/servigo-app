import '../data_sources/home_remote_data_source.dart';
import '../models/home_response_model.dart';

class HomeRepository {
  final HomeRemoteDataSource _homeRemoteDataSource;

  HomeRepository(this._homeRemoteDataSource);

  Future<HomeResponseModel> getHomeData() async {
    try {
    
      final result = await _homeRemoteDataSource.getHomeData();
      return result;
    } on Exception catch (e) {
     
      throw e; 
    } catch (e) {
     
      throw Exception("Unexpected error occurred processing home data: $e");
    }
  }
}