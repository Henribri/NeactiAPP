import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("HEEEEY");
    return Container(
      color: Colors.white,
      child: SpinKitSquareCircle(
        color: Colors.redAccent[400],
        size: 50.0,
      ),
    );
  }
}
