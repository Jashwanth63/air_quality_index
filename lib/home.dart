import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:info_widget/info_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String date = 'Apr 1, 2023';
  Map pm25 = {};
  Map no2 = {};
  List<String> Months = <String>["Apr", "May", "Jun"];
  String? def_month = "Apr";
  int? def_date = 1;
  late double multiplier; //For Y-Axis Value Correction

  void make_date() {
    date = "$def_month $def_date, ${2023}";
  }

  List<int> get_days(String? month) {
    var dates;
    if(month == "Apr" || month == "Jun"){
      dates = [for (int i=1; i<=30; i++) i];
    }
    else{
      dates = [for (int i=1; i<=31; i++) i];
    }
    return dates;
  }


  List get_list(Map pol){
    List? x = pol[date];
    return x ?? [];
  }
  
  double return_max(List values){
    
    double max = -10.0;
    for(int i=0; i<values.length; i++){
      if(max < values[i]){
        max = values[i];
      }
    }
    multiplier = (max / 8);
    return (max+multiplier).floorToDouble();
  }

  List<FlSpot> SpotList(List l){
    double hour = 00.00;
    List<FlSpot> spots = <FlSpot>[];
    l.forEach((element) {
      spots.add(FlSpot(hour, element));
      hour++;
      
    });
    return spots;
  }

  String ret_hour(dynamic value){
    String hour = '';
    switch(value.toInt()){
      case 0:
        hour = "00:00";
        break;
      case 1:
        hour = "01:00";
        break;
      case 2:
        hour = "02:00";
        break;
      case 3:
        hour = "03:00";
        break;
      case 4:
        hour = "04:00";
        break;
      case 5:
        hour = "05:00";
        break;
      case 6:
        hour = "06:00";
        break;
      case 7:
        hour = "07:00";
        break;
      case 8:
        hour = "08:00";
        break;
      case 9:
        hour = "09:00";
        break;
      case 10:
        hour = "10:00";
        break;
      case 11:
        hour = "11:00";
        break;
      case 12:
        hour = "12:00";
        break;
      case 13:
        hour = "13:00";
        break;
      case 14:
        hour = "14:00";
        break;
      case 15:
        hour = "15:00";
        break;
      case 16:
        hour = "16:00";
        break;
      case 17:
        hour = "17:00";
        break;
      case 18:
        hour = "18:00";
        break;
      case 19:
        hour = "19:00";
        break;
      case 20:
        hour = "20:00";
        break;
      case 21:
        hour = "21:00";
        break;
      case 22:
        hour = "22:00";
        break;
      case 23:
        hour = "23:00";
        break;
    }
    return hour;
  }

  SideTitles get _calc_bottom => SideTitles(
    showTitles: true,
    interval: 5.0,
    getTitlesWidget: (value, meta) {
      String hr = ret_hour(value);
      if(hr == "23:00"){
        hr = "";
      }
      return Padding(
        padding: const EdgeInsets.only(top:7.5),
        child: Text(hr),
      );
    }

  );

  String ret_val(dynamic y){
    if (y==-1) {
      return "No Data";
    }
    else{
      return "$y µg/m³";
    }
  }

  @override
  Widget build(BuildContext context) {
    Map vals = ModalRoute.of(context)!.settings.arguments as Map;
    pm25 = vals["pm25"];
    no2 = vals["no2"];
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 50.0,
            width: 50.0,
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 15.0),
            child: Text(
              "South Kensington Underground Station",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 1.5, 10.0, 1.5),
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        blurRadius: 5,
                      ),
                    ],
                    color: Colors.white54,
                  ),
                  child: DropdownButton<String>(
                    value: def_month,
                    items: Months.map((e) =>
                      DropdownMenuItem(
                          value: e,
                          child: Text(e),
                      )
                  ).toList(),
                      onChanged: (String? val) {
                        setState(() {
                          def_month = val;
                        });
                      },
                  ),
                ),
              ),
              DecoratedBox(
              decoration: const BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    blurRadius: 5,
                  ),
                ],
                color: Colors.white54,
              ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 1.5, 10.0, 1.5),
                  child: DropdownButton(
                      value: def_date,
                      items: get_days(def_month).map((e) =>
                      DropdownMenuItem(
                        value: e,
                        child: Text("$e"),
                      ),
                  ).toList(),
                      onChanged: (int? date) {
                        setState(() {
                          def_date = date;
                        });
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 1.5, 10.0, 1.5),
                child: ElevatedButton(onPressed: () {
                  setState(() {
                    make_date();
                  });
                },
                    child: const Text(
                      "GO",
                    ),
                ),
              )
            ],
          ),
          const SizedBox(
            width: 50.0,
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "PM 2.5"
              ),
            Container(
              padding: const EdgeInsets.only(left:5.0),
              child: InfoWidget(infoText: "Particulate Matter 2.5 (PM2.5), "
                  "refers to tiny particles or droplets in the air that are two and one half microns"
                  " or less in width.",
                  iconData: Icons.info,
                  iconColor: Colors.black26),
            )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left:5.0, top: 10.0, right:10.0),
            constraints: BoxConstraints(
              maxWidth: width - 18.0,
              maxHeight: 200.0,
            ),
            //alignment: Alignment.center,
            child: AspectRatio(
              aspectRatio: 5.6/3,
              child: LineChart(
                 LineChartData(
                  minX: 00.00,
                   maxX: 23.00,
                   minY: 0.0,
                   maxY:  return_max(get_list(pm25)) ,
                   lineBarsData: [
                     LineChartBarData(
                       spots: SpotList(get_list(pm25)),
                     ),
                   ],
                   borderData: FlBorderData(
                     show: true,
                   ),
                   titlesData: FlTitlesData(
                     bottomTitles: AxisTitles(

                       sideTitles: _calc_bottom,
                     ),
                     rightTitles: const AxisTitles(
                       sideTitles: SideTitles(),
                     ),
                     topTitles: const AxisTitles(
                       sideTitles: SideTitles(),
                     ),
                     leftTitles: AxisTitles(

                       sideTitles: SideTitles(
                         showTitles: true,
                         interval: (multiplier+1.0).floorToDouble(),
                         reservedSize: 25.0,
                       ),
                     ),

                   ),
                   lineTouchData: LineTouchData(
                     touchTooltipData: LineTouchTooltipData(
                       fitInsideHorizontally: true,
                       tooltipPadding: const EdgeInsets.symmetric(
                         vertical:5.0,
                        horizontal: 8.0,
                       ),
                       getTooltipItems: (x) {
                         return x.map((e) =>
                            LineTooltipItem(
                                "Time - ${ret_hour(e.spotIndex)}\n"
                                    "${ret_val(e.bar.spots[e.spotIndex].y)}",
                                const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                )),

                         ).toList();
                       },
                     ),
                   ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 50.0,
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "NITROGEN DIOXIDE"
              ),
              Container(
                padding: const EdgeInsets.only(left:5.0),
                child: InfoWidget(
                    infoText: "Nitrogen dioxide, or NO2, is a gaseous air pollutant "
                        "composed of nitrogen and oxygen and is one of a group of related gases "
                        "called nitrogen oxides, or NOx. NO2 forms when fossil fuels such as "
                        "coal, oil, gas or diesel are burned at high temperatures.",
                    iconData: Icons.info,
                    iconColor: Colors.black26
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left:5.0, top: 10.0, right:10.0),
            constraints: BoxConstraints(
              maxWidth: width - 18.0,
              maxHeight: 300.0,
            ),
            child: AspectRatio(
                aspectRatio: 5.5/3,
                child: LineChart(
                    LineChartData(
                      minX: 00.00,
                      maxX: 23.00,
                      minY: 0.0,
                      maxY:  return_max(get_list(no2)),
                      lineBarsData: [
                        LineChartBarData(
                          //spots: SpotList([5.5,4.4]),
                          spots: SpotList(get_list(no2)),
                        ),
                      ],
                      borderData: FlBorderData(
                        show: true,
                      ),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: _calc_bottom,
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: (multiplier+1.0).floorToDouble(),
                            reservedSize: 40.0,
                          ),
                        ),
                      ),
                        lineTouchData: LineTouchData(
                          touchTooltipData: LineTouchTooltipData(
                            fitInsideHorizontally: true,
                            tooltipPadding: const EdgeInsets.symmetric(
                              vertical:5.0,
                              horizontal: 8.0,
                            ),
                            getTooltipItems: (x) {
                              return x.map((e) =>
                                  LineTooltipItem(
                                      "Time - ${ret_hour(e.spotIndex)}\n"
                                          "${ret_val(e.bar.spots[e.spotIndex].y)}",
                                      const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500,
                                      )),

                              ).toList();
                            },
                          ),
                        )
                    )
                )
            ),
          )
        ],
      ),

    );
  }
}
