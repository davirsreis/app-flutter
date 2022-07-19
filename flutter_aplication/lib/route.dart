import 'package:flutter_aplication/pages/cadastroPage.dart';
import 'package:flutter_aplication/pages/loginPage.dart';
import 'package:flutter_aplication/pages/homePage.dart';

var routes = {
  // ignore: prefer_const_constructors
  loginPage.routeName: (context) => loginPage(),
  // ignore: prefer_const_constructors
  cadastroPage.routeName: (context) => cadastroPage(),
  HomePage.routeName: (context) => HomePage()
};
