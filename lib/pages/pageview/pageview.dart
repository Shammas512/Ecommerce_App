import 'package:flutter/material.dart';

class Pageview extends StatefulWidget {
  const Pageview({super.key});

  @override
  State<Pageview> createState() => _PageviewState();
}

class _PageviewState extends State<Pageview> {
  int pageindex = 0;
  List pageimages = ["assets/images/acha.jpg", "assets/images/ui.png"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: pageimages.length,
          onPageChanged: (index) {
            setState(() {
              pageindex = index;
            });
          },
          itemBuilder: (context, index) {
            return Container(
              height: 400,
              width: 400,
               decoration: BoxDecoration(
  image: DecorationImage(
    image: AssetImage(pageimages[index]),
    fit: BoxFit.cover, // Adjust this for how you want the image to fit
  ),
),

         
                 
              
            );
          }),

          
    );
  }
}
