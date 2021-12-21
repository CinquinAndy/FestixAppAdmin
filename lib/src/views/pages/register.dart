import 'package:festix_app_admin/src/shared/app_colors.dart';
import 'package:festix_app_admin/src/views/components/background_custom.dart';
import 'package:festix_app_admin/src/views/components/card/event/event_day_list.dart';
import 'package:festix_app_admin/src/views/components/navbar/navigation_bar_custom.dart';
import 'package:festix_app_admin/src/widgets/styles.dart';
import 'package:flutter/material.dart';

import '../../../box_ui.dart';

class Register extends StatefulWidget {
  final String title;
  final String backtitle;
  const Register(this.title,{Key? key, required this.backtitle}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController txtEditFirstname = TextEditingController();
  TextEditingController txtEditLastname = TextEditingController();
  TextEditingController txtEditEmail = TextEditingController();
  TextEditingController txtEditPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MainPersonnalizedScafold(
      title: widget.title,
      backtitle: widget.backtitle,
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
                              "Inscription",
                              color: kcGrey100Color,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width-40,
                        child: TextFormField(
                          controller: txtEditLastname,
                          style: bodyBaseTextStyle,
                          cursorColor: kcGrey100Color,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: kcGrey700OpacityColor,
                              hintText: "Nom",
                              prefixIcon: Icon(Icons.drive_file_rename_outline_rounded,color: kcGrey100Color,),
                              hintStyle: bodyBaseTextStyle,
                              floatingLabelStyle: bodyBaseTextStyle,
                              labelStyle: bodyBaseTextStyle,
                              prefixIconColor: kcGrey100Color,
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)))
                          ),
                          validator: (value){
                            return validateEmail(value.toString());
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width-40,
                        child: TextFormField(
                          controller: txtEditFirstname,
                          style: bodyBaseTextStyle,
                          cursorColor: kcGrey100Color,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: kcGrey700OpacityColor,
                              hintText: "Prénom",
                              prefixIcon: Icon(Icons.drive_file_rename_outline_rounded,color: kcGrey100Color,),
                              hintStyle: bodyBaseTextStyle,
                              floatingLabelStyle: bodyBaseTextStyle,
                              labelStyle: bodyBaseTextStyle,
                              prefixIconColor: kcGrey100Color,
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)))
                          ),
                          validator: (value){
                            return validateEmail(value.toString());
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width-40,
                        child: TextFormField(
                          controller: txtEditEmail,
                          style: bodyBaseTextStyle,
                          cursorColor: kcGrey100Color,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: kcGrey700OpacityColor,
                            hintText: "Email",
                            prefixIcon: Icon(Icons.alternate_email_rounded,color: kcGrey100Color,),
                            hintStyle: bodyBaseTextStyle,
                            floatingLabelStyle: bodyBaseTextStyle,
                            labelStyle: bodyBaseTextStyle,
                            prefixIconColor: kcGrey100Color,
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)))
                          ),
                          validator: (value){
                            return validateEmail(value.toString());
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width-40,
                        child: TextFormField(
                          controller: txtEditPassword,
                          style: bodyBaseTextStyle,
                          cursorColor: kcGrey100Color,
                          obscureText: true,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: kcGrey700OpacityColor,
                              hintText: "Password",
                              prefixIcon: Icon(Icons.password_rounded,color: kcGrey100Color,),
                              hintStyle: bodyBaseTextStyle,
                              floatingLabelStyle: bodyBaseTextStyle,
                              labelStyle: bodyBaseTextStyle,
                              prefixIconColor: kcGrey100Color,
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)))
                          ),
                          validator: (value){
                            return validateEmail(value.toString());
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
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
                                  Navigator.of(context).pushNamed("/login");
                                },
                                child: BoxText.link(
                                  "Déjà un compte ? Se connecté !",
                                  color: kcGrey100Color,
                                )),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child:
                        BoxText.body("S'inscrire", color: kcGrey900Color),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                              MediaQuery.of(context).size.width - 80, 40),
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

  String validateEmail(String value) {
    String pattern = r'([a-zA-Z]+@[a-zA-Z]+\.[a-zA-Z])';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter a value';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid email';
    }
    return '';
  }


}

