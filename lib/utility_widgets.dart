import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class spinkit extends StatelessWidget {
  const spinkit({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.fromLTRB(50.0, height/2.5, 50.0, 50.0),
      child: const SpinKitRotatingPlain(
        size: 100.0,
        color: Colors.lightBlueAccent,
      ),
    );
  }
}



