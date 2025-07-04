import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class PageRouteConfig {
  String get path;
  String get name;
  Widget buildPage(BuildContext context, GoRouterState state);
}
