import 'package:festix_app_admin/src/views/pages/artists.dart';
import 'package:festix_app_admin/src/views/pages/events.dart';
import 'package:festix_app_admin/src/views/pages/festivals.dart';
import 'package:festix_app_admin/src/views/pages/login.dart';
import 'package:festix_app_admin/src/views/pages/register.dart';
import 'package:festix_app_admin/src/views/pages/users.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String title = "FESTIX";
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: Festivals(
        title,
        backtitle: "",
      ),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => const Login(
          "FESTIX",
          backtitle: "",
        ),
        '/register': (BuildContext context) => const Register(
          "FESTIX",
          backtitle: "",
        ),
        '/users': (BuildContext context) => const Users(
          "FESTIX",
          backtitle: "",
        ),
        '/festivals': (BuildContext context) => const Festivals(
          "FESTIX",
          backtitle: "",
        ),
        '/events': (BuildContext context) => const Events(
          "FESTIX",
          backtitle: "",
        ),
        '/artists': (BuildContext context) => const Artists(
          "FESTIX",
          backtitle: "",
        ),
      },
    );
  }
}
