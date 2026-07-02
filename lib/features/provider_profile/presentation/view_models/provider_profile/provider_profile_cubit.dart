import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_go_app/features/provider_profile/data/repositories/provider_profile_repository.dart';
import 'package:servi_go_app/features/provider_profile/presentation/view_models/provider_profile/provider_profile_state.dart';

class ProviderProfileCubit extends Cubit<ProviderProfileState> {
  final ProviderProfileRepository _repository;
  ProviderProfileCubit(this._repository) : super(ProviderProfileInitial());

  // 🚀 التعديل هنا: إضافة {int? providerId} كـ المعامل اختياري ومسمى (Named Parameter)
  Future<void> fetchProviderProfile({int? providerId}) async {
    emit(ProviderProfileLoading());
    try {
      // 🚀 تمرير الـ providerId إلى الـ Repository
      final profileModel = await _repository.getProviderProfile(providerId: providerId);

      emit(ProviderProfileSuccess(profileModel));
    } catch (e) {
      emit(ProviderProfileFailure(e.toString()));
    }
  }

  // ✅ تبديل حالة المفضلة (Optimistic Update) بدون إعادة تحميل الصفحة كلها
  Future<void> toggleFavourite({required int providerId}) async {
    final currentState = state;
    if (currentState is! ProviderProfileSuccess) return;

    final currentData = currentState.profileModel.data;
    if (currentData == null) return;

    final bool previousValue = currentData.isFavourite ?? false;

    // تحديث فوري في الواجهة قبل رد السيرفر
    emit(ProviderProfileSuccess(
      currentState.profileModel.copyWith(
        data: currentData.copyWith(isFavourite: !previousValue),
      ),
    ));

    try {
      final serverValue = await _repository.toggleFavourite(providerId);
      // تأكيد القيمة الحقيقية القادمة من السيرفر
      emit(ProviderProfileSuccess(
        currentState.profileModel.copyWith(
          data: currentData.copyWith(isFavourite: serverValue),
        ),
      ));
    } catch (e) {
      // فشل الطلب → رجّعي القيمة القديمة
      emit(ProviderProfileSuccess(
        currentState.profileModel.copyWith(
          data: currentData.copyWith(isFavourite: previousValue),
        ),
      ));
      rethrow;
    }
  }

  // ✅ إرسال شكوى ضد مقدم الخدمة
  Future<void> sendComplaint({
    required int providerId,
    required String message,
  }) async {
    await _repository.sendComplaint(providerId: providerId, message: message);
  }

  // ✅ إضافة تقييم + تعليق، ثم إعادة تحميل البروفايل لتحديث avg_rating والتعليقات
  Future<void> rateProvider({
    required int providerId,
    required int rating,
    required String review,
  }) async {
    await _repository.rateProvider(
      providerId: providerId,
      rating: rating,
      review: review,
    );
    await fetchProviderProfile(providerId: providerId);
  }
}