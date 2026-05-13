import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/assets.dart';

class LangagueThemeWidget extends StatelessWidget {
  const LangagueThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(Assets.langagueIcon),
        Gap(8),
        SvgPicture.asset(Assets.themeIcon),
      ],
    );
  }
}
