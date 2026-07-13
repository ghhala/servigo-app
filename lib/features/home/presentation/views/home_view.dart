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

  bool get _isProvider => widget.userType == 'labourer';

  
  late final SettingsCubit _settingsCubit;
  ProviderProfileCubit? _providerProfileCubit;
  UserProfileCubit? _userProfileCubit;

  @override
  void initState() {
    super.initState();

    if (_isProvider) {
      _providerProfileCubit = ProviderProfileCubit(
        ProviderProfileRepository(
          ProviderProfileRemoteDataSource(ApiService(DioClient())),
        ),
      )..fetchProviderProfile();
    } else {
      _userProfileCubit = UserProfileCubit(
        UserProfileRepository(
          UserProfileRemoteDataSource(ApiService(DioClient())),
        ),
      )..fetchUserProfile();
    }

    _settingsCubit = SettingsCubit(
      repository: SettingsRepository(
        remoteDataSource: SettingsRemoteDataSource(
          apiService: ApiService(DioClient()),
        ),
      ),
     
      onAvailabilityChanged: (value) =>
          _providerProfileCubit?.updateAvailabilityLocally(value),
      onOvernightChanged: (value) =>
          _providerProfileCubit?.updateOvernightLocally(value),
    );

   
   
  }

  @override
  void dispose() {
    _settingsCubit.close();
   
    _providerProfileCubit?.close();
    _userProfileCubit?.close();
    super.dispose();
  }

  List<Widget> _buildPages() {
    return [
      HomeBody(
        userType: _isProvider ? "labourer" : "user",
        userData: _isProvider ? widget.userData : null,
      ),
      _isProvider ? const ProfileLabourerView() : const UserProfileView(),
      const MessagesScreen(),
      SettingsView(isProvider: _isProvider),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _settingsCubit),
       
        if (_providerProfileCubit != null)
          BlocProvider.value(value: _providerProfileCubit!),
        if (_userProfileCubit != null)
          BlocProvider.value(value: _userProfileCubit!),
      ],
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _buildPages(),
        ),
      ),
    );
  }
}