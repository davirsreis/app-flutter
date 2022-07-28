import 'package:flutter/material.dart';

import '../prefs_service.dart';

// ignore: use_key_in_widget_constructors, camel_case_types
class splashPage extends StatefulWidget {
  static String routeName = '/splash';
  @override
  State<splashPage> createState() => splashPageState();
}

// ignore: camel_case_types
class splashPageState extends State<splashPage> {
  var roupas = [];

  @override
  void initState() {
    super.initState();

    Future.wait([
      PrefsService.isAuth(),
      Future.delayed(const Duration(seconds: 5)),
    ]).then((value) => value[0]
        ? Navigator.of(context)
            .pushNamedAndRemoveUntil('/homepage', (_) => true)
        : Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => true));
  }

  splashPageState() {
    initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: const Color.fromARGB(255, 14, 56, 122),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Icon(
              Icons.shop,
              color: Color.fromARGB(255, 159, 175, 202),
              size: 100.0,
            ),
          ),
        ));
  }
}
