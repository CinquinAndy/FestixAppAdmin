import 'dart:convert';
import 'dart:ffi';

import 'package:festix_app_admin/src/const/const_storage.dart';
import 'package:festix_app_admin/src/models/FestivalModel.dart';
import 'package:festix_app_admin/src/shared/app_colors.dart';
import 'package:festix_app_admin/src/shared/divider_custom.dart';
import 'package:festix_app_admin/src/utils/regexp.dart';
import 'package:festix_app_admin/src/widgets/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../../../box_ui.dart';

class AdminFestivalsList extends StatefulWidget {
  final String title;
  final Map<String, dynamic> loadedValue;

  const AdminFestivalsList({
    Key? key,
    required this.title,
    required this.loadedValue,
  }) : super(key: key);

  @override
  _AdminFestivalsListState createState() => _AdminFestivalsListState();
}

class _AdminFestivalsListState extends State<AdminFestivalsList> {
  // init variables
  TextEditingController txtEditId = TextEditingController();
  TextEditingController txtEditTitle = TextEditingController();
  TextEditingController txtEditPhotoUrl = TextEditingController();
  TextEditingController txtEditDescription = TextEditingController();
  TextEditingController txtEditDateStart = TextEditingController();
  TextEditingController txtEditDateEnd = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Padding buildContent() {
    List<Widget> rows = [];
    Widget row = const Padding(padding: EdgeInsets.all(0));
    for (var i = 0; i < widget.loadedValue['data']["festivals"].length; i++) {
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
                          BoxText.body(widget.loadedValue['data']['festivals'][i]['title']),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        BoxText.bodySub(
                          widget.loadedValue['data']['festivals'][i]['dateStart'],
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
                              txtEditId.text = widget.loadedValue['data']['festivals'][i]['id'];
                              txtEditTitle.text = widget.loadedValue['data']['festivals'][i]['title'];
                              txtEditDateStart.text = widget.loadedValue['data']['festivals'][i]['dateStart'];
                              txtEditDateEnd.text = widget.loadedValue['data']['festivals'][i]['dateEnd'];
                              txtEditDescription.text = widget.loadedValue['data']['festivals'][i]['description'];
                              txtEditPhotoUrl.text = widget.loadedValue['data']['festivals'][i]['photoUrl'];

                              // ****************************************** MODAL ************************** //
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: kcGrey750Color,
                                  context: context,
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  builder: (context) {
                                    return Wrap(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                                                    child: BoxText.heading3_5(
                                                      "Modifier un Festival",
                                                      color: kcGrey200Color,
                                                    ),
                                                  ),
                                                  // ****************************************** FIELDS MODAL ************************** //
                                                  Visibility(
                                                    child: TextFormField(
                                                      controller: txtEditId,
                                                      enabled: false,
                                                      readOnly: true,
                                                    ),
                                                    visible: false,
                                                  ),
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width - 70,
                                                    child: TextFormField(
                                                      textAlign: TextAlign.left,
                                                      controller: txtEditTitle,
                                                      style: bodyBaseTextStyle,
                                                      cursorColor: kcGrey100Color,
                                                      decoration: InputDecoration(
                                                        contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                                        filled: true,
                                                        fillColor: kcGrey800Color,
                                                        hintText: widget.loadedValue['data']['festivals'][i]['title'],
                                                        hintStyle: inputModalTextStyle,
                                                        floatingLabelStyle: inputModalTextStyle,
                                                        labelStyle: bodyBaseTextStyle,
                                                        prefixIconColor: kcGrey100Color,
                                                        border: const OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(8)),
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
                                                    width: MediaQuery.of(context).size.width - 70,
                                                    child: TextFormField(
                                                      textAlign: TextAlign.left,
                                                      controller: txtEditPhotoUrl,
                                                      style: bodyBaseTextStyle,
                                                      cursorColor: kcGrey100Color,
                                                      decoration: InputDecoration(
                                                        contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                                        filled: true,
                                                        fillColor: kcGrey800Color,
                                                        hintText: widget.loadedValue['data']['festivals'][i]['photoUrl'],
                                                        hintStyle: inputModalTextStyle,
                                                        floatingLabelStyle: inputModalTextStyle,
                                                        labelStyle: bodyBaseTextStyle,
                                                        prefixIconColor: kcGrey100Color,
                                                        border: const OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(8)),
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
                                                    width: MediaQuery.of(context).size.width - 70,
                                                    child: TextFormField(
                                                      readOnly: true,
                                                      onTap: () async {
                                                        DateTime? pickedDate = await showDatePicker(
                                                            context: context,
                                                            initialDate: DateTime.now(),
                                                            firstDate: DateTime.now(), //DateTime.now() - not to allow to choose before today.
                                                            lastDate: DateTime.now().add(const Duration(days: 365)));

                                                        if (pickedDate != null) {
                                                          print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                                          print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                                          //you can implement different kind of Date Format here according to your requirement

                                                          setState(() {
                                                            txtEditDateStart.text = formattedDate; //set output date to TextField value.
                                                          });
                                                        } else {
                                                          print("Date is not selected");
                                                        }
                                                      },
                                                      textAlign: TextAlign.left,
                                                      controller: txtEditDateStart,
                                                      style: bodyBaseTextStyle,
                                                      cursorColor: kcGrey100Color,
                                                      decoration: InputDecoration(
                                                        contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                                        filled: true,
                                                        fillColor: kcGrey800Color,
                                                        hintText: widget.loadedValue['data']['festivals'][i]['dateStart'],
                                                        hintStyle: inputModalTextStyle,
                                                        floatingLabelStyle: inputModalTextStyle,
                                                        labelStyle: bodyBaseTextStyle,
                                                        prefixIconColor: kcGrey100Color,
                                                        border: const OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(8)),
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
                                                    width: MediaQuery.of(context).size.width - 70,
                                                    child: TextFormField(
                                                      readOnly: true,
                                                      onTap: () async {
                                                        DateTime? pickedDate = await showDatePicker(
                                                            context: context,
                                                            initialDate: DateTime.now(),
                                                            firstDate: DateTime.now(), //DateTime.now() - not to allow to choose before today.
                                                            lastDate: DateTime.now().add(const Duration(days: 365)));

                                                        if (pickedDate != null) {
                                                          print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                                          print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                                          //you can implement different kind of Date Format here according to your requirement

                                                          setState(() {
                                                            txtEditDateEnd.text = formattedDate; //set output date to TextField value.
                                                          });
                                                        } else {
                                                          print("Date is not selected");
                                                        }
                                                      },
                                                      textAlign: TextAlign.left,
                                                      controller: txtEditDateEnd,
                                                      style: bodyBaseTextStyle,
                                                      cursorColor: kcGrey100Color,
                                                      decoration: InputDecoration(
                                                        contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                                        filled: true,
                                                        fillColor: kcGrey800Color,
                                                        hintText: widget.loadedValue['data']['festivals'][i]['dateEnd'],
                                                        hintStyle: inputModalTextStyle,
                                                        floatingLabelStyle: inputModalTextStyle,
                                                        labelStyle: bodyBaseTextStyle,
                                                        prefixIconColor: kcGrey100Color,
                                                        border: const OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                                          borderSide: BorderSide(
                                                            width: 0,
                                                            style: BorderStyle.none,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // ****************************************** BUTTONS MODAL ************************** //
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width - 70,
                                                    height: 250,
                                                    child: TextFormField(
                                                      keyboardType: TextInputType.multiline,
                                                      maxLines: null,
                                                      textAlign: TextAlign.left,
                                                      controller: txtEditDescription,
                                                      style: bodyBaseTextStyle,
                                                      cursorColor: kcGrey100Color,
                                                      decoration: InputDecoration(
                                                        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                                        filled: true,
                                                        fillColor: kcGrey800Color,
                                                        hintText: widget.loadedValue['data']['festivals'][i]['description'],
                                                        hintStyle: inputModalTextStyle,
                                                        floatingLabelStyle: inputModalTextStyle,
                                                        labelStyle: bodyBaseTextStyle,
                                                        prefixIconColor: kcGrey100Color,
                                                        border: const OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                                          borderSide: BorderSide(
                                                            width: 0,
                                                            style: BorderStyle.none,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 30,
                                                  ),
                                                  Row(
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: BoxText.body("Annuler", color: kcGrey900Color),
                                                        style: ElevatedButton.styleFrom(
                                                          fixedSize: Size(MediaQuery.of(context).size.width / 2 - 80, 50),
                                                          primary: kcGrey200Color,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 40,
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          _update();
                                                        },
                                                        child: BoxText.body("Modifier", color: kcGrey900Color),
                                                        style: ElevatedButton.styleFrom(
                                                          fixedSize: Size(MediaQuery.of(context).size.width / 2 - 80, 50),
                                                          primary: kcBlue500Color,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
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
                            onPressed: () {
                              // Set fields
                              txtEditId.text = widget.loadedValue['data']['festivals'][i]['id'];
                              txtEditTitle.text = widget.loadedValue['data']['festivals'][i]['title'];
                              txtEditDateStart.text = widget.loadedValue['data']['festivals'][i]['dateStart'];
                              txtEditDateEnd.text = widget.loadedValue['data']['festivals'][i]['dateEnd'];
                              txtEditDescription.text = widget.loadedValue['data']['festivals'][i]['description'];
                              txtEditPhotoUrl.text = widget.loadedValue['data']['festivals'][i]['photoUrl'];
                              _delete();
                            },
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
                          padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                          child: IconButton(
                            onPressed: () {
                              // Set fields
                              txtEditId.text = widget.loadedValue['data']['festivals'][i]['id'];
                              txtEditTitle.text = widget.loadedValue['data']['festivals'][i]['title'];
                              txtEditDateStart.text = widget.loadedValue['data']['festivals'][i]['dateStart'];
                              txtEditDateEnd.text = widget.loadedValue['data']['festivals'][i]['dateEnd'];
                              txtEditDescription.text = widget.loadedValue['data']['festivals'][i]['description'];
                              txtEditPhotoUrl.text = widget.loadedValue['data']['festivals'][i]['photoUrl'];
                              //todo GO EVENTS -> with id festival
                            },
                            icon: const Icon(
                              Icons.event,
                              color: kcBlue500Color,
                            ),
                            iconSize: 20,
                            padding: const EdgeInsets.all(0),
                          ),
                        ),
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

  @override
  Widget build(BuildContext context) {
    return Container(
        child: widget.loadedValue.isEmpty
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

  FestivalModel? getFestivalsSelected() {
    for (var festival in widget.loadedValue['data']['festivals']) {
      if (festival['id'] == txtEditId.text) {
        print(txtEditDateStart.text);
        print(txtEditDateEnd.text);
        return FestivalModel(txtEditId.text, txtEditTitle.text, txtEditPhotoUrl.text, txtEditDescription.text, DateTime.parse(txtEditDateStart.text), DateTime.parse(txtEditDateEnd.text));
      }
    }
    return null;
  }

  Future<String> cookies() async {
    String? X_XSRF_TOKEN = RegexpTokens.getExtractedTokenFromCookie(await const FlutterSecureStorage().read(key: ConstStorage.X_XSRF_TOKEN) ?? "");
    String? COOKIE_BEARER = RegexpTokens.getExtractedTokenFromCookie(await const FlutterSecureStorage().read(key: ConstStorage.COOKIE_BEARER) ?? "");
    String? JSESSIONID = RegexpTokens.getExtractedTokenFromCookie(await const FlutterSecureStorage().read(key: ConstStorage.JSESSIONID) ?? "");
    if (X_XSRF_TOKEN != null && X_XSRF_TOKEN != "") {
      if (COOKIE_BEARER != null && COOKIE_BEARER != "") {
        if (JSESSIONID != null && JSESSIONID != "") {
          return "XSRF-TOKEN=" + X_XSRF_TOKEN + "; " + "COOKIE-BEARER=" + COOKIE_BEARER + "; " + "JSESSIONID=" + JSESSIONID;
        } else {
          return "XSRF-TOKEN=" + X_XSRF_TOKEN + "; " + "COOKIE-BEARER=" + COOKIE_BEARER;
        }
      } else {
        if (JSESSIONID != null && COOKIE_BEARER != "") {
          return "XSRF-TOKEN=" + X_XSRF_TOKEN + "; " + "JSESSIONID=" + JSESSIONID;
        } else {
          return "XSRF-TOKEN=" + X_XSRF_TOKEN;
        }
      }
    } else {
      if (COOKIE_BEARER != null && COOKIE_BEARER != "") {
        if (JSESSIONID != null && COOKIE_BEARER != "") {
          return "COOKIE-BEARER=" + COOKIE_BEARER + "; " + "JSESSIONID=" + JSESSIONID;
        } else {
          return "COOKIE-BEARER=" + COOKIE_BEARER;
        }
      } else {
        if (JSESSIONID != null && COOKIE_BEARER != "") {
          return "JSESSIONID=" + JSESSIONID;
        } else {
          return "";
        }
      }
    }
  }

  void _update() async {
    print("update");
    var value = getFestivalsSelected();
    if (value != null) {
      FestivalModel festivalModel = value;
      http.Response response = await http.patch(
        Uri.parse(ConstStorage.API_URL + '/festival/update/' + festivalModel.id + "/"),
        body: jsonEncode(
          <String, dynamic>{
            "title": festivalModel.title,
            "description": festivalModel.description,
            "photoUrl": festivalModel.photoUrl,
            "dateStart": DateFormat("yyyy-MM-dd").format(festivalModel.dateStart),
            "dateEnd": DateFormat("yyyy-MM-dd").format(festivalModel.dateEnd),
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'cookie': await cookies(),
          'X-XSRF-TOKEN': RegexpTokens.getExtractedTokenFromCookie(await const FlutterSecureStorage().read(key: ConstStorage.X_XSRF_TOKEN) ?? ""),
        },
      );
      print(response);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        String? cookiesString = response.headers['set-cookie'];
        if (cookiesString != null) {
          await const FlutterSecureStorage().write(key: ConstStorage.X_XSRF_TOKEN, value: RegexpTokens.getCompleteXsrf(cookiesString));
          await const FlutterSecureStorage().write(key: ConstStorage.JSESSIONID, value: RegexpTokens.getCompleteJsessionid(cookiesString));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              action: SnackBarAction(
                label: '✘',
                onPressed: () {
                  ScaffoldMessengerState().removeCurrentSnackBar();
                },
              ),
              content: const Text("La modification c'est bien passée !"),
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
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed("/festivals");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            action: SnackBarAction(
              label: '✘',
              onPressed: () {
                ScaffoldMessengerState().removeCurrentSnackBar();
              },
            ),
            content: const Text("Erreur lors de la modification !"),
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

  void _delete() async {
    var value = getFestivalsSelected();
    if (value != null) {
      FestivalModel festivalModel = value;
      http.Response response = await http.delete(
        Uri.parse(ConstStorage.API_URL + '/festival/delete/' + festivalModel.id + "/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'cookie': await cookies(),
          'X-XSRF-TOKEN': RegexpTokens.getExtractedTokenFromCookie(await const FlutterSecureStorage().read(key: ConstStorage.X_XSRF_TOKEN) ?? ""),
        },
      );
      if (response.statusCode == 200) {
        String? cookiesString = response.headers['set-cookie'];
        if (cookiesString != null) {
          await const FlutterSecureStorage().write(key: ConstStorage.X_XSRF_TOKEN, value: RegexpTokens.getCompleteXsrf(cookiesString));
          await const FlutterSecureStorage().write(key: ConstStorage.JSESSIONID, value: RegexpTokens.getCompleteJsessionid(cookiesString));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              action: SnackBarAction(
                label: '✘',
                onPressed: () {
                  ScaffoldMessengerState().removeCurrentSnackBar();
                },
              ),
              content: const Text("Suppression ok !"),
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
        Navigator.of(context).pushNamed("/festivals");
      } else {
        print("error");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            action: SnackBarAction(
              label: '✘',
              onPressed: () {
                ScaffoldMessengerState().removeCurrentSnackBar();
              },
            ),
            content: const Text("Erreur !"),
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
}
