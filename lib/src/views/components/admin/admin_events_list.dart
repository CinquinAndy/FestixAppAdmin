import 'dart:convert';

import 'package:festix_app_admin/src/const/const_storage.dart';
import 'package:festix_app_admin/src/models/EventModel.dart';
import 'package:festix_app_admin/src/shared/app_colors.dart';
import 'package:festix_app_admin/src/shared/divider_custom.dart';
import 'package:festix_app_admin/src/utils/regexp.dart';
import 'package:festix_app_admin/src/views/components/card/snack_bar_custom.dart';
import 'package:festix_app_admin/src/widgets/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../../../box_ui.dart';

class AdminEventsList extends StatefulWidget {
  final String title;
  final Map<String, dynamic> loadedValue;
  final String idFestival;

  const AdminEventsList({
    Key? key,
    required this.title,
    required this.loadedValue,
    required this.idFestival,
  }) : super(key: key);

  @override
  _AdminEventsListState createState() => _AdminEventsListState();
}

class _AdminEventsListState extends State<AdminEventsList> {
  // init variables
  TextEditingController txtEditId = TextEditingController();
  TextEditingController txtEditTitle = TextEditingController();
  TextEditingController txtEditDate = TextEditingController();
  TextEditingController txtEditTime = TextEditingController();
  TextEditingController txtEditArtistEnAvant = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Padding buildContent() {
    List<Widget> rows = [];
    Widget row = const Padding(padding: EdgeInsets.all(0));
    for (var i = 0; i < widget.loadedValue['data']["events"].length; i++) {
      rows.add(
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            BoxText.body(widget.loadedValue['data']['events'][i]['title']),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          BoxText.bodySub(
                            DateFormat('yyyy-MM-dd hh:mm').format(DateTime.parse(widget.loadedValue['data']['events'][i]['dateTime'])),
                            color: kcGrey200Color,
                          ),
                        ],
                      )
                    ],
                  ),
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
                              txtEditId.text = widget.loadedValue['data']['events'][i]['id'];
                              txtEditTitle.text = widget.loadedValue['data']['events'][i]['title'];
                              txtEditDate.text = DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.loadedValue['data']['events'][i]['dateTime']));
                              txtEditTime.text = DateFormat("hh:mm").format(DateTime.parse(widget.loadedValue['data']['events'][i]['dateTime']));
                              txtEditArtistEnAvant.text = widget.loadedValue['data']['events'][i]['artistEnAvant'];

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
                                                      "Modifier un Event",
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
                                                        hintText: widget.loadedValue['data']['events'][i]['title'],
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
                                                      controller: txtEditArtistEnAvant,
                                                      style: bodyBaseTextStyle,
                                                      cursorColor: kcGrey100Color,
                                                      decoration: InputDecoration(
                                                        contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                                        filled: true,
                                                        fillColor: kcGrey800Color,
                                                        hintText: widget.loadedValue['data']['events'][i]['artistEnAvant'],
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
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(context).size.width / 2 - 70,
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
                                                                txtEditDate.text = formattedDate; //set output date to TextField value.
                                                              });
                                                            } else {
                                                              print("Date is not selected");
                                                            }
                                                          },
                                                          textAlign: TextAlign.left,
                                                          controller: txtEditDate,
                                                          style: bodyBaseTextStyle,
                                                          cursorColor: kcGrey100Color,
                                                          decoration: InputDecoration(
                                                            contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                                            filled: true,
                                                            fillColor: kcGrey800Color,
                                                            hintText: DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.loadedValue['data']['events'][i]['dateTime'])),
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
                                                        width: 30,
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(context).size.width / 2 - 70,
                                                        child: TextFormField(
                                                          readOnly: true,
                                                          onTap: () async {
                                                            TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                                                            if (pickedTime != null) {
                                                              print(pickedTime); //pickedDate output format => 2021-03-10 00:00:00.000
                                                              final now = DateTime.now();
                                                              final dt = DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
                                                              final format = DateFormat.jm(); //"6:00 AM"
                                                              String formattedTime = format.format(dt);
                                                              print(formattedTime);
                                                              //formatted date output using intl package =>  2021-03-16
                                                              //you can implement different kind of Date Format here according to your requirement

                                                              setState(() {
                                                                txtEditTime.text = formattedTime; //set output date to TextField value.
                                                              });
                                                            } else {
                                                              print("Date is not selected");
                                                            }
                                                          },
                                                          textAlign: TextAlign.left,
                                                          controller: txtEditTime,
                                                          style: bodyBaseTextStyle,
                                                          cursorColor: kcGrey100Color,
                                                          decoration: InputDecoration(
                                                            contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                                            filled: true,
                                                            fillColor: kcGrey800Color,
                                                            hintText: DateFormat("hh:mm").format(DateTime.parse(widget.loadedValue['data']['events'][i]['dateTime'])),
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
                                                    ],
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              txtEditId.text = widget.loadedValue['data']['events'][i]['id'];
                              txtEditTitle.text = widget.loadedValue['data']['events'][i]['title'];
                              txtEditDate.text = DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.loadedValue['data']['events'][i]['dateTime']));
                              txtEditTime.text = DateFormat("hh:mm").format(DateTime.parse(widget.loadedValue['data']['events'][i]['dateTime']));
                              txtEditArtistEnAvant.text = widget.loadedValue['data']['events'][i]['artistEnAvant'];
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

  EventModel? getEventsSelected() {
    for (var event in widget.loadedValue['data']['events']) {
      if (event['id'] == txtEditId.text) {
        DateTime datetime = DateTime.parse(txtEditDate.text + "T" + txtEditTime.text);
        return EventModel(txtEditId.text, txtEditTitle.text, datetime, txtEditArtistEnAvant.text, widget.idFestival);
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
    var value = getEventsSelected();
    if (value != null) {
      EventModel eventModel = value;
      http.Response response = await http.patch(
        Uri.parse(ConstStorage.API_URL + '/event/update/' + eventModel.id + "/"),
        body: jsonEncode(
          <String, dynamic>{"title": eventModel.title, "dateTime": DateFormat("yyyy-MM-ddThh:mm").format(eventModel.dateTime), "artistEnAvant": eventModel.artistEnAvant, "festival": widget.idFestival},
        ),
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
          CustomWidgets.buildSnackbar(context, "L'update c'est bien passée !");
        }
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed("/events");
      } else {
        CustomWidgets.buildSnackbar(context, "Erreur lors de l'update !");
      }
    }
  }

  void _delete() async {
    var value = getEventsSelected();
    if (value != null) {
      EventModel eventModel = value;
      http.Response response = await http.delete(
        Uri.parse(ConstStorage.API_URL + '/event/delete/' + eventModel.id + "/"),
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
          CustomWidgets.buildSnackbar(context, "La suppression c'est bien passée !");
        }
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed("/events");
      } else {
        CustomWidgets.buildSnackbar(context, "Erreur lors de la suppression !");
      }
    }
  }
}
