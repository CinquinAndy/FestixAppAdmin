import 'dart:convert';

import 'package:festix_app_admin/src/const/const_storage.dart';
import 'package:festix_app_admin/src/utils/regexp.dart';
import 'package:festix_app_admin/src/views/components/admin/admin_festivals_list.dart';
import 'package:festix_app_admin/src/views/components/background_custom.dart';
import 'package:festix_app_admin/src/views/components/navbar/navigation_bar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Festivals extends StatefulWidget {
  final String title;
  final String backtitle;

  const Festivals(this.title, {Key? key, required this.backtitle}) : super(key: key);

  @override
  _FestivalsState createState() => _FestivalsState();
}

class _FestivalsState extends State<Festivals> {
  @override
  void initState() {
    super.initState();
    _fetchDataFestivals();
  }

  Map<String, dynamic> _loadedFestivals = {};

  Future<void> _fetchDataFestivals() async {
    final response = await http.get(Uri.parse(ConstStorage.API_URL + "/festival/list/limit/50/"));
    final data = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      String? cookiesString = response.headers['set-cookie'];

      if (cookiesString != null) {
        await const FlutterSecureStorage().write(key: ConstStorage.X_XSRF_TOKEN, value: RegexpTokens.getCompleteXsrf(cookiesString));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            action: SnackBarAction(
              label: '✘',
              onPressed: () {
                ScaffoldMessengerState().removeCurrentSnackBar();
              },
            ),
            content: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Les données ont bien étés récupérés !"),
            ),
            duration: const Duration(milliseconds: 500),
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          action: SnackBarAction(
            label: '✘',
            onPressed: () {
              ScaffoldMessengerState().removeCurrentSnackBar();
            },
          ),
          content: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Erreur lors de la récup des données !"),
          ),
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

    setState(() {
      _loadedFestivals = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainPersonnalizedScafold(
      title: widget.title,
      backtitle: widget.backtitle,
      displayImage: false,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _loadedFestivals.isEmpty
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
              : AdminFestivalsList(
                  title: "Festivals",
                  loadedValue: _loadedFestivals,
                ),

          const CustomNavBar(
            isHomeSelectionned: false,
            isFestivalsSelectionned: true,
            isArtistsSelectionned: false,
            isSideTitleEnabled: false,
          )
        ],
      ),
    );
  }
}
