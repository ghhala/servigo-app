import 'package:flutter/material.dart';

import 'package:servi_go_app/features/home/presentation/views/widgets/custom_bottom_nav_bar.dart';
import 'package:servi_go_app/features/home/presentation/views/widgets/home_body.dart';

import 'package:servi_go_app/features/messaging/presentation/views/messages_screen.dart';
import 'package:servi_go_app/features/profile/presentation/views/screens/profile_labourer_view.dart';
import 'package:servi_go_app/features/settings/presentation/views/settings_view.dart';
import 'package:servi_go_app/features/user_profile/presentation/views/user_profile_view.dart';

class HomeView extends StatefulWidget {
  final String userType;
  const HomeView({super.key, required this.userType});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  
  List<Widget> get _pages {
    if (widget.userType == 'labourer') {
      return [
        HomeBody(),
        ProfileLabourerView(),
        MessagesScreen(),
        SettingsView(),
      ];
    } else {
      return [HomeBody(), UserProfileView(), MessagesScreen(), SettingsView()];
    }
  }

  @override

  Widget build(BuildContext context) {
    print("Current User Type in HomeView is: ${widget.userType}");
  return Scaffold(
    extendBody: true,
    bottomNavigationBar: CustomBottomNavBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
    ),
  
    body: _pages[_selectedIndex], 
  );
}
}
