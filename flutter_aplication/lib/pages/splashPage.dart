import 'package:flutter/material.dart';
import 'package:flutter_aplication/route.dart';

import '../prefs_service.dart';

class splashPage extends StatefulWidget {
  static String routeName = '/splash';
  @override
  State<splashPage> createState() => splashPageState();
}

class splashPageState extends State<splashPage> {
  var roupas = [];
  
  //late Map<String, String> usrdata;
  // get userEmail => UserSimplePreferences.getUseremail();
  // get userSenha => UserSimplePreferences.getUsersenha();

  @override
  void initState() {
    super.initState();

    Future.wait([
      PrefsService.isAuth(),
      Future.delayed(Duration(seconds: 5)),
    ]).then((value) => value[0]
    ? Navigator.of(context).pushNamedAndRemoveUntil('/homepage', (_) => true)
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