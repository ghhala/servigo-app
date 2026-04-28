import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpFields extends StatefulWidget {
  const OtpFields({super.key});

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

  void onChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < length - 1) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      }
    } else {
      if (index > 0) {
        FocusScope.of(context).requestFocus(focusNodes[index - 1]);
      }
    }
  }

  String getOtp() {
    return controllers.map((e) => e.text).join();
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
            maxLength: 1,
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
