import 'package:flutter/widgets.dart';
import 'package:the_resident_zombie/core/global_components/logo_component.dart';
import 'package:the_resident_zombie/core/utils/style.dart' as style;

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({ Key? key }) : super(key: key);

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
                "Success!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: style.lighterGrey,
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}