import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void Login(String usrname, String passwrd) async {
    Response res =
        await post(Uri.parse('https://dummyjson.com/auth/login'), body: {
      'username': usrname,
      'password': passwrd,
    });
    if(res.statusCode==200){
      print('loggin succeeded'+res.body.toString());
    }else{
      print(
        'could not succeded'+res.body.toString()
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController usrname = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
        body: SafeArea(
      child: Container(
          margin: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: usrname,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    hintText: 'enter your email'),
              ),
              SizedBox(
                height: 29,
              ),
              TextField(
                controller: password,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    hintText: 'enter your password'),
              ),
              InkWell(
                onTap: () {
                  Login(usrname.text, password.text);
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                  child: Center(
                    child: Text('Submit'),
                  ),
                ),
              )
            ],
          )),
    ));
  }
}
