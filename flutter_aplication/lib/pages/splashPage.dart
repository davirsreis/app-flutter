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

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Carregando...',
          style: TextStyle(fontSize: 30),
        ),
      ),
      backgroundColor: Colors.red,
    );
  }

}