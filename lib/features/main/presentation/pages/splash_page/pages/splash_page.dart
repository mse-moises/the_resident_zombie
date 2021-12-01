// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_resident_zombie/core/global_components/logo_component.dart';
import 'package:the_resident_zombie/core/utils/style.dart' as style;
import 'package:the_resident_zombie/features/main/presentation/pages/home_page/pages/home_page.dart';
import 'dart:math' as math;

import 'package:the_resident_zombie/features/main/presentation/pages/splash_page/bloc/splash_page_bloc.dart';
import 'package:the_resident_zombie/features/user/presentation/create_user/page/crate_user_page.dart';

import '../../../../../../injection_container.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  static const String route = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final double boxSize = 200;

  final SplashPageBloc bloc = sl.get<SplashPageBloc>();

  void _changePage(String page) async {
    await new Future.delayed(new Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, page);
  }

  Widget _getBody() {
    return BlocProvider.value(
      value: bloc,
      child: BlocListener<SplashPageBloc, SplashPageState>(
        listener: (context, state) {
          if (state is SplashPageUserFound) {
            _changePage(HomePage.route);
          } else if (state is SplashPageUserNotFound) {
            _changePage(CreateUserPage.route);
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            LogoComponent(),
            Center(
              child: Text(
                "TRZ",
                style: TextStyle(
                  fontSize: 60,
                  color: Colors.grey[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
    );
  }

  @override
  void initState() {
    super.initState();

    bloc.add(SearchLocalUserEvent());
  }
}
