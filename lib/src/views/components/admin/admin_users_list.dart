import 'dart:convert';
import 'dart:ffi';

import 'package:festix_app_admin/src/shared/app_colors.dart';
import 'package:festix_app_admin/src/shared/divider_custom.dart';
import 'package:festix_app_admin/src/widgets/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../../box_ui.dart';

class AdminUsersList extends StatefulWidget {
  final String title;
  final Map<String, dynamic> loadedValue;

  const AdminUsersList({
    Key? key,
    required this.title,
    required this.loadedValue,
  }) : super(key: key);

  @override
  _AdminUsersListState createState() => _AdminUsersListState();
}

class _AdminUsersListState extends State<AdminUsersList> {
  // init variables
  TextEditingController txtEditFirstname = TextEditingController();
  TextEditingController txtEditLastname = TextEditingController();
  TextEditingController txtEditUsername = TextEditingController();
  TextEditingController txtEditEmail = TextEditingController();
  Map<String, dynamic> switchesValues = {};

  /**
   * set data for all switches
   */
  Future<void> _setDataSwitch() async {
    for (var i = 0; widget.loadedValue['data']["users"].length > i; i++) {
      switchesValues.putIfAbsent(
          widget.loadedValue['data']["users"][i]["username"],
          () => widget.loadedValue['data']["users"][i]["enabled"]);
    }
  }

  @override
  void initState() {
    super.initState();
    _setDataSwitch();
  }

  Padding buildContent() {
    List<Widget> rows = [];
    Widget row = const Padding(padding: EdgeInsets.all(0));
    for (var i = 0; i < widget.loadedValue['data']["users"].length; i++) {
      rows.add(
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          BoxText.body(widget.loadedValue['data']['users'][i]
                                  ['lastname'] +
                              " " +
                              widget.loadedValue['data']['users'][i]
                                  ['firstname']),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        BoxText.bodySub(
                          "administrateur validé :",
                          color: kcGrey200Color,
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: IconButton(
                            onPressed: () {
                              // Set fields
                              txtEditFirstname.text = widget.loadedValue['data']['users'][i]['firstname'];
                              txtEditLastname.text = widget.loadedValue['data']['users'][i]['lastname'];
                              txtEditUsername.text = widget.loadedValue['data']['users'][i]['username'];
                              txtEditEmail.text = widget.loadedValue['data']['users'][i]['email'];
                              // ****************************************** MODAL ************************** //
                              showModalBottomSheet(backgroundColor: kcGrey750Color, context: context, elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),builder: (context){
                                return Wrap(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(20,20,20,0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0,40,0,40),
                                                child: BoxText.heading3_5("Modifier un Utilisateur", color: kcGrey200Color,),
                                              ),
                                              // ****************************************** FIELDS MODAL ************************** //
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width - 70,
                                                child: TextFormField(
                                                  textAlign: TextAlign.left,
                                                  controller: txtEditUsername,
                                                  style: bodyBaseTextStyle,
                                                  cursorColor: kcGrey100Color,
                                                  decoration: InputDecoration(
                                                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                                      filled: true,
                                                      fillColor: kcGrey800Color,
                                                      hintText: widget.loadedValue['data']['users'][i]['firstname'],
                                                      hintStyle: inputModalTextStyle,
                                                      floatingLabelStyle: inputModalTextStyle,
                                                      labelStyle: bodyBaseTextStyle,
                                                      prefixIconColor: kcGrey100Color,
                                                      border: const OutlineInputBorder(
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
                                              const SizedBox(height: 10,),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width - 70,
                                                child: TextFormField(
                                                  textAlign: TextAlign.left,
                                                  controller: txtEditFirstname,
                                                  style: bodyBaseTextStyle,
                                                  cursorColor: kcGrey100Color,
                                                  decoration: const InputDecoration(
                                                    contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                                    filled: true,
                                                    fillColor: kcGrey800Color,
                                                    hintText: "Prénom",
                                                    hintStyle: inputModalTextStyle,
                                                    floatingLabelStyle: inputModalTextStyle,
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
                                              const SizedBox(height: 10,),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width - 70,
                                                child: TextFormField(
                                                  textAlign: TextAlign.left,
                                                  controller: txtEditLastname,
                                                  style: bodyBaseTextStyle,
                                                  cursorColor: kcGrey100Color,
                                                  decoration: const InputDecoration(
                                                    contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                                    filled: true,
                                                    fillColor: kcGrey800Color,
                                                    hintText: "Nom",
                                                    hintStyle: inputModalTextStyle,
                                                    floatingLabelStyle: inputModalTextStyle,
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
                                              const SizedBox(height: 10,),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width - 70,
                                                child: TextFormField(
                                                  textAlign: TextAlign.left,
                                                  controller: txtEditEmail,
                                                  style: bodyBaseTextStyle,
                                                  cursorColor: kcGrey100Color,
                                                  decoration: const InputDecoration(
                                                    contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                                    filled: true,
                                                    fillColor: kcGrey800Color,
                                                    hintText: "Email",
                                                    hintStyle: inputModalTextStyle,
                                                    floatingLabelStyle: inputModalTextStyle,
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
                                                  validator: (value) {
                                                    return validateEmail(value.toString());
                                                  },
                                                ),
                                              ),
                                              // ****************************************** BUTTONS MODAL ************************** //
                                              const SizedBox(height: 10,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  BoxText.body("Administrateur validé ?", color: kcGrey200Color,),
                                                  Switch(
                                                      value: switchesValues[widget.loadedValue['data']
                                                      ["users"][i]["username"]],
                                                      onChanged: (value) {
                                                        setState(() {
                                                          switchesValues[widget.loadedValue['data']
                                                          ["users"][i]["username"]] = value;
                                                        });
                                                      }),
                                                ],
                                              ),
                                              const SizedBox(height: 30,),
                                              Row(
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child:
                                                    BoxText.body("Annuler", color: kcGrey900Color),
                                                    style: ElevatedButton.styleFrom(
                                                      fixedSize:
                                                      Size(MediaQuery.of(context).size.width/2 - 80, 50),
                                                      primary: kcGrey200Color,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 40,),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child:
                                                    BoxText.body("Modifier", color: kcGrey900Color),
                                                    style: ElevatedButton.styleFrom(
                                                      fixedSize:
                                                      Size(MediaQuery.of(context).size.width/2 - 80, 50),
                                                      primary: kcBlue500Color,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10,),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              });
                            },
                            icon: const Icon(
                              Icons.edit_rounded,
                              color: kcOrange500Color,
                            ),
                            iconSize: 20,
                            padding: const EdgeInsets.all(0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.delete_rounded,
                              color: kcRed500Color,
                            ),
                            iconSize: 20,
                            padding: const EdgeInsets.all(0),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 28, 0),
                          child: Switch(
                              value: switchesValues[widget.loadedValue['data']
                                  ["users"][i]["username"]],
                              onChanged: (value) {
                                setState(() {
                                  switchesValues[widget.loadedValue['data']
                                      ["users"][i]["username"]] = value;
                                });
                              }),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const DividerCustom(height: 0.3, width: 400),
          ],
        ),
      );
    }
    row = Container(
      child: Column(
        children: rows,
      ),
    );

    return Padding(padding: const EdgeInsets.fromLTRB(0, 10, 0, 0), child: row);
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

  @override
  Widget build(BuildContext context) {
    return Container(
        child: widget.loadedValue.isEmpty || switchesValues.isEmpty
            ? Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(
                        semanticsLabel: 'Linear progress indicator',
                      ),
                    ),
                  ],
                ),
              )
            : Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 20, 20, 0),
                  child: ListView.builder(
                    itemCount: 1,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext ctx, index) {
                      return Column(children: [
                        Row(
                          children: [
                            BoxText.heading3_5(
                              widget.title,
                              color: kcGrey50Color,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: DividerCustom(height: 2, width: 400),
                        ),
                        buildContent(),
                      ]);
                    },
                  ),
                ),
              ));
  }
}
