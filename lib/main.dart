// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:astro_photo_environment/capturing/session_details_page.dart';
import 'package:astro_photo_environment/pages/capturing/capturing_settings_page.dart';
import 'package:astro_photo_environment/pages/capturing/sessions_page.dart';
import 'package:astro_photo_environment/settings/connection_settings_page.dart';
import 'package:astro_photo_environment/settings/equipment_settings_page.dart';
import 'package:astro_photo_environment/settings/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'service_locator.dart';
import 'package:astro_photo_environment/pages/home/home_page.dart';

void main() {
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AstroPhotoEnvironment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/settings': (context) => SettingsPage(),
        '/settings/connection': (context) => ConnectionSettingsPage(),
        '/capturing/settings': (context) => CapturingSettingsPage(),
        '/settings/equipment': (context) => EquipmentSettingsPage(),
        '/sessions/detail': (context) => SessionDetailsPage()
      },
    );
  }
}
