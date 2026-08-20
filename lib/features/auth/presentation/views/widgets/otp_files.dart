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
  
    String currentOtp = controllers.map((e) => e.text.trim()).join();
    widget.onCompleted(currentOtp);
  }

  void onChanged(String value, int index) {
    if (value.isNotEmpty) {
    
      if (value.length > 1) {
        controllers[index].text = value.substring(value.length - 1);
        controllers[index].selection = TextSelection.fromPosition(
          TextPosition(offset: controllers[index].text.length),
        );
      }

     
      if (index < length - 1) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      }
    } else {
     
      if (index > 0) {
        FocusScope.of(context).requestFocus(focusNodes[index - 1]);
      }
    }

   
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
           
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold,color: Theme.of(context).textTheme.bodyLarge?.color,),
            decoration: InputDecoration(
              counterText: "",
              filled: true,
             fillColor: Theme.of(context).cardColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
               borderSide: BorderSide(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey.shade700
          : Colors.grey.shade400,
    ),
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
