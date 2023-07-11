import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

abstract class pollutant {
  final String api_key = "a6f0e20a-b753-11ec-b909-0242ac120002";
  final String site_code = "CLDP0098";
  final String? StartDate = "01 Apr 2023";
  final String? EndDate = "30 Jun 2023";
  final String averaging = "Hourly";
  late String? Species;
  late String url;


  pollutant({this.Species}) {
    url = "https://api.breathelondon.org/api/getClarityData/$site_code/$Species/Sat 01 Apr 2023 00:00:00 GMT/Fri 30 Jun 2023 23:59:59 GMT/$averaging?key=$api_key";
  }

  Future<Map<String, List<double>?>> make_request() async{
    Map<String, List<double>?> pol = {};
    try{
      Response r1 = await get(Uri.parse(url));
      List data = jsonDecode(r1.body);
      pol = make_map(data);
    }
    catch(e){
      print(e.toString());
    }

    return pol;
  }

  Map<String, List<double>?> make_map(List data) {
    Map<String, List<double>?> info = {};
    DateTime d;
    DateFormat fmt = DateFormat.yMMMd();
    for (int i = 0; i < data.length; i++) {
      d = DateTime.parse(data[i]['DateTime']);
      info[fmt.format(d)] = [];
    }
    int hour_counter = 0;

    for (int i = 0; i < data.length; i++) {
      d = DateTime.parse(data[i]['DateTime']);
      if (d.hour == 0) {
        hour_counter = 0;
      }
      double val = double.parse((data[i]['ScaledValue']).toStringAsFixed(2));
      if (d.hour == hour_counter) {
        info[fmt.format(d)]?.add(val);
        hour_counter++;
      }
      else {
        for (hour_counter; hour_counter < d.hour; hour_counter++) {
          info[fmt.format(d)]?.add(-1.00);
        }
        info[fmt.format(d)]?.add(val);
        hour_counter++;
      }
    }
    return info;
  }

  List<double>? ret_list(String date, Map values){
    return values[date];
  }
}


class PM_25 extends pollutant {
  //Map PM25 = {};
  PM_25():super(Species: "IPM25");



}

class NO_2 extends pollutant {
  //Map NO2 = {};
  NO_2():super(Species: "INO2");

}

