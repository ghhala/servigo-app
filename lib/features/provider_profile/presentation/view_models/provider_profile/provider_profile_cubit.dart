
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_go_app/features/provider_profile/data/repositories/provider_profile_repository.dart';
import 'package:servi_go_app/features/provider_profile/presentation/view_models/provider_profile/provider_profile_state.dart';

class ProviderProfileCubit extends Cubit<ProviderProfileState> {
  final ProviderProfileRepository _repository;

  ProviderProfileCubit(this._repository) : super(ProviderProfileInitial());


  Future<void> fetchProviderProfile() async {
    emit(ProviderProfileLoading());
    try {
 
      final profileModel = await _repository.getProviderProfile();
  
      emit(ProviderProfileSuccess(profileModel));
    } catch (e) {
     
      emit(ProviderProfileFailure(e.toString()));
    }
  }
}