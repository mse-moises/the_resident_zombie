import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_resident_zombie/features/main/presentation/pages/home_page/bloc/home_page_bloc.dart';
import 'package:the_resident_zombie/features/user/presentation/contact_list/pages/contact_list_page.dart';
import 'package:the_resident_zombie/injection_container.dart';

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

  Widget _getMenuBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, ContactList.route),
            child: Text("Contact List"),
          ),
        ],
      ),
    );
  }

  Widget _getBody() {
    return Builder(builder: (context) {
      return BlocListener<HomePageBloc, HomePageState>(
        listener: (BuildContext context, state) {
          print(state);
          if (state is HomeFailUpdateLocation)
            _showSnackBar(context, "Fail to update your location");
          if (state is HomeSuccessUpdateLocation)
            _showSnackBar(context, "Location updated");
        },
        child: _getMenuBody(),
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
