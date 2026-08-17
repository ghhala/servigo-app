
import 'package:servi_go_app/core/network/api_error.dart';
import 'package:servi_go_app/core/utils/pref_halper.dart';
import 'package:servi_go_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:servi_go_app/features/auth/data/models/register_user_request_body.dart';
import 'package:servi_go_app/features/auth/data/models/register_provider_request_body.dart';
import 'package:servi_go_app/features/auth/data/models/user_sign_up_response_model.dart';

class AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepository(this._authRemoteDataSource);

  Future<UserSignUpResponseModel> registerUser(
    RegisterUserRequestBody requestBody,
  ) async {
    try {
      final rawData = await _authRemoteDataSource.registerUser(requestBody);
      return UserSignUpResponseModel.fromJson(rawData);
    } on ApiError catch (e) {
      throw e;
    } catch (e) {
      throw ApiError(message: "unExpected error occured processing data : $e");
    }
  }

  Future<dynamic> registerProvider(
    RegisterProviderRequestBody requestBody,
  ) async {
    try {
      final result = await _authRemoteDataSource.registerProvider(requestBody);
      return result;
    } on ApiError catch (e) {
      throw e;
    } catch (e) {
      throw ApiError(message: "unExpected error occured processing data : $e");
    }
  }

  Future<dynamic> verifyOtp({
    required String email,
    required String otp,
    required String type,
  }) async {
    try {
      final rawData = await _authRemoteDataSource.verifyOtp(
        email: email,
        otp: otp,
        type: type,
      );

      if (rawData != null &&
          rawData['data'] != null &&
          rawData['data']['token'] != null) {
        final String token = rawData['data']['token'].toString();
        await PrefHelper.saveToken(token);
        await PrefHelper.saveEmail(email);
      }

      if (rawData != null && rawData['data'] != null) {
        if (rawData['data']['user'] != null &&
            rawData['data']['user']['name'] != null) {
          await PrefHelper.saveString(
            'user_name',
            rawData['data']['user']['name'].toString(),
          );
        } else if (rawData['data']['name'] != null) {
          await PrefHelper.saveString(
            'user_name',
            rawData['data']['name'].toString(),
          );
        }
      }

      return rawData;
    } on ApiError catch (e) {
      throw e;
    } catch (e) {
      throw ApiError(message: "unExpected error occured processing data : $e");
    }
  }

  Future<dynamic> resendOtp({
    required String email,
    required String type,
  }) async {
    try {
      final rawData = await _authRemoteDataSource.resendOtp(
        email: email,
        type: type,
      );
      return rawData;
    } on ApiError catch (e) {
      throw e;
    } catch (e) {
      throw ApiError(message: "unExpected error occured processing data : $e");
    }
  }

  Future<dynamic> forgotPassword({required String email}) async {
    try {
      final rawData = await _authRemoteDataSource.forgotPassword(email: email);
      return rawData;
    } on ApiError catch (e) {
      throw e;
    } catch (e) {
      throw ApiError(message: "unExpected error occured processing data : $e");
    }
  }

  Future<dynamic> resetPassword({
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final rawData = await _authRemoteDataSource.resetPassword(
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      return rawData;
    } on ApiError catch (e) {
      throw e;
    } catch (e) {
      throw ApiError(message: "unExpected error occured processing data : $e");
    }
  }

  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    try {
      final rawData = await _authRemoteDataSource.login(
        email: email,
        password: password,
      );
      return rawData;
    } on ApiError catch (e) {
      throw e;
    } catch (e) {
      throw ApiError(message: "unExpected error occured processing data : $e");
    }
  }

  Future<void> fetchAndSaveProfileAfterLogin({required String userType}) async {
    try {
      final bool isProvider = userType == 'labourer' || userType == 'provider';

      final dynamic rawData = isProvider
          ? await _authRemoteDataSource.getProviderProfile()
          : await _authRemoteDataSource.getCustomerProfile();

      if (rawData == null || rawData['data'] == null) return;

      final rootData = rawData['data'];

      final Map<String, dynamic> data =
          (rootData['user'] != null && rootData['user'] is Map)
              ? Map<String, dynamic>.from(rootData['user'])
              : Map<String, dynamic>.from(rootData);

      if (data['name'] != null && data['name'].toString().trim().isNotEmpty) {
        await PrefHelper.saveString('user_name', data['name'].toString());
      }

      if (data['phone'] != null && data['phone'].toString().trim().isNotEmpty) {
        await PrefHelper.saveString('user_phone', data['phone'].toString());
      }

      final String? photo = data['photo']?.toString();
      if (photo != null && photo.isNotEmpty && photo != 'null') {
        await PrefHelper.saveUserImage(photo);
      } else {
        await PrefHelper.clearUserImage();
      }

      // 👇 جديد: بنحفظ main_service_id بتاع صاحب المهنة (موجودة دايمًا حتى لو
      // البروفايل لسه مش مكتمل)، عشان نستخدمها كـ fallback في صفحة إكمال البروفايل
      if (isProvider &&
          rootData['provider'] != null &&
          rootData['provider'] is Map) {
        final providerData = Map<String, dynamic>.from(rootData['provider']);
        if (providerData['main_service_id'] != null) {
          await PrefHelper.saveString(
            'main_service_id',
            providerData['main_service_id'].toString(),
          );
        }
      }
    } catch (e) {
      // تجاهل أي خطأ هنا عشان ميوقفش عملية تسجيل الدخول
    }
  }
}