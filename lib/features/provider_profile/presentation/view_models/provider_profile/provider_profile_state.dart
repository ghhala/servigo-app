import 'package:servi_go_app/features/provider_profile/data/models/provider_profile_model.dart';

abstract class ProviderProfileState {}

class ProviderProfileInitial extends ProviderProfileState {}

class ProviderProfileLoading extends ProviderProfileState {}

class ProviderProfileSuccess extends ProviderProfileState {
  final ProviderProfileModel profileModel;

 
  final Set<int> myRatingIds;

  ProviderProfileSuccess(this.profileModel, {this.myRatingIds = const {}});
}

class ProviderProfileFailure extends ProviderProfileState {
  final String errorMessage;
  ProviderProfileFailure(this.errorMessage);
}