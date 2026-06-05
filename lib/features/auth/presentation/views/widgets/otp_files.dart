import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpFields extends StatefulWidget {
  final Function(String) onCompleted;
  const OtpFields({super.key, required this.onCompleted});

  @override
  State<OtpFields> createState() => _OtpFieldsState();
}

class _OtpFieldsState extends State<OtpFields> {
  final int length = 6;
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(length, (_) => TextEditingController());
    focusNodes = List.generate(length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void updateOtpValue() {
    // هذه الدالة تجمع الأرقام الستة بدقة وتمررها فوراً وبشكل مستمر للشاشة الأساسية
    String currentOtp = controllers.map((e) => e.text.trim()).join();
    widget.onCompleted(currentOtp);
  }

  void onChanged(String value, int index) {
    if (value.isNotEmpty) {
      // إذا كُتب أكثر من حرف (بسبب التعديل الجديد)، نأخذ الحرف الأخير فقط
      if (value.length > 1) {
        controllers[index].text = value.substring(value.length - 1);
        controllers[index].selection = TextSelection.fromPosition(
          TextPosition(offset: controllers[index].text.length),
        );
      }

      // الانتقال للمربع التالي تلقائياً
      if (index < length - 1) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      }
    } else {
      // الرجوع للمربع السابق عند الحذف
      if (index > 0) {
        FocusScope.of(context).requestFocus(focusNodes[index - 1]);
      }
    }

    // تحديث القيمة فوراً
    updateOtpValue();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(length, (index) {
        return SizedBox(
          width: 55.w,
          height: 55.h,
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            // التعديل الذكي: أزلنا maxLength الصارم لمنع تعليق لوحة المفاتيح والـ Emulator
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              counterText: "",
              filled: true,
              fillColor: Colors.grey.shade300,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.purple, width: 2),
              ),
            ),
            onChanged: (value) => onChanged(value, index),
          ),
        );
      }),
    );
  }
}
