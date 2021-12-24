import 'dart:convert';

import 'package:festix_app_admin/src/const/const_storage.dart';
import 'package:festix_app_admin/src/utils/regexp.dart';
import 'package:festix_app_admin/src/views/components/admin/admin_events_list.dart';
import 'package:festix_app_admin/src/views/components/background_custom.dart';
import 'package:festix_app_admin/src/views/components/card/snack_bar_custom.dart';
import 'package:festix_app_admin/src/views/components/navbar/navigation_bar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Events extends StatefulWidget {
  final String title;
  final String backtitle;

  const Events(this.title, {Key? key, required this.backtitle}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  void initState() {
    super.initState();
    args = '';
    flag = false;
  }

  dynamic args;
  bool flag = false;
  Map<String, dynamic> _loadedEvents = {};

  Future<void> _fetchDataEvents(args) async {
    final response = await http.get(Uri.parse(ConstStorage.API_URL + "/event/list/byfestival/" + args.id + "/"));
    final data = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      String? cookiesString = response.headers['set-cookie'];

      if (cookiesString != null) {
        await const FlutterSecureStorage().write(key: ConstStorage.X_XSRF_TOKEN, value: RegexpTokens.getCompleteXsrf(cookiesString));
        CustomWidgets.buildSnackbar(context, "Les données ont bien étés récupérées !");
      }
    } else {
      CustomWidgets.buildSnackbar(context, "Erreur lors de la récupération des données !");
    }

    setState(() {
      _loadedEvents = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (flag != true) {
      args = ModalRoute.of(context)!.settings.arguments as dynamic;
      flag = true;
      if (args != null) {
        _fetchDataEvents(args);
      }
    }

    return MainPersonnalizedScafold(
      title: widget.title,
      backtitle: widget.backtitle,
      displayImage: false,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _loadedEvents.isEmpty
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
              : AdminEventsList(
                  title: "Evenements",
                  loadedValue: _loadedEvents,
                  idFestival: args.id,
                ),
          const CustomNavBar(
            isHomeSelectionned: false,
            isFestivalsSelectionned: false,
            isArtistsSelectionned: false,
            isSideTitleEnabled: false,
          )
        ],
      ),
    );
  }
}
