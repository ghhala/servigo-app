import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/custom_check_box.dart';

class TermsAndConditionsWidget extends StatefulWidget {
  const TermsAndConditionsWidget({super.key, required this.onChanged});

  final ValueChanged<bool> onChanged;
  @override
  State<TermsAndConditionsWidget> createState() =>
      _TermsAndConditionsWidgetState();
}

class _TermsAndConditionsWidgetState extends State<TermsAndConditionsWidget> {
  bool isTermsAccepted = false;
  @override
  Widget build(BuildContext context) {
    return Row(
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
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'By creating an account, you agree to our ',
                  style: TextStyles.font16PrimaryColorW400,
                ),
                TextSpan(
                  text: ' terms and conditions',
                  style: TextStyles.font18BlackW500,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
