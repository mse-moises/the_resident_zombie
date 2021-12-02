import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_resident_zombie/features/main/presentation/pages/home_page/pages/home_page.dart';
import 'package:the_resident_zombie/features/main/presentation/pages/splash_page/pages/Splash_page.dart';
import 'package:the_resident_zombie/features/user/presentation/contact_list/pages/contact_list_page.dart';
import 'package:the_resident_zombie/features/user/presentation/contact_list/pages/qr_code_page.dart';
import 'package:the_resident_zombie/features/user/presentation/create_user/page/crate_user_page.dart';
import 'package:the_resident_zombie/core/utils/style.dart' as style;
import 'package:the_resident_zombie/features/user/presentation/trade/pages/trade_item_page.dart';

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
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: style.lightGrey,
        ),
      ),
      routes: {
        SplashPage.route: (_) => SplashPage(),
        CreateUserPage.route: (_) => CreateUserPage(),
        HomePage.route: (_) => HomePage(),
        ContactList.route: (_) => ContactList(),
        QRCodeReaderPage.route: (_) => QRCodeReaderPage(),

         TradeItemsPage.route: (context) =>
              TradeItemsPage(ModalRoute.of(context)!.settings.arguments),
      },
    );
  }
}
