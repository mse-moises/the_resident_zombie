// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_resident_zombie/core/utils/style.dart' as style;
import 'dart:math' as math;

import 'package:the_resident_zombie/features/main/presentation/pages/splash_page/bloc/splash_page_bloc.dart';
import 'package:the_resident_zombie/features/user/presentation/crate_user_page.dart';

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

  void changePage(String page) async {
    await new Future.delayed(new Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, page);
  }

  Widget _getFirstBox() {
    return Center(
      child: Container(
        height: boxSize,
        width: boxSize,
        decoration: BoxDecoration(
          color: style.darkerGrey,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 10,
              blurRadius: 10,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }

  Widget _getSecondBox() {
    return Transform.rotate(
      angle: -math.pi / 2.5,
      child: Center(
        child: Container(
          height: boxSize,
          width: boxSize,
          decoration: BoxDecoration(
            color: style.darkGrey,
          ),
        ),
      ),
    );
  }

  Widget _getBody() {
    return BlocProvider.value(
      value: bloc,
      child: BlocListener<SplashPageBloc, SplashPageState>(
        listener: (context, state) {
          if (state is SplashPageUserFound) {
            print("Found");
          } else if (state is SplashPageUserNotFound) {
            changePage(CreateUserPage.route);
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _getFirstBox(),
            _getSecondBox(),
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
