import 'dart:convert';

import 'package:festix_app_admin/src/const/const_storage.dart';
import 'package:festix_app_admin/src/shared/app_colors.dart';
import 'package:festix_app_admin/src/shared/divider_custom.dart';
import 'package:festix_app_admin/src/utils/FormatDate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../../box_ui.dart';

class EventDayList extends StatefulWidget {
  final String title;
  final Map<String, dynamic> loadedValue;
  const EventDayList({Key? key, required this.title, required this.loadedValue,}) : super(key: key);

  @override
  _EventDayListState createState() => _EventDayListState();
}

class _EventDayListState extends State<EventDayList> {
  @override
  void initState() {
    super.initState();
  }

  Padding buildContent() {
    List<Widget> rows = [];
    Widget row = const Padding(padding: EdgeInsets.all(0));
    for (var i = 0; i < widget.loadedValue['data']["events"].length; i++) {
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BoxText.body(DateFormat.dateFormatHourMinutes(DateTime.parse(widget.loadedValue['data']['events'][i]['dateTime']))),
            Row(
              children: [
                // _loadedEvents['data']['events'][i]['artistEnAvant']
                SizedBox(
                    width: 170,
                    child: BoxText.body(widget.loadedValue['data']['events'][i]['artistEnAvant'])),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.info,
                      color: kcGrey50Color,
                    ),
                    iconSize: 20,
                    padding: const EdgeInsets.all(0),
                  ),
                ),
              ],
            ),
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
        padding: const EdgeInsets.fromLTRB(30, 10, 0, 0), child: row);
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
          child:
          Padding(
            padding: const EdgeInsets.fromLTRB(0,20,0,0),
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
                  buildContent()
                ]);
              },
            ),
          ),
        )
    );
  }
}
