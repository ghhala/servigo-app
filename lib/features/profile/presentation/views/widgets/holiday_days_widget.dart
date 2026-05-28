import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servi_go_app/core/utils/styles.dart';

class HolidayDaysWidget extends StatefulWidget {
  @override
  _HolidayDaysWidgetState createState() => _HolidayDaysWidgetState();
}

class _HolidayDaysWidgetState extends State<HolidayDaysWidget> {
  final ScrollController _myController = ScrollController();
  final List<String> _days = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];

  String? _selectedDay = "Sunday";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor =
        isDark ? theme.cardColor : Colors.grey.shade300;
    final borderColor = theme.dividerColor;
    final textStyle = TextStyles.onCard(
      context,
      TextStyles.font16PrimaryColorW600,
    ).copyWith(fontSize: 14.sp);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 100.h,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: Theme(
            // تخصيص شكل الـ Scrollbar ليناسب التصميم
            data: Theme.of(context).copyWith(
              scrollbarTheme: ScrollbarThemeData(
                thumbColor:
                    MaterialStateProperty.all(theme.colorScheme.primary),
                thickness: MaterialStateProperty.all(8),
                radius: const Radius.circular(2),
              ),
            ),
            child: Scrollbar(
              controller: _myController,
              thumbVisibility: true,
              child: ListView.separated(
                controller: _myController,
                itemCount: _days.length,
                separatorBuilder: (context, index) => Divider(
                  height: 0.3,
                  thickness: 1.1,
                  color: borderColor,
                  indent: 0,
                  endIndent: 0,
                ),
                itemBuilder: (context, index) {
                  final day = _days[index];
                  final isSelected = _selectedDay == day;

                  return ListTile(
                    dense: true,
                    visualDensity: const VisualDensity(vertical: -4),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                    title: Text(
                      day,
                      style: textStyle,
                    ),
                    trailing: Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        border: Border.all(color: borderColor),
                      ),
                      child: isSelected
                          ? Icon(
                              Icons.check,
                              color: theme.colorScheme.primary,
                              size: 20.sp,
                            )
                          : null,
                    ),
                    onTap: () {
                      setState(() {
                        _selectedDay = day;
                      });
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
