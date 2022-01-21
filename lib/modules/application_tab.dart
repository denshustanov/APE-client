import 'package:flutter/material.dart';

class ApplicationTab{
  final String name;
  final MaterialColor color;
  final IconData icon;

  ApplicationTab(this.name, this.color, this.icon);
}

enum TabItem {HOME, CAPTURING, GUIDING}