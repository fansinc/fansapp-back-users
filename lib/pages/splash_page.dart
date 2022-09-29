import '/pages/email_auth_page.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

//import 'dart:async';
import '../config/app_config.dart';

//import './home_page.dart';
//import '../pages/auth_page.dart';

import '../providers/auth_provider.dart';
import 'home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    /* Timer(Duration(seconds: 1), () {
      //Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      Navigator.of(context).pushReplacementNamed(AuthPage.routeName);
    }); */
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: (Scaffold(
          body: FutureBuilder(
              future: AuthProvider().autoLogin(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  //print(snapshot.data);
                  return snapshot.hasData
                      ? const HomePage()
                      : const EmailAuthPage();
                  //AuthPage();
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Scaffold(
                      backgroundColor: const Color(AppConfig.blackColor),
                      //Colors.black,
                      body: Center(
                          child: Image.asset(
                        AppConfig.splashImage,
                      )
                          //child: Image.asset(AppConfig.logoImage),
                          ));
                } else {
                  return const EmailAuthPage();
                  //return const AuthPage();
                }
              })
          /* Center(
          child: Image.asset(AppConfig.splashImage),
        ), */
          )),
    );
  }
}
