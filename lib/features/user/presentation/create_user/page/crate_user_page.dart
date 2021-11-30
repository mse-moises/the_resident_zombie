import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:the_resident_zombie/features/user/presentation/create_user/bloc/bloc/create_user_bloc.dart';
import 'package:the_resident_zombie/injection_container.dart';
import 'package:the_resident_zombie/core/utils/style.dart' as style;

class CreateUserPage extends StatelessWidget {
  CreateUserPage({Key? key}) : super(key: key);
  static const String route = "/register";

  final CreateUserBloc bloc = sl.get<CreateUserBloc>();

  void _showFailSnackBar(BuildContext context) {
    final snackBar = SnackBar(
        content: Text('It was not possible to perform your registration!'));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _getLoadingBody() {
    return Center(
      child: SpinKitRotatingCircle(
        color: style.darkerGrey,
        size: 50.0,
      ),
    );
  }

  Widget _getFormCreateUserBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("Sign-in", style: TextStyle(fontSize: 20)),
          Divider(),
        ],
      ),
    );
  }

  Widget _getCriticalFail() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("Something went wrong!"),
          Text("Try again later!"),
        ],
      ),
    );
  }

  Widget _getBody() {
    return Builder(builder: (context) {
      return BlocConsumer<CreateUserBloc, CreateUserState>(
        listener: (context, state) {
          if (state is CreateUserFailState) _showFailSnackBar(context);
          if (state is CreateUserSuccessState) print("Success!");
        },
        builder: (context, state) {
          if (state is CreateUserLoadingState) return _getLoadingBody();
          if (state is CreateUserEditState) return _getFormCreateUserBody();

          return _getCriticalFail();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: bloc,
        child: SafeArea(
          child: _getBody(),
        ),
      ),
    );
  }
}
