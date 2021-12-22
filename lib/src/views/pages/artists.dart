import 'package:festix_app_admin/src/views/components/background_custom.dart';
import 'package:festix_app_admin/src/views/components/card/event/event_day_list.dart';
import 'package:festix_app_admin/src/views/components/navbar/navigation_bar_custom.dart';
import 'package:flutter/material.dart';

class Artists extends StatelessWidget {
  final String title;
  final String backtitle;
  const Artists( this.title, {Key? key, required this.backtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPersonnalizedScafold(
      title: title,
      backtitle: backtitle,
      displayImage: false,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          // EventDayList(),
          CustomNavBar(
            isHomeSelectionned: false,
            isFestivalsSelectionned: false,
            isArtistsSelectionned: true,
            isSideTitleEnabled: false,
          )
        ],
      ),
    );
  }
}
