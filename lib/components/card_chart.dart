import 'package:flutter/material.dart';

class CardChart extends StatelessWidget {

  final String title;
  final Widget child;

  CardChart({ required this.title, required this.child });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 20), 
            width: double.infinity,
            height: 1,
            color:  Colors.black.withOpacity(.03),
          ),
          child
        ]
      ),
      margin: EdgeInsets.all(12), 
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            spreadRadius: 8.0,
            blurRadius: 8.0,
            offset: Offset(0, 0)
          )
        ],
      ),
    );
  }
}