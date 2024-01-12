import 'package:flutter/material.dart';
import 'package:laundry_app/presentation/settings/settings_page.dart';

class Routes {
  static const String settings = '/settings';

  Map<String, WidgetBuilder> getRoutes = {
    settings: (_) => const SettingPage(),
  };
}
