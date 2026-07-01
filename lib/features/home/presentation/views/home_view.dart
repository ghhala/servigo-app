import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_go_app/core/network/api_service.dart';
import 'package:servi_go_app/core/network/dio_client.dart';

import 'package:servi_go_app/features/home/presentation/views/widgets/custom_bottom_nav_bar.dart';
import 'package:servi_go_app/features/home/presentation/views/widgets/home_body.dart';

import 'package:servi_go_app/features/messaging/presentation/views/messages_screen.dart';
import 'package:servi_go_app/features/provider_profile/data/data_sources/provider_profile_remote_data_source.dart';
import 'package:servi_go_app/features/provider_profile/data/repositories/provider_profile_repository.dart';
import 'package:servi_go_app/features/provider_profile/presentation/view_models/provider_profile/provider_profile_cubit.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/screens/profile_labourer_view.dart';
import 'package:servi_go_app/features/settings/data/data_sources/settings_remote_data_source.dart';
import 'package:servi_go_app/features/settings/data/repositories/settings_repository.dart';
import 'package:servi_go_app/features/settings/presentation/view_models/settings/settings_cubit.dart';
import 'package:servi_go_app/features/settings/presentation/views/settings_view.dart';
import 'package:servi_go_app/features/user_profile/data/data_sources/user_profile_remote_data_source.dart';
import 'package:servi_go_app/features/user_profile/data/repositories/user_profile_repository.dart';
import 'package:servi_go_app/features/user_profile/presentation/view_models/user_profile/user_profile_cubit.dart';
import 'package:servi_go_app/features/user_profile/presentation/views/user_profile_view.dart';

class HomeView extends StatefulWidget {
  final String userType;
  final dynamic userData;
  const HomeView({super.key, required this.userType, this.userData});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  List<Widget> get _pages {
    if (widget.userType == 'labourer') {
      return [
        HomeBody(userType: "labourer", userData: widget.userData),
        BlocProvider(
          create: (context) => ProviderProfileCubit(
            ProviderProfileRepository(
              ProviderProfileRemoteDataSource(
                ApiService(DioClient()),
              ),
            ),
          )..fetchProviderProfile(),
          child: const ProfileLabourerView(),
        ),
        MessagesScreen(),

       
        BlocProvider(
          create: (context) => SettingsCubit(
            repository: SettingsRepository(
              remoteDataSource: SettingsRemoteDataSource(
                apiService: ApiService(DioClient()),
              ),
            ),
          ),
          child: const SettingsView(isProvider: true),
        ),
      ];
    } else {
      return [
        HomeBody(userType: "user"),
        BlocProvider(
          create: (context) {
            final dioClient = DioClient();
            final apiService = ApiService(dioClient);
            final remoteDataSource = UserProfileRemoteDataSource(apiService);
            final repository = UserProfileRepository(remoteDataSource);

            return UserProfileCubit(repository)..fetchUserProfile();
          },
          child: const UserProfileView(),
        ),
        MessagesScreen(),

      
        BlocProvider(
          create: (context) => SettingsCubit(
            repository: SettingsRepository(
              remoteDataSource: SettingsRemoteDataSource(
                apiService: ApiService(DioClient()),
              ),
            ),
          ),
          child: const SettingsView(isProvider: false),
        ),
      ];
    }
  }

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
      body: _pages[_selectedIndex],
    );
  }
}