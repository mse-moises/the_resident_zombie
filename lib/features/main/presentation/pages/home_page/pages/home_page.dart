import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_resident_zombie/core/global_components/logo_component.dart';
import 'package:the_resident_zombie/features/main/presentation/pages/home_page/bloc/home_page_bloc.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';
import 'package:the_resident_zombie/features/user/presentation/contact_list/pages/contact_list_page.dart';
import 'package:the_resident_zombie/injection_container.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:the_resident_zombie/core/utils/style.dart' as style;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  static const route = '/home-page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageBloc bloc = sl.get<HomePageBloc>();

  void _showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _getMenuInfected() {
    return Stack(
      alignment: Alignment.center,
      children: [
        LogoComponent(
          boxSize: 250,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "You got infected!",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: style.lighterRed,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Go get a cup of whater.",
                style: TextStyle(
                  fontSize: 16,
                  color: style.lighterGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getMenuBody({UserEntity? user}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Builder(
              builder: (BuildContext context) {
                if (user == null) return Text("User not found");
                return Column(
                  children: [
                    Text("Your QRCode", style: Theme.of(context).textTheme.headline5),
                    QrImage(
                      data: user.id,
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  ],
                );
              },
            ),

            SizedBox(height: 50),
            Center(
              child: Container(
                height: 50,
                width: double.infinity,
                child: TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, ContactList.route),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        side: BorderSide(color: style.darkGrey!, width: 2),
                      ),
                    ),
                  ),
                  child: Text("Contact List",
                      style: Theme.of(context).textTheme.headline6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBody() {
    return Builder(builder: (context) {
      return BlocConsumer<HomePageBloc, HomePageState>(
        listener: (BuildContext context, state) {
          print(state);
          if (state is HomeFailUpdateLocation)
            _showSnackBar(context, "Fail to update your location");
          if (state is HomeSuccessUpdateLocation)
            _showSnackBar(context, "Location updated");
        },
        builder: (BuildContext context, state) {
          if (state is HomePageInfected) return _getMenuInfected();
          return _getMenuBody();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider.value(
          value: bloc,
          child: _getBody(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    bloc.add(HomeUpdateLocationEvent());
  }
}
