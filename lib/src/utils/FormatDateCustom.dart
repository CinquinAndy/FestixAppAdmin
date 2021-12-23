abstract class DateFormatCustom{
  static String dateFormatDay(DateTime dateTime){
    return "${dateTime.year}-${dateTime.month}-${dateTime.day}";
  }
  static String dateFormatDayHourCustom(DateTime dateTime){
    return "${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}";
  }
  static String dateFormatHourMinutesCustom(DateTime dateTime){
    return "${dateTime.hour}:${dateTime.minute}";
  }
}