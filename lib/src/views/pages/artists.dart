import 'dart:convert';

import 'package:festix_app_admin/src/const/const_storage.dart';
import 'package:festix_app_admin/src/utils/regexp.dart';
import 'package:festix_app_admin/src/views/components/admin/admin_artists_list.dart';
import 'package:festix_app_admin/src/views/components/background_custom.dart';
import 'package:festix_app_admin/src/views/components/card/snack_bar_custom.dart';
import 'package:festix_app_admin/src/views/components/navbar/navigation_bar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Artists extends StatefulWidget {
  final String title;
  final String backtitle;

  const Artists(this.title, {Key? key, required this.backtitle}) : super(key: key);

  @override
  _ArtistsState createState() => _ArtistsState();
}

class _ArtistsState extends State<Artists> {
  @override
  void initState() {
    super.initState();
    _fetchDataArtists();
  }

  Map<String, dynamic> _loadedArtists = {};

  Future<void> _fetchDataArtists() async {
    final response = await http.get(Uri.parse(ConstStorage.API_URL + "/artist/list/"));
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
      _loadedArtists = data;
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
          _loadedArtists.isEmpty
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
              : AdminArtistsList(
            title: "Artists",
            loadedValue: _loadedArtists,
          ),

          const CustomNavBar(
            isHomeSelectionned: false,
            isArtistsSelectionned: true,
            isFestivalsSelectionned: false,
            isSideTitleEnabled: false,
          )
        ],
      ),
    );
  }
}
