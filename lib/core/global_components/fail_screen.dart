import 'package:flutter/widgets.dart';
import 'package:the_resident_zombie/core/global_components/logo_component.dart';
import 'package:the_resident_zombie/core/utils/style.dart' as style;

class FailScreen extends StatelessWidget {
  const FailScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}