import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:the_resident_zombie/core/global_components/fail_screen.dart';
import 'package:the_resident_zombie/core/global_components/loading_screen.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';
import 'package:the_resident_zombie/features/user/presentation/contact_list/bloc/contact_list_bloc.dart';
import 'package:the_resident_zombie/features/user/presentation/contact_list/components/contact_tile.dart';
import 'package:the_resident_zombie/features/user/presentation/contact_list/pages/qr_code_page.dart';
import 'package:the_resident_zombie/features/user/presentation/trade/pages/trade_item_page.dart';
import 'package:the_resident_zombie/injection_container.dart';

class ContactList extends StatefulWidget {
  ContactList({Key? key}) : super(key: key);
  static const String route = "/contact-list";

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final ContactListBloc bloc = sl.get<ContactListBloc>();

  void _flagUser(UserEntity user) {
    bloc.add(FlagAUserEvent(user.id));
  }

  void _showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _readQRCode() async {
    final result = await Navigator.pushNamed(context, QRCodeReaderPage.route);
    print(result);
    if (result != null && result is String) bloc.add(AddContactsEvent(result));
  }

  Widget _getBodyLoaded(List<UserEntity> users) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Contacts", style: Theme.of(context).textTheme.headline5),
            Divider(),
            SizedBox(height: 20),
            Builder(
              builder: (_) {
                if (users.isEmpty)
                  return Text("No contacts, try to get some friends!",
                      style: Theme.of(context).textTheme.headline6);

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ContactTile(
                      user: users[index],
                      functionOne: () => _flagUser(users[index]),
                      functionTwo: () {
                        Navigator.pushNamed(context,TradeItemsPage.route,arguments: ParamsTradeItemPage(users[index]));
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBody() {
    return Builder(builder: (context) {
      return BlocConsumer<ContactListBloc, ContactListState>(
        listener: (context, state) {
          if (state is ContactFlagSuccess)
            _showSnackBar(context, "You reported this user as an infected.");
          if (state is ContactFlagFail)
            _showSnackBar(context, "Failed to report.");
        },
        builder: (context, state) {
          if (state is ContactListLoaded) return _getBodyLoaded(state.users);
          if (state is ContactListLoadingState) return LoadingScreen();

          return FailScreen();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: _getBody(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _readQRCode(),
          child: Icon(Icons.person_add),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    bloc.add(RequestContactsEvent());
  }
}
