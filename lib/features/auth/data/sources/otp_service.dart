import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailJSOTP {
  // استبدل هذه القيم بالأكواد التي نسختها من موقع EmailJS
  static const String _serviceId = 'service_ry8jtng';
  static const String _templateId = 'template_qryrxc6';
  static const String _publicKey = 'nD7_lFKp8JLC7fl47';

  // دالة لإرسال الرمز
  static Future<bool> sendOTP({
    required String targetEmail,
    required String otpCode,
  }) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'origin': 'http://localhost', 
        },
        body: json.encode({
          'service_id': _serviceId,
          'template_id': _templateId,
          'user_id': _publicKey,
          'template_params': {
            'user_email': targetEmail, // يجب أن يطابق الاسم في القالب
            'otp_code': otpCode,       // يجب أن يطابق الاسم في القالب
          },
        }),
      );

      if (response.statusCode == 200) {
        print("Success: Email Sent!");
        return true;
      } else {
        print("Failed: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}