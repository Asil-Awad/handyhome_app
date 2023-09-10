import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handy_home_app/app/locator.dart';
import 'package:handy_home_app/bussiness%20logic/bnbManager/bnb_manager_cubit.dart';

import 'app/app.dart';
import 'bussiness logic/searchCubit/search_cubit.dart';
import 'data/network/local/local_network.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().init();
  setUp();
  await ScreenUtil.ensureScreenSize();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        // Locale('en'),
        Locale('ar'),
      ],
      path: 'assets/l10n',
      fallbackLocale: const Locale('ar'),
      child: MultiBlocProvider(
          
        providers: [
          BlocProvider(
            create: (context) => BnbManagerCubit(),
          
          ),
            BlocProvider(
           create: (context) => SearchCubit(),
          
          )
        ],
        child: MyApp(),
      ),
    ),
  );
}


// login account
//naji.mohammed2001@gmail.com
//123**mmMM  
