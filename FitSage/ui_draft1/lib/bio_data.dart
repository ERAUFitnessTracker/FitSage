import 'package:flutter/material.dart';

//test file for other files
class WhiteBoxForData extends StatelessWidget {
  const WhiteBoxForData({
    super.key,
  });

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
        child: Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    'Name',
                    textAlign: TextAlign.center,
                    style: infoStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    'Weight',
                    textAlign: TextAlign.center,
                    style: infoStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    'Height',
                    textAlign: TextAlign.center,
                    style: infoStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    'Body Mass Index (BMI)',
                    textAlign: TextAlign.center,
                    style: infoStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
