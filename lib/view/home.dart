import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.menu),
                  Image.asset(
                    "assets/images/hiking.png",
                    height: 100,
                    width: 100,
                  )
                ],
              ),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Hii",
                          style: TextStyle(
                              color: Color(0xfffD6D8D),
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text: "Aldy",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.handshake,
                    color: Colors.amber,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Welcome Admin",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.grey.withOpacity(0.5),
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Find Your Course...",
                      suffixIcon: Icon(Icons.search)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Choose Your Coures",
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 60,
                        height: 4,
                        color: Color(0xffFD6D8D),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 120,
                height: 160,
                decoration: BoxDecoration(
                  color: Color(0xffEF7A80),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50), 
                  )
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
