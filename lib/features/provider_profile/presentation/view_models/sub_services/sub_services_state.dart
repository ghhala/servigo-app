import 'package:servi_go_app/features/home/data/models/home_response_model.dart';

abstract class SubServicesState {}

class SubServicesInitial extends SubServicesState {}

class SubServicesLoading extends SubServicesState {}

class SubServicesSuccess extends SubServicesState {
  final List<SubService> subServices;
  SubServicesSuccess(this.subServices);
}

class SubServicesFailure extends SubServicesState {
  final String errorMessage;
  SubServicesFailure(this.errorMessage);
}