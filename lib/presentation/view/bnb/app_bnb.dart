import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handy_home_app/bussiness%20logic/authCubit/auth_cubit.dart';
import 'package:handy_home_app/bussiness%20logic/bnbManager/bnb_manager_cubit.dart';
import 'package:handy_home_app/bussiness%20logic/homeCubit/home_cubit.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';
import 'package:handy_home_app/presentation/view/bookedServices/booked_services_screen.dart';
import 'package:handy_home_app/presentation/view/notification/notification_screen.dart';
import 'package:handy_home_app/presentation/view/profile/profile_screen.dart';
import 'package:handy_home_app/presentation/view/search/search_screen.dart';

import '../../resources/assets_manager.dart';
import '../home/home_screen.dart';

class AppBNB extends StatelessWidget {
  const AppBNB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BnbManagerCubit, BnbManagerState>(
        builder: (context, state) {
      return Scaffold(
        body: tabs[state.selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (value) {
            context.read<BnbManagerCubit>().onSelectItem(value);
          },
          items: iconItemsPath
              .map((e) => BottomNavigationBarItem(
                  label: '',
                  icon: SvgPicture.asset(
                    e,
                    color: state.selectedIndex == iconItemsPath.indexOf(e)
                        ? ColorManager.primaryMainEnableColor
                        : null,
                  )))
              .toList(),
        ),
      );
    });
  }
}

List<String> iconItemsPath = [
  IconPath.homeIcon,
  IconPath.notificationIcon,
  IconPath.bookingIcon,
  IconPath.searchIcon,
  IconPath.profileIcon
];

List<Widget> tabs = [
  MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => LatestServiceCubit(),
      ),
      BlocProvider(
        create: (context) => HomeCubit(),
      ),
    ],
    child: const HomeScreen(),
  ),
  const NotificationScreen(),
  const BookedServiceScreen(),
  const SearchScreen(),
  MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthCubit(),
      )
    ],
    child: const ProfileScreen(),
  )
];
