import 'package:flutter/material.dart';
import 'user.dart';
import 'DatabaseHelper.dart';
import 'UserForm.dart';
//test file for other file
class WhiteBoxForData extends StatefulWidget {
  const WhiteBoxForData({super.key});


  @override
  _WhiteBoxForDataState createState() => _WhiteBoxForDataState();
}

class _WhiteBoxForDataState extends State<WhiteBoxForData> {
  final TextStyle infoStyle = const TextStyle(
    fontFamily: ".SF UI Display",
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    color: Color(0xFF3e2723),
    letterSpacing: 1.0,
  );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 580,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: const <Widget>[
            DatabaseCheck(),
          ],
        ),
      ),
    );
  }
}

