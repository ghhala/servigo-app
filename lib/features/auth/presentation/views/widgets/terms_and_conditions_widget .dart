import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:servi_go_app/core/localization/app_localizations.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/custom_check_box.dart';

class TermsAndConditionsWidget extends StatefulWidget {
  const TermsAndConditionsWidget({
    super.key,
    required this.onChanged,
    this.onTermsTap,
  });

  final ValueChanged<bool> onChanged;

  // 👇 جديد: تُستدعى فقط عند الضغط على نص "الشروط والأحكام"
  // (للانتقال لصفحة الشروط الكاملة)، منفصلة عن الـ checkbox
  final VoidCallback? onTermsTap;

  @override
  State<TermsAndConditionsWidget> createState() =>
      _TermsAndConditionsWidgetState();
}

class _TermsAndConditionsWidgetState extends State<TermsAndConditionsWidget> {
  bool isTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          CustomCheckBox(
            onChecked: (value) {
              isTermsAccepted = value;
              widget.onChanged(value);
              setState(() {});
            },
            isChecked: isTermsAccepted,
          ),
          const SizedBox(width: 16),
          Expanded(
            // 👇 الآن الضغط على النص فقط هو اللي بينقّل لصفحة الشروط،
            // مش هيتعارض مع الضغط على الـ checkbox
            child: GestureDetector(
              onTap: widget.onTermsTap,
              behavior: HitTestBehavior.translucent,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: AppLocalizations.of(context)!.byCreatingAccount,
                      style: TextStyles.font16PrimaryColorW400,
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!.termsAndConditions,
                      style: TextStyles.font18BlackW500,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}