import 'package:flutter/material.dart';

import 'package:servi_go_app/features/home/presentation/views/widgets/custom_bottom_nav_bar.dart';
import 'package:servi_go_app/features/home/presentation/views/widgets/home_body.dart';

import 'package:servi_go_app/features/messaging/presentation/views/messages_screen.dart';
import 'package:servi_go_app/features/profile/presentation/views/screens/profile_labourer_view.dart';
import 'package:servi_go_app/features/settings/presentation/views/settings_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomeBody(),
    ProfileLabourerView(),
    MessagesScreen(),
    SettingsView(),
  ];
  @override
  Widget build(BuildContext context) {
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
      body: IndexedStack(index: _selectedIndex, children: _pages),
    );
  }
}
