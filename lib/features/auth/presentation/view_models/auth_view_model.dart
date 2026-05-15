import 'dart:math';
import 'package:flutter/material.dart';
import '../../data/sources/otp_service.dart'; // تأكد من المسار الصحيح

class AuthViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? generatedOtp;

  Future<bool> sendOtpToUser(String email) async {
    isLoading = true;
    notifyListeners(); // لتشغيل مؤشر التحميل في الواجهة

    // توليد الرمز
    generatedOtp = (100000 + Random().nextInt(900000)).toString();

    // استدعاء الخدمة
    bool isSent = await EmailJSOTP.sendOTP(
      targetEmail: email.trim(),
      otpCode: generatedOtp!,
    );

    isLoading = false;
    notifyListeners(); // لإيقاف مؤشر التحميل
    return isSent;
  }
}