import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_resident_zombie/features/main/presentation/pages/splash_page/pages/Splash_page.dart';
import 'package:the_resident_zombie/features/user/presentation/crate_user_page.dart';

import 'package:the_resident_zombie/initial_configs.dart';

import 'injection_container.dart' as di;

void main() async {
  await initialConfigs();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Resident Zombie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.nunitoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routes: {
        SplashPage.route: (_) => SplashPage(),
        CreateUserPage.route: (_) => CreateUserPage(),
      },
    );
  }
}
