import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servi_go_app/core/utils/styles.dart';

class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled({
    super.key,
    required this.hintText,
    
    this.prefixIcon,
    this.textInputType,
    this.validator,
    this.controller,
    this.width,
    this.height,
    VoidCallback? onTap_,

    /// 🔽 Dropdown props
    this.isDropdown = false,
    this.items,
    this.value,
    this.onChanged,
    this.readOnly,
    this.borderRadius,
    this.borderSide,
    this.fillColor,
    this.hintStyle,
    this.inputFormatters,
  });

  final String hintText;
  final Widget? prefixIcon;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final BorderRadius? borderRadius;
  final BorderSide? borderSide;
  final bool? readOnly;
  final double? width;
  final double? height;
  final Color? fillColor;
  final TextStyle? hintStyle;
  final List<TextInputFormatter>? inputFormatters;

  /// 🔽 Dropdown
  final bool isDropdown;
  final List<String>? items;
  final String? value;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final TextStyle resolvedHintStyle = TextStyles.onCard(
      context,
      hintStyle ?? TextStyles.font16PrimaryColorW400,
    );
    return SizedBox(
      width: width ?? MediaQuery.sizeOf(context).width * 0.88,
      height: height ?? 42.h,

      ///Dropdown
      child: isDropdown
          ? DropdownButtonFormField<String>(
              value: value,
              validator: validator,
              isExpanded: true,

              items: items?.map((item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),

              onChanged: onChanged,

              decoration: InputDecoration(
                isDense: true,
                prefixIcon: prefixIcon,
                hintText: hintText,
                hintStyle: resolvedHintStyle,

                filled: true,
                fillColor: Theme.of(context).cardColor,
                border: buildBorder(context),
                enabledBorder: buildBorder(context),
                focusedBorder: buildBorder(context),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(width: 1, color: Colors.red),
                ),
              ),

              icon: const Icon(Icons.keyboard_arrow_down),
            )
          //TextField
          : TextFormField(
              readOnly: readOnly ?? false,
              validator: validator,
              controller: controller,
              keyboardType: textInputType,
              inputFormatters: inputFormatters,

              decoration: InputDecoration(
                isDense: true,
                prefixIcon: prefixIcon,
                hintText: hintText,
                hintStyle: resolvedHintStyle,

                filled: true,
                fillColor: fillColor ?? Theme.of(context).cardColor,
                border: buildBorder(context),
                enabledBorder: buildBorder(context),
                focusedBorder: buildBorder(context),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),

                  borderSide: const BorderSide(width: 1, color: Colors.red),
                ),
              ),
            ),
    );
  }

  OutlineInputBorder buildBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      borderSide: borderSide ??
          BorderSide(width: 1, color: Theme.of(context).dividerColor),
    );
  }
}
