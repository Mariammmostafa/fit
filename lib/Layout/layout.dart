import 'package:flutter/material.dart';
import 'package:untitled/Classes/Classes.dart';
import 'package:untitled/Home/HomeView.dart';
import 'package:untitled/Subscriptions/Subscriptions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:untitled/settingsView/settings_view.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  static const String routeName = "Layout";

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  int selectedindex = 0;

  void onitemtaped(int idex) {
    setState(() {
      selectedindex = idex;
    });
  }

  static List<Widget> listcustom = <Widget>[
    const HomeView(),
    const Classes(),
    // const Subscriptions(),
    // const Profile(),
    const SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    var local = AppLocalizations.of(context)!;

    return Scaffold(
      body: listcustom.elementAt(selectedindex),
      bottomNavigationBar: BottomNavigationBar(
        // new
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.home,
              color: Colors.green,
            ),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.class_rounded,
              color: Colors.green,
            ),
            label: AppLocalizations.of(context)!.classes,
          ),
          // BottomNavigationBarItem(
          //   icon: const Icon(
          //     Icons.subscriptions_outlined,
          //     color: Colors.green,
          //   ),
          //   label: AppLocalizations.of(context)!.subscriptions,
          // ),
          // BottomNavigationBarItem(
          //   icon: const Icon(
          //     Icons.person,
          //     color: Colors.green,
          //   ),
          //   label: AppLocalizations.of(context)!.profile,
          // ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.settings,
              color: Colors.green,
            ),
            label: AppLocalizations.of(context)!.settings,
          ),
        ],
        currentIndex: selectedindex,
        selectedItemColor: Colors.green,
        backgroundColor: Colors.white,
        onTap: onitemtaped,
      ),
    );
  }
}
