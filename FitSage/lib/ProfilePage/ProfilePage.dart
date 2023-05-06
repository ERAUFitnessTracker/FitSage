import 'package:FitSage/ProfilePage/UserDataPrint.dart';
import 'package:FitSage/ProfilePage/UserForm.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class ProfileDataPage extends StatelessWidget {
  const ProfileDataPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'PROFILE',
          style: GoogleFonts.ubuntu(
            textStyle: const TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              color: Color(0xFFFFFFFF),
              letterSpacing: 3.0,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF99a98c),
      ),
      backgroundColor: const Color(0xFFe9e6df),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Wrap(
            runAlignment: WrapAlignment.spaceEvenly,
            children: <Widget>[
              const UserDataPrint(),
              Align(
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  tooltip: 'Back To Home',
                  backgroundColor: const Color(0xFF99a98c),
                  child: const Icon(Icons.close),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileFormPage extends StatelessWidget {
  const ProfileFormPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'PROFILE',
          style: GoogleFonts.ubuntu(
            textStyle: const TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              color: Color(0xFFFFFFFF),
              letterSpacing: 3.0,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF99a98c),
      ),
      backgroundColor: const Color(0xFFe9e6df),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                const UserForm(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    tooltip: 'Back To Home',
                    backgroundColor: const Color(0xFF99a98c),
                    child: const Icon(Icons.close),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
