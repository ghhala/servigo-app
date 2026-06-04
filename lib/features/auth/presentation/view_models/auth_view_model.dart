import 'dart:math';
import 'package:flutter/material.dart';
import '../../data/sources/otp_service.dart';  

class AuthViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? generatedOtp;

  Future<bool> sendOtpToUser(String email) async {
    isLoading = true;
    notifyListeners();

    
    generatedOtp = (100000 + Random().nextInt(900000)).toString();

     
    bool isSent = await EmailJSOTP.sendOTP(
      targetEmail: email.trim(),
      otpCode: generatedOtp!,
    );

    isLoading = false;
    notifyListeners();
    return isSent;
  }
}