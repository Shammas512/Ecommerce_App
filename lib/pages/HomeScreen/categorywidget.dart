import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Categorywidget extends StatelessWidget {
  const Categorywidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset("assets/images/green.jpg"),
          Image.asset("assets/images/shoo.jpg"),
          Image.asset("assets/images/gro.jpg"),
          Image.asset("assets/images/game.jpg"),
         SvgPicture.asset("assets/images/5.svg")
         
        ],
      ),
    );
  }
}
