import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomTimePicker extends StatefulWidget {
  final Function(int hour, String period) onTimeChanged;

  const CustomTimePicker({super.key, required this.onTimeChanged});

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  int _selectedHour = 8;
  String _selectedPeriod = "AM";

  final ScrollController _hourController = ScrollController();
  final ScrollController _periodController = ScrollController();
  final Color _primaryDarkColor = const Color(0xFF0D3B51);
  final Color _listBackgroundColor = const Color(0xFFF3F2F2);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // النص العلوي كما في التصميم
        Gap(15.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // قائمة اختيار الساعات (1-12)
            _buildPicker(
              width: 50.w,
              controller: _hourController,
              itemCount: 12,
              itemBuilder: (index) => (index + 1).toString(),
              isSelected: (val) => _selectedHour == int.parse(val),
              onTap: (val) {
                setState(() => _selectedHour = int.parse(val));
                widget.onTimeChanged(_selectedHour, _selectedPeriod);
              },
            ),

            Gap(20.w),

            // قائمة اختيار AM / PM
            _buildPicker(
              width: 55.w,
              controller: _periodController,
              itemCount: 2,
              itemBuilder: (index) => index == 0 ? "AM" : "PM",
              isSelected: (val) => _selectedPeriod == val,
              onTap: (val) {
                setState(() => _selectedPeriod = val);
                widget.onTimeChanged(_selectedHour, _selectedPeriod);
              },
            ),
          ],
        ),
      ],
    );
  }

  // ميثود بناء البيكر بنفس منطق الكود الذي أرسلته
  Widget _buildPicker({
    required double width,
    required ScrollController controller,
    required int itemCount,
    required String Function(int) itemBuilder,
    required bool Function(String) isSelected,
    required Function(String) onTap,
  }) {
    return Container(
      height: 65.h,
      width: width,
      decoration: BoxDecoration(
        color: _listBackgroundColor,
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: ListView.separated(
              controller: controller,
              padding: EdgeInsets.zero,
              itemCount: itemCount,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: _primaryDarkColor.withOpacity(0.3),
                thickness: 0.5,
              ),
              itemBuilder: (context, index) {
                final String value = itemBuilder(index);
                bool active = isSelected(value);
                return InkWell(
                  onTap: () => onTap(value),
                  child: Container(
                    height: 20.h,
                    alignment: Alignment.center,
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: active ? FontWeight.w900 : FontWeight.bold,
                        color: _primaryDarkColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // عمود التحكم (الأسهم الجانبية)
          Container(
            width: 9.w,
            color: _primaryDarkColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => controller.animateTo(
                    controller.offset - 17.h,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease,
                  ),
                  child: const Icon(
                    Icons.arrow_drop_up,
                    color: Colors.white,
                    size: 13,
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.animateTo(
                    controller.offset + 19.h,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease,
                  ),
                  child: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                    size: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
