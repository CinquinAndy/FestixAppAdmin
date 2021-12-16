import 'package:festix_app_admin/src/views/pages/events.dart';
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

      // home: Home(
      //   title,
      //   backtitle: "",
      // ),
      home: Events(
        title,
        backtitle: "",
      ),
      routes: <String, WidgetBuilder>{
        '/events': (BuildContext context) => const Events(
          "FESTIX",
          backtitle: "",
        ),
      },
    );
  }
}
