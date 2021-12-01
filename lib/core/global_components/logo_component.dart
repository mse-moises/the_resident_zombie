import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:the_resident_zombie/core/utils/style.dart' ;

class LogoComponent extends StatelessWidget {
  const LogoComponent({Key? key, this.boxSize = 200}) : super(key: key);
  final double boxSize;

  Widget _getFirstBox() {
    var style;
    return Center(
      child: Container(
        height: boxSize,
        width: boxSize,
        decoration: BoxDecoration(
          color: darkerGrey,
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
            color: darkGrey,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _getFirstBox(),
        _getSecondBox(),
      ],
    );
  }
}
