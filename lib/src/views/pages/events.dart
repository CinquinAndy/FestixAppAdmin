import 'package:festix_app_admin/src/views/components/background_custom.dart';
import 'package:festix_app_admin/src/views/components/card/event/event_day_list.dart';
import 'package:festix_app_admin/src/views/components/navbar/navigation_bar_custom.dart';
import 'package:flutter/material.dart';

import '../../../box_ui.dart';

class Events extends StatelessWidget {
  final String title;
  final String backtitle;

  const Events(this.title,{Key? key, required this.backtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPersonnalizedScafold(
      title: title,
      backtitle: backtitle,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          EventDayList(
            date: "03.12.21.",
            listEvent: <String,String>{},
          ),
          CustomNavBar(
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
