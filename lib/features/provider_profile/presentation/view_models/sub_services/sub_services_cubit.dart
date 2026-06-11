import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_go_app/features/provider_profile/data/repositories/sub_services_repository.dart';
import 'sub_services_state.dart';

class SubServicesCubit extends Cubit<SubServicesState> {
  final SubServicesRepository _repository;

  SubServicesCubit(this._repository) : super(SubServicesInitial());

  Future<void> fetchSubServices(int mainServiceId) async {
    emit(SubServicesLoading());
    try {
      final response = await _repository.getSubServices(mainServiceId);
      emit(SubServicesSuccess(response.subServices));
    } catch (e) {
      emit(SubServicesFailure(e.toString()));
    }
  }
}