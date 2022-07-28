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
        backgroundColor: Colors.red,
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Icon(
              Icons.shop,
              color: Colors.white,
              size: 100.0,
            ),
          ),
        ));
  }
}
