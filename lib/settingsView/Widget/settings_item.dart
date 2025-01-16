import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Provider/app_provider.dart';
import 'package:untitled/settingsView/Widget/language_bottom_sheet_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef SettingOptionClicked = void Function();

class SettingsItems extends StatelessWidget {
  final String settingOptionTitle, selectedOption;
  final SettingOptionClicked onOptionTaped;

  const SettingsItems({
    super.key,
    required this.settingOptionTitle,
    required this.selectedOption,
    required this.onOptionTaped,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;
    var appProvider = Provider.of<AppProvider>(context);
    var local = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          local.language,
          semanticsLabel: local.language,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: theme.primaryColor,
          ),
        ),
        GestureDetector(
          onTap: () {
            showLanguageBottomSheet(context);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            height: 50,
            width: mediaQuery.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.green,
                width: 1.2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(selectedOption),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void showLanguageBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const LanguageBottomSheetWidget(),
    );
  }
}
