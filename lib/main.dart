import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Classes/Classes.dart';
import 'package:untitled/Home/HomeView.dart';

import 'package:untitled/Layout/layout.dart';
import 'package:untitled/Login_screen.dart';
import 'package:untitled/Profile/Profile.dart';
import 'package:untitled/Provider/app_provider.dart';
import 'package:untitled/Register/register.dart';
import 'package:untitled/Subscriptions/Subscriptions.dart';

import 'package:untitled/settingsView/settings_view.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'firebase_options.dart';

void main()
  async {

    WidgetsFlutterBinding.ensureInitialized();


    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<AppProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      themeMode: ThemeMode.light,
     
      
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(appProvider.currentLocal),
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterView.routeName: (context) => RegisterView(),
        Layout.routeName: (context) => const Layout(),
        HomeView.routeName: (context) => HomeView(),
        Classes.routeName: (context) => const Classes(),
        Subscriptions.routeName: (context) => const Subscriptions(),
        Profile.routeName: (context) => const Profile(),
        SettingsView.routeName: (context) => const SettingsView(),
      },
    );
  }
}
