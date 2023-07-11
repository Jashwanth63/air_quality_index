import 'package:flutter/material.dart';
import 'package:air_quality_index/req_res.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:air_quality_index/utility_widgets.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  pollutant p1 = PM_25();
  pollutant p2 = NO_2();

  Map pm25 = {};
  Map no2 = {};
  bool result = true;
  void set_up_json() async {
    result = await InternetConnectionChecker().hasConnection;

    if (result) {
      pm25=  await p1.make_request();

      no2  = await p2.make_request();
    }

    Future.delayed(Duration(seconds: 3), (){
      if(result) {
        Navigator.pushReplacementNamed(context, '/home', arguments: {
          "pm25": pm25,
          "no2": no2
        });
      }
    });



    //print(pm25[date]);

  }



  @override
  void initState() {
    super.initState();
    set_up_json();

  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Widget loader = result? spinkit(): SizedBox(
      height: 50.0,
    );

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 22.0,
            width: width,
          ),
          Visibility(
              visible: !result,
              child: Container(
                height: 20,
                width: width,
                color: Colors.red,
                child: const Center(
                  child: Text("No Internet Connection",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ),

          loader,
        Visibility(
          visible: !result,
            child: TextButton(
              child: const Text(
                "Try Again",
            ),
              onPressed: () {
                setState(() {
                  set_up_json();
                });
              },
            ),

        ),
        ],
      ),
    );
  }
}


