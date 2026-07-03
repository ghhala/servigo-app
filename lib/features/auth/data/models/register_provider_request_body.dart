import 'package:dio/dio.dart';

class RegisterProviderRequestBody {
  String? name;
  String? email;
  String? phone;
  String? password;
  String? passwordConfirmation;
  String? locationName;
  double? latitude;
  double? longitude;
  String? workType;
  String? mainServiceId;
  String? idPhotoFrontPath;
  String? idPhotoBackPath;

  RegisterProviderRequestBody({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.passwordConfirmation,
    this.locationName,
    this.latitude,
    this.longitude,
    this.workType,
    this.mainServiceId,
    this.idPhotoFrontPath,
    this.idPhotoBackPath,
  });

  Future<FormData> toFormData() async {
    final map = <String, dynamic>{};

    if (name != null) map['name'] = name;
    if (email != null) map['email'] = email;
    if (phone != null) map['phone'] = phone;
    if (password != null) map['password'] = password;
    if (passwordConfirmation != null) map['password_confirmation'] = passwordConfirmation;
    if (locationName != null) map['location_name'] = locationName;
    
   
    if (latitude != null) map['latitude'] = latitude.toString();
    if (longitude != null) map['longitude'] = longitude.toString();
    
    if (workType != null) map['work_type'] = workType;
    if (mainServiceId != null) map['main_service_id'] = mainServiceId;

    // Handle image files
    if (idPhotoFrontPath != null && idPhotoFrontPath!.isNotEmpty) {
      map['id_photo_front'] = await MultipartFile.fromFile(
        idPhotoFrontPath!,
        filename: 'id_photo_front.jpg',
      );
    }

    if (idPhotoBackPath != null && idPhotoBackPath!.isNotEmpty) {
      map['id_photo_back'] = await MultipartFile.fromFile(
        idPhotoBackPath!,
        filename: 'id_photo_back.jpg',
      );
    }

    return FormData.fromMap(map);
  }
}