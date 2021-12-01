import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:the_resident_zombie/core/global_components/logo_component.dart';
import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart';
import 'package:the_resident_zombie/features/user/presentation/create_user/bloc/bloc/create_user_bloc.dart';
import 'package:the_resident_zombie/features/user/presentation/create_user/components/gender_selector_widget.dart';
import 'package:the_resident_zombie/features/user/presentation/create_user/components/item_counter_widget.dart';
import 'package:the_resident_zombie/injection_container.dart';
import 'package:the_resident_zombie/core/utils/style.dart' as style;

class CreateUserPage extends StatefulWidget {
  CreateUserPage({Key? key}) : super(key: key);
  static const String route = "/register";

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final CreateUserBloc bloc = sl.get<CreateUserBloc>();

  final TextEditingController name = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController gender = TextEditingController();

  bool insertAGenderError = false;

  final _formKey = GlobalKey<FormState>();

  late List<int> itemsQuantity;

  void _submit() {
    if (gender.text == "") {
      setState(() {
        insertAGenderError = true;
      });
      return;
    }
    
    if (!_formKey.currentState!.validate()) return;

    bloc.add(CreateUserSubmitEvent(
        age: int.parse(age.text),
        gender: gender.text.toUpperCase(),
        items: itemsQuantity,
        name: name.text));
  }

  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('It was not possible to perform your registration!'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //fail state
  void _setFailState() {
    _showSnackBar(context);
    _clearInputs();
  }

  void _clearInputs() {
    name.clear();
    age.clear();
    gender.clear();
  }

  //edit state
  void _setItemsQuantityStorage(int quantity) {
    itemsQuantity = [];
    for (int i = 0; i < quantity; i++) {
      itemsQuantity.add(0);
    }
  }

  void _increaseItemAtIndex(int index) {
    setState(() {
      itemsQuantity[index]++;
    });
  }

  void _decreaseItemAtIndex(int index) {
    if (itemsQuantity[index] <= 0) return;
    setState(() {
      itemsQuantity[index]--;
    });
  }

  // genders selection
  void selectMale() {
    setState(() {
      gender.text = "M";
    });
  }

  void selectFemale() {
    setState(() {
      gender.text = "F";
    });
  }

  //Widgets
  Widget _getLoadingBody() {
    return Center(
      child: SpinKitRotatingCircle(
        color: style.darkerGrey,
        size: 50.0,
      ),
    );
  }

  Widget _getFormCreateUserBody(List<ItemEntity> items) {
    final double spacingBetweenInputs = 10;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sign-in",
                style: Theme.of(context).textTheme.headline3,
              ),
              Divider(),
              SizedBox(height: spacingBetweenInputs),
              Text("Name", style: Theme.of(context).textTheme.headline6),
              SizedBox(height: spacingBetweenInputs / 2),
              TextFormField(
                  controller: name,
                  validator: (val) {
                    if (name.text == "") return "Insert your name";
                  }),
              SizedBox(height: spacingBetweenInputs),
              Text("Age", style: Theme.of(context).textTheme.headline6),
              SizedBox(height: spacingBetweenInputs / 2),
              TextFormField(
                controller: age,
                validator: (val) {
                  if (age.text == "") return "Insert your age";
                  if (int.parse(age.text) > 150 || int.parse(age.text) <= 0)
                    return "Insert a valid age";
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+')),
                ],
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: spacingBetweenInputs),
              Text("Gender", style: Theme.of(context).textTheme.headline6),
              SizedBox(height: spacingBetweenInputs),
              Center(
                child: Column(
                  children: [
                    GenderSelectior(
                      onSelectMale: selectMale,
                      onSelectFemale: selectFemale,
                      currentGender: gender.text,
                    ),
                    Builder(
                      builder: (BuildContext context) {
                        if (!insertAGenderError) return Container();

                        return Text("Insert your gender",
                            style: TextStyle(color: Colors.red));
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: spacingBetweenInputs),
              Text("Items", style: Theme.of(context).textTheme.headline6),
              SizedBox(height: spacingBetweenInputs),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: ItemCounter(
                      name: items[index].name,
                      add: () => _increaseItemAtIndex(index),
                      remove: () => _decreaseItemAtIndex(index),
                      count: itemsQuantity[index],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
              SizedBox(height: 30),
              Center(
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: TextButton(
                    onPressed: _submit,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          side: BorderSide(color: style.darkGrey!, width: 2),
                        ),
                      ),
                    ),
                    child: Text("Create account",
                        style: Theme.of(context).textTheme.headline6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getCriticalFail() {
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
                "Something went wrong!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: style.lighterGrey,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Try again later.",
                style: TextStyle(
                  fontSize: 19,
                  color: style.lightGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getBody() {
    return Builder(builder: (context) {
      return BlocConsumer<CreateUserBloc, CreateUserState>(
        listener: (context, state) {
          if (state is CreateUserEditState)
            _setItemsQuantityStorage(state.items.length);
          if (state is CreateUserFailState) _setFailState();
          if (state is CreateUserSuccessState) print("Success!");
        },
        builder: (context, state) {
          if (state is CreateUserLoadingState) return _getLoadingBody();
          if (state is CreateCriticalFailState) return _getCriticalFail();
          if (state is CreateUserEditState)
            return _getFormCreateUserBody(state.items);

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.add(CreateUserRequestItemsEvent());
  }
}
