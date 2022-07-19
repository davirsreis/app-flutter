import 'package:flutter/material.dart';
import 'package:flutter_aplication/route.dart';

import '../utils/user.simple.preferences.dart';

class loginPage extends StatefulWidget {
  static String routeName = '/login';
  @override
  State<loginPage> createState() => loginPageState();
}

// ignore: camel_case_types
class loginPageState extends State<loginPage> {
  String senha = '';
  String email = '';
  
  void initState() {
    super.initState();

    String userEmail = UserSimplePreferences.getUseremail() ?? '';
    String usersenha = UserSimplePreferences.getUsersenha() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
            child: Container(
                width: 400,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Insira o seu e-mail e a sua senha',
                          style: TextStyle(fontSize: 20)),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                            label: Text('E-mail'),
                            border: OutlineInputBorder()),
                        onChanged: (email) => setState(() => this.email = email),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                            label: Text('Senha'), border: OutlineInputBorder()),
                        obscureText: true,
                        onChanged: (senha) => setState(() => this.senha = senha),
                      ),
                      const SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                child: const Text('Criar conta'),
                                onPressed: () async {
                                  setState(() {
                                    try {

                                      Navigator.pushNamedAndRemoveUntil(
                                          context, '/cadastro', (route) => false);
                                    } catch (e) {}
                                  });
                                }),
                            const SizedBox(width: 10),
                            ElevatedButton(
                                child: const Text('Logar'),
                                onPressed: () async {
                                  setState(() {
                                    try {
                                      UserSimplePreferences.setUseremail(email);
                                      UserSimplePreferences.setUsersenha(senha);
                                      // ignore: avoid_print
                                      print(email);
                                      // ignore: avoid_print
                                      print(senha);
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, '/homepage', (route) => false);
                                    } catch (e) {}
                                  });
                                }),
                          ])
                    ]))),
      ),
    );
  }
}