import 'package:dio/dio.dart';
import 'package:servi_go_app/core/network/api_exception.dart';
import 'package:servi_go_app/core/network/dio_client.dart';

class ApiService {
  final DioClient _dioClient;

  ApiService(this._dioClient);

  Future<dynamic> get(String endPoint) async {
    try {
      final response = await _dioClient.dio.get(endPoint);
      return response.data; 
    } on DioException catch (e) {
      throw ApiException.handleError(e); 
    }
  }

  Future<dynamic> post(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.post(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw ApiException.handleError(e); 
    }
  }

  Future<dynamic> postFormData(String endPoint, FormData formData) async {
    try {
      final response = await _dioClient.dio.post(endPoint, data: formData);
      return response.data;
    } on DioException catch (e) {
      throw ApiException.handleError(e);
    }
  }

  
  Future<dynamic> put(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.put(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw ApiException.handleError(e);
    }
  }

 
  Future<dynamic> putFormData(String endPoint, FormData formData) async {
    try {
      final response = await _dioClient.dio.put(endPoint, data: formData);
      return response.data;
    } on DioException catch (e) {
      throw ApiException.handleError(e);
    }
  }
}