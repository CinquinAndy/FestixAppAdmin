import 'dart:convert';
import 'dart:developer';

import 'package:festix_app_admin/src/shared/app_colors.dart';
import 'package:festix_app_admin/src/views/components/background_custom.dart';
import 'package:festix_app_admin/src/widgets/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../../box_ui.dart';
import '../../const/const_storage.dart';
import '../../utils/regexp.dart';

class Login extends StatefulWidget {
  final String title;
  final String backtitle;

  const Login(this.title, {Key? key, required this.backtitle})
      : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController txtEditUsername = TextEditingController();
  TextEditingController txtEditPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MainPersonnalizedScafold(
      title: widget.title,
      backtitle: widget.backtitle,
      displayImage: true,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40.0, 20, 40, 20),
                        child: Row(
                          children: [
                            BoxText.heading3_5(
                              "Connexion",
                              color: kcGrey100Color,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        child: TextFormField(
                          controller: txtEditUsername,
                          style: bodyBaseTextStyle,
                          cursorColor: kcGrey100Color,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: kcGrey700OpacityColor,
                            hintText: "Pseudo",
                            prefixIcon: Icon(
                              Icons.people_rounded,
                              color: kcGrey100Color,
                            ),
                            hintStyle: bodyBaseTextStyle,
                            floatingLabelStyle: bodyBaseTextStyle,
                            labelStyle: bodyBaseTextStyle,
                            prefixIconColor: kcGrey100Color,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        child: TextFormField(
                          controller: txtEditPassword,
                          style: bodyBaseTextStyle,
                          cursorColor: kcGrey100Color,
                          obscureText: true,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: kcGrey700OpacityColor,
                            hintText: "Password",
                            prefixIcon: Icon(
                              Icons.password_rounded,
                              color: kcGrey100Color,
                            ),
                            hintStyle: bodyBaseTextStyle,
                            floatingLabelStyle: bodyBaseTextStyle,
                            labelStyle: bodyBaseTextStyle,
                            prefixIconColor: kcGrey100Color,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pushNamed("/register");
                                },
                                child: BoxText.link(
                                  "Pas de compte ? S'inscrire !",
                                  color: kcGrey100Color,
                                )),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _login();
                        },
                        child: BoxText.body("Connexion", color: kcGrey900Color),
                        style: ElevatedButton.styleFrom(
                          fixedSize:
                              Size(MediaQuery.of(context).size.width - 80, 40),
                          primary: kcBlue300Color,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _login() async {
    String identifier = txtEditUsername.text;
    String password = txtEditPassword.text;
    http.Response response = await http.post(
      Uri.parse(ConstStorage.API_URL + '/login'),
      body: jsonEncode(
          <String, String>{"username": identifier, "password": password}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      String? cookiesString = response.headers['set-cookie'];
      if (cookiesString != null) {
        await const FlutterSecureStorage().write(
            key: ConstStorage.X_XSRF_TOKEN,
            value: RegexpTokens.getCompleteXsrf(cookiesString));
        await const FlutterSecureStorage().write(
            key: ConstStorage.COOKIE_BEARER,
            value: RegexpTokens.getCompleteBearer(cookiesString));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            action: SnackBarAction(
              label: '✘',
              onPressed: () {
                ScaffoldMessengerState().removeCurrentSnackBar();
              },
            ),
            content: const Text("La connexion c'est bien passée !"),
            duration: const Duration(milliseconds: 2000),
            width: MediaQuery.of(context).size.width - 40,
            // Width of the SnackBar.
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0, // Inner padding for SnackBar content.
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        );
      }
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed("/users");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          action: SnackBarAction(
            label: '✘',
            onPressed: () {
              ScaffoldMessengerState().removeCurrentSnackBar();
            },
          ),
          content: const Text("Erreur lors de la connexion !"),
          duration: const Duration(milliseconds: 2000),
          width: MediaQuery.of(context).size.width - 40,
          // Width of the SnackBar.
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0, // Inner padding for SnackBar content.
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      );
    }
  }
}
