import 'package:flutter/material.dart';
import 'package:the_resident_zombie/core/utils/style.dart' as style;

class GenderSelectior extends StatelessWidget {
  GenderSelectior(
      {Key? key,
      required this.onSelectMale,
      required this.onSelectFemale,
      this.currentGender})
      : super(key: key);

  final Function() onSelectMale;
  final Function() onSelectFemale;

  String? currentGender;

  @override
  Widget build(BuildContext context) {
    final double width = 70;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                currentGender == 'M' ? style.lightGrey : style.lighterGrey),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                ),
                side: BorderSide(color: style.lightGrey!),
              ),
            ),
          ),
          onPressed: onSelectMale,
          child: Container(
            width: width,
            child: Center(child: Text("Male", style: Theme.of(context).textTheme.headline6)),
          ),
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                currentGender == 'F' ? style.lightGrey : style.lighterGrey),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
                side: BorderSide(color: style.lightGrey!),
              ),
            ),
          ),
          onPressed: onSelectFemale,
          child: Container(
            width: width,
            child: Center(child: Text("Female", style: Theme.of(context).textTheme.headline6)),
          ),
        ),
      ],
    );
  }
}
