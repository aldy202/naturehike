import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
      .size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 112, 255, 167),
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                image: AssetImage("assets/images/gelombang.png"),
                
              )
            ),
          ),
          SafeArea(
            child: Column(
            children: <Widget>[
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 87, 255, 162),
                  shape: BoxShape.circle,
                ),
              )
            ]),
          )

          
        ]),
    );
  }
}
