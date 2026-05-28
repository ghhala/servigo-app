import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomTimePicker extends StatefulWidget {
  final Function(int startHour, String startPeriod, int endHour, String endPeriod) onTimeChanged;

  const CustomTimePicker({super.key, required this.onTimeChanged});

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  int _startHour = 6;
  String _startPeriod = "AM";
  int _endHour = 10;
  String _endPeriod = "PM";

  late final FixedExtentScrollController _startHourController;
  late final FixedExtentScrollController _endHourController;

  final Color _primaryDarkColor = const Color(0xFF0D3B51);
  final Color _listBackgroundColor = const Color(0xFFF3F2F2);

  @override
  void initState() {
    super.initState();
    _startHourController = FixedExtentScrollController(initialItem: _startHour - 1);
    _endHourController = FixedExtentScrollController(initialItem: _endHour - 1);
  }

  @override
  void dispose() {
    _startHourController.dispose();
    _endHourController.dispose();
    super.dispose();
  }

  void _notify() {
    widget.onTimeChanged(_startHour, _startPeriod, _endHour, _endPeriod);
  }

  String _formatTime(int hour, String period) {
    return '${hour.toString().padLeft(2, '0')} : 00 $period';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── العنوان يتحدث تلقائياً ──
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                const TextSpan(text: 'Set working hours : '),
                TextSpan(
                  text: '${_formatTime(_startHour, _startPeriod)}  -  ${_formatTime(_endHour, _endPeriod)}',
                  style: TextStyle(color: _primaryDarkColor),
                ),
              ],
            ),
          ),
        ),

        Gap(15.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ── وقت البداية ──
            Column(
              children: [
                Text(
                  'From',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: _primaryDarkColor.withOpacity(0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(4.h),
                Row(
                  children: [
                    _buildWheelPicker(
                      scrollController: _startHourController,
                      itemCount: 12,
                      labelBuilder: (index) => (index + 1).toString().padLeft(2, '0'),
                      onChanged: (index) {
                        setState(() => _startHour = index + 1);
                        _notify();
                      },
                    ),
                    Gap(8.w),
                    _buildAmPmToggle(
                      selected: _startPeriod,
                      onChanged: (val) {
                        setState(() => _startPeriod = val);
                        _notify();
                      },
                    ),
                  ],
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                '—',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: _primaryDarkColor,
                ),
              ),
            ),

            // ── وقت النهاية ──
            Column(
              children: [
                Text(
                  'To',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: _primaryDarkColor.withOpacity(0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(4.h),
                Row(
                  children: [
                    _buildWheelPicker(
                      scrollController: _endHourController,
                      itemCount: 12,
                      labelBuilder: (index) => (index + 1).toString().padLeft(2, '0'),
                      onChanged: (index) {
                        setState(() => _endHour = index + 1);
                        _notify();
                      },
                    ),
                    Gap(8.w),
                    _buildAmPmToggle(
                      selected: _endPeriod,
                      onChanged: (val) {
                        setState(() => _endPeriod = val);
                        _notify();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // ── عجلة التمرير ──
  Widget _buildWheelPicker({
    required FixedExtentScrollController scrollController,
    required int itemCount,
    required String Function(int) labelBuilder,
    required ValueChanged<int> onChanged,
  }) {
    return Container(
      height: 65.h,
      width: 50.w,
      decoration: BoxDecoration(
        color: _primaryDarkColor,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ── خط التحديد ──
          Positioned(
            top: 65.h / 2 - 11.h,
            left: 0,
            right: 0,
            child: Container(
              height: 22.h,
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: Colors.white.withOpacity(0.25),
                    width: 1,
                  ),
                ),
              ),
            ),
          ),

          // ── العجلة ──
          ListWheelScrollView.useDelegate(
            controller: scrollController,
            itemExtent: 22.h,
            perspective: 0.004,
            diameterRatio: 1.4,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: onChanged,
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: itemCount,
              builder: (context, index) {
                final isSelected =
                    scrollController.hasClients &&
                    scrollController.selectedItem == index;
                return Center(
                  child: Text(
                    labelBuilder(index),
                    style: TextStyle(
                      fontSize: isSelected ? 17.sp : 13.sp,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected
                          ? Colors.white
                          : Colors.white.withOpacity(0.35),
                    ),
                  ),
                );
              },
            ),
          ),

          // ── سهم للأعلى ──
          Positioned(
            top: 0,
            child: GestureDetector(
              onTap: () {
                final current = scrollController.selectedItem;
                if (current > 0) {
                  scrollController.animateToItem(
                    current - 1,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease,
                  );
                }
              },
              child: Icon(Icons.arrow_drop_up, color: Colors.white, size: 18.sp),
            ),
          ),

          // ── سهم للأسفل ──
          Positioned(
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                final current = scrollController.selectedItem;
                if (current < itemCount - 1) {
                  scrollController.animateToItem(
                    current + 1,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease,
                  );
                }
              },
              child: Icon(Icons.arrow_drop_down, color: Colors.white, size: 18.sp),
            ),
          ),
        ],
      ),
    );
  }

  // ── زرا AM / PM ──
  Widget _buildAmPmToggle({
    required String selected,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      children: ['AM', 'PM'].map((period) {
        final isSelected = selected == period;
        return GestureDetector(
          onTap: () => onChanged(period),
          child: Container(
            width: 55.w,
            height: 30.h,
            margin: EdgeInsets.only(bottom: period == 'AM' ? 5.h : 0),
            decoration: BoxDecoration(
              color: isSelected ? _primaryDarkColor : _listBackgroundColor,
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(
                color: _primaryDarkColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              period,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : _primaryDarkColor,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}