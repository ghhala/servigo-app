import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/styles.dart';

class CustomSubCategoryPicker extends StatefulWidget {
  final List<String> items; 
  final String initialValue; 
  final Function(String) onSelected; 

  const CustomSubCategoryPicker({
    super.key,
    required this.items,
    required this.initialValue,
    required this.onSelected,
  });

  @override
  State<CustomSubCategoryPicker> createState() =>
      _CustomSubCategoryPickerState();
}

class _CustomSubCategoryPickerState extends State<CustomSubCategoryPicker> {
  late String _currentSelection;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _currentSelection = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor =
        isDark ? theme.cardColor : Colors.grey.shade300;
    final borderColor = theme.dividerColor;
    final textColor = theme.colorScheme.onSurface;
    final controlColor = theme.colorScheme.primary;
    final controlIconColor = theme.colorScheme.onPrimary;
    final labelStyle = TextStyles.onCard(
      context,
      TextStyles.font14PrimaryColorW700,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 100.h,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: Row(
            children: [
             
              Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  padding: EdgeInsets.zero,
                  itemCount: widget.items.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    color: borderColor,
                    thickness: 1,
                  ),
                  itemBuilder: (context, index) {
                    final item = widget.items[index];
                    return InkWell(
                      onTap: () {
                        setState(() => _currentSelection = item);
                        widget.onSelected(item);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 7,
                        ),
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Container(
                width: 16.w,
                color: controlColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => _scrollController.animateTo(
                        _scrollController.offset - 40,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.ease,
                      ),
                      child: Icon(
                        Icons.arrow_drop_up,
                        color: controlIconColor,
                        size: 18,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    GestureDetector(
                      onTap: () => _scrollController.animateTo(
                        _scrollController.offset + 40,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.ease,
                      ),
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: controlIconColor,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Gap(11),

        Text.rich(
          TextSpan(
            style: labelStyle,
            children: [
              const TextSpan(text: "Sub category : "),
              TextSpan(
                text: _currentSelection,
                style: labelStyle.copyWith(fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
