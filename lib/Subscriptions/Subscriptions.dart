import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Subscriptions extends StatelessWidget {
  const Subscriptions({super.key});
  static const String routeName = "Subscriptions";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subscriptions"),
      ),
    );
  }
}
