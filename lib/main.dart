import 'package:flutter/material.dart';
import 'package:air_quality_index/loading.dart';
import 'package:air_quality_index/home.dart';
import 'package:air_quality_index/utility_widgets.dart';

void main() {
  runApp(MaterialApp(
    title: 'Air Quality Monitor',
    initialRoute: '/',
    routes: {'/' : (context) => const Loading(),
      '/home': (context) => const Home(),
    },
  ));
}



