import 'package:flutter/material.dart';

abstract class PageRouteConfig {
  String get path;
  String get name;
  Widget get page;
}
