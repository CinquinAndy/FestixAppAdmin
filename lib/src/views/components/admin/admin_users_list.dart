import 'dart:convert';
import 'dart:ffi';

import 'package:festix_app_admin/src/shared/app_colors.dart';
import 'package:festix_app_admin/src/shared/divider_custom.dart';
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
  Map<String, dynamic> switchesValues = {};

  Future<void> _setDataSwitch() async {
    print(widget.loadedValue['data']["users"].length);
    for (var i = 0; widget.loadedValue['data']["users"].length > i; i++) {
      switchesValues.putIfAbsent(
          widget.loadedValue['data']["users"][i]["username"],
          () => widget.loadedValue['data']["users"][i]["enabled"]);
    }
    print(switchesValues);

    setState(() {
      // valuesSwitched =
    });
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
                              widget.loadedValue['data']['users'][i]['firstname']),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        BoxText.bodySub("administrateur validé :", color: kcGrey200Color,),
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
                            onPressed: () {},
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
                                  switchesValues[widget.loadedValue['data']["users"]
                                      [i]["username"]] = value;
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

    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0), child: row);
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
