import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/theme/theme_bloc.dart';
import 'package:servi_go_app/core/utils/assets.dart';

class LangagueThemeWidget extends StatelessWidget {
  const LangagueThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(Assets.langagueIcon),
        Gap(8),
        BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            final isDark = state.themeMode == ThemeMode.dark;
            return IconButton(
              onPressed: () {
                context.read<ThemeBloc>().add(const ThemeToggled());
              },
              icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
              tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
            );
          },
        ),
      ],
    );
  }
}
