import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:naturehike/controller/auth_controller.dart';
import 'package:naturehike/model/user_model.dart';
import 'package:naturehike/view/login.dart';

class Register extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  final authCtr = AuthController();

  String? name;
  String? email;
  String? cabang;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "REGISTER",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please type an name';
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please type an email';
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please type an cabang toko';
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Cabang Toko",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onChanged: (value) {
                    cabang = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return "Your password needs to be at least 6 characters";
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onChanged: (value) {
                    password = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Ganti dengan warna yang diinginkan
                  ),
                  child: Text('Register'),
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      UserModel? registeredUser =
                          await authCtr.registerWithEmailAndPassword(
                              email!, password!, name!, cabang!);
                      if (registeredUser != null) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Register Success'),
                              content: const Text(
                                  'You have been successfully registered'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()));
                                    print(registeredUser.name);
                                  },
                                  child: const Text('Ok'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        //register gagal
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Register Failed'),
                                content: const Text(
                                    'An error occurend during registration'),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Register()));
                                      },
                                      child: const Text('Ok'))
                                ],
                              );
                            });
                      }
                    }
                  },
                )
              ],
            )),
      ),
    );
  }
}
