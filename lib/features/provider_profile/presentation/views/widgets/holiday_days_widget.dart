import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servi_go_app/core/localization/app_localizations.dart';
import 'package:servi_go_app/core/utils/styles.dart';

class HolidayDaysWidget extends StatefulWidget {
  final ValueChanged<List<String>>
  onDaysChanged; // 👈 نمرر التغييرات للواجهة الرئيسية لرفعها للسيرفر

  const HolidayDaysWidget({super.key, required this.onDaysChanged});

  @override
  _HolidayDaysWidgetState createState() => _HolidayDaysWidgetState();
}

class _HolidayDaysWidgetState extends State<HolidayDaysWidget> {
  final ScrollController _myController = ScrollController();

  // الأيام بالإنجليزية كما يتوقعها السيرفر تماماً
  final List<String> _days = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];

  final List<String> _selectedDays = [];

  String _getTranslatedDay(String day, bool isArabic) {
    if (!isArabic) return day;
    switch (day) {
      case "Sunday":
        return "الأحد";
      case "Monday":
        return "الإثنين";
      case "Tuesday":
        return "الثلاثاء";
      case "Wednesday":
        return "الأربعاء";
      case "Thursday":
        return "الخميس";
      case "Friday":
        return "الجمعة";
      case "Saturday":
        return "السبت";
      default:
        return day;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

    final backgroundColor = isDark ? theme.cardColor : Colors.grey.shade300;
    final borderColor = theme.dividerColor;
    final textStyle = TextStyles.onCard(
      context,
      TextStyles.font16PrimaryColorW600,
    ).copyWith(fontSize: 14.sp);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 130.h,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              scrollbarTheme: ScrollbarThemeData(
                thumbColor: MaterialStateProperty.all(
                  theme.colorScheme.primary,
                ),
                thickness: MaterialStateProperty.all(6),
                radius: const Radius.circular(4),
              ),
            ),
            child: Scrollbar(
              controller: _myController,
              thumbVisibility: true,
              child: ListView.separated(
                controller: _myController,
                itemCount: _days.length,
                separatorBuilder: (context, index) =>
                    Divider(height: 0.2.h, thickness: 1.1, color: borderColor),
                itemBuilder: (context, index) {
                  final day = _days[index];

                  final isSelected = _selectedDays.contains(day);

                  return ListTile(
                    dense: true,
                    visualDensity: const VisualDensity(vertical: -2),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 2,
                    ),
                    title: Text(
                      _getTranslatedDay(
                        day,
                        isArabic,
                      ), 
                      style: textStyle,
                    ),
                    trailing: Container(
                      width: 22.w,
                      height: 22.h,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.cardColor, 
                        border: Border.all(
                          color: isSelected
                              ? theme.colorScheme.primary
                              : borderColor,
                        ),
                        borderRadius: BorderRadius.circular(
                          4.r,
                        ), 
                      ),
                      child: isSelected
                          ? Icon(
                              Icons.check,
                              color: Colors
                                  .white, 
                              size: 16.sp,
                            )
                          : null,
                    ),
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedDays.remove(
                            day,
                          ); 
                        } else {
                          _selectedDays.add(
                            day,
                          ); 
                        }
                      });
                      widget.onDaysChanged(
                        _selectedDays,
                      ); 
                    },
                  );
                },
              ),
            ),
          ),
        ),

       
        if (_selectedDays.isNotEmpty) ...[
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 13.sp,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
                children: [
                  TextSpan(
                    text: l10n.selectedDays,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: _selectedDays
                        .map((day) => _getTranslatedDay(day, isArabic))
                        .join(' , '),
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
