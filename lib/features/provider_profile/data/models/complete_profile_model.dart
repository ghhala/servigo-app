import 'dart:io';
import 'package:dio/dio.dart';

class CompleteProfileModel {
  final File photo;
  final String locationDescription;
  final String aboutMe;
  final int subServiceId;
  final List<String> offDays;
  final String workStartTime;
  final String workEndTime;
  final double minPrice;
  final double maxPrice;
  final List<PortfolioInput> portfolio;
  final List<File> certificates;

  CompleteProfileModel({
    required this.photo,
    required this.locationDescription,
    required this.aboutMe,
    required this.subServiceId,
    required this.offDays,
    required this.workStartTime,
    required this.workEndTime,
    required this.minPrice,
    required this.maxPrice,
    required this.portfolio,
    required this.certificates,
  });

  // الدالة كما هي لتحضير الـ FormData للسيرفر
  Future<FormData> toFormData() async {
    final Map<String, dynamic> map = {
      'photo': await MultipartFile.fromFile(photo.path, filename: photo.path.split('/').last),
      'location_description': locationDescription,
      'about_me': aboutMe,
      'sub_service_id': subServiceId.toString(),
      'work_start_time': workStartTime,
      'work_end_time': workEndTime,
      'min_price': minPrice.toString(),
      'max_price': maxPrice.toString(),
      'currency': 'SYP', 
    };

    for (int i = 0; i < offDays.length; i++) {
      map['off_days[$i]'] = offDays[i].toLowerCase();
    }

    for (int i = 0; i < portfolio.length; i++) {
      map['portfolio[$i][file]'] = await MultipartFile.fromFile(
        portfolio[i].file.path,
        filename: portfolio[i].file.path.split('/').last,
      );
      map['portfolio[$i][description]'] = portfolio[i].description;
    }

    for (int i = 0; i < certificates.length; i++) {
      map['certificates[$i]'] = await MultipartFile.fromFile(
        certificates[i].path,
        filename: certificates[i].path.split('/').last,
      );
    }

    return FormData.fromMap(map);
  }
}

class PortfolioInput {
  final File file;
  final String description;

  PortfolioInput({required this.file, required this.description});
}