import 'package:flutter/material.dart';
import 'package:air_quality_index/loading.dart';
import 'package:air_quality_index/home.dart';


/*
    MaterialApp() Declaration

    App has two pages, / and /home.

    / Will check for internet connection and
    make two api calls, One for PM 2.5 and one for NO2.

    The Data received is passed to /home through ModalRoute().

    /home plots the data on a LineChart.

 */

void main() {
  runApp(MaterialApp(
    title: 'Air Quality Monitor',
    initialRoute: '/',
    routes: {'/' : (context) => const Loading(),
      '/home': (context) => const Home(),
    },
  ));
}



