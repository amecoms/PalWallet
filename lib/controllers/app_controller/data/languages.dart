import 'dart:ui';

import '../../../gen/assets.gen.dart';

class Languages {
  Locale locale;
  String name, flag;

  Languages({required this.locale, required this.name, required this.flag});

  static List<Languages> get languages => [
    Languages(locale: const Locale('en'), name: 'English', flag: Assets.flags.en.keyName),
    Languages(locale: const Locale('bn'), name: 'Bangla', flag: Assets.flags.bd.keyName),
  ];
}