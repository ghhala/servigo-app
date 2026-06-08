
import 'package:servi_go_app/features/home/data/models/home_response_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeSuccess extends HomeState {
  final HomeResponseModel homeData;
  HomeSuccess(this.homeData);
}
class HomeFailure extends HomeState {
  final String errorMessage;
  HomeFailure(this.errorMessage);
}