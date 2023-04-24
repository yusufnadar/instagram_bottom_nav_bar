import 'package:flutter/material.dart';

class InstagramTabItem {
  String label;
  Widget page;
  dynamic icon;
  String? initialRoute;
  Route<dynamic>? Function(RouteSettings)? settings;

  InstagramTabItem({
    required this.label,
    required this.page,
    required this.icon,
    this.initialRoute,
    this.settings,
  });
}
