import 'package:flutter/material.dart';
import 'package:flutter_aplication/http.dart';
import '../prefs_service.dart';
import 'dart:convert';

import '../models/user.dart';

// ignore: use_key_in_widget_constructors, camel_case_types
class loginPage extends StatefulWidget {
  static String routeName = '/login';
  @override
  State<loginPage> createState() => loginPageState();
}

// ignore: camel_case_types
class loginPageState extends State<loginPage> {
  late Map<String, String> usrdata;
  String email = '';
  String senha = '';
  int isAuth = 0;

  var usuarios = [];

  _getUsuarios() {
    servidor.listarUsuarios().then((response) {
      if (mounted) {
        setState(() {
          Iterable lista = json.decode(response.body);
          usuarios = lista.map((model) => User.fromJson(model)).toList();
        });
      }
    });
  }

  loginPageState() {
    _getUsuarios();
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
                        onChanged: (email) =>
                            setState(() => this.email = email),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                            label: Text('Senha'), border: OutlineInputBorder()),
                        obscureText: true,
                        onChanged: (senha) =>
                            setState(() => this.senha = senha),
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
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          '/cadastro', (route) => false);
                                    } catch (e) {
                                      print(e);
                                    }
                                  });
                                }),
                            const SizedBox(width: 10),
                            ElevatedButton(
                                child: const Text('Logar'),
                                onPressed: () async {
                                  var qtd = usuarios.length;
                                  setState(() {
                                    try {
                                      for (var i = 1; i < qtd; i++) {
                                        if (email == usuarios[i].email &&
                                            senha == usuarios[i].senha) {
                                          //print('usuario encontrado');
                                          isAuth = 1;
                                        } else {
                                          //print('usuario não encontrado');
                                        }
                                      }
                                      if (isAuth == 1) {
                                        //print('autorizado');
                                        PrefsService.save(email);
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                '/homepage',
                                                (Route<dynamic> route) =>
                                                    false);
                                      } else {
                                        //print('nao autorizado');
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const AlertDialog(
                                                title: Text('Atenção'),
                                                content: Text(
                                                    'Não foi possível realizar o seu login, verefique os dados informados e tente novamente!'),
                                              );
                                            });
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  });
                                }),
                          ])
                    ]))),
      ),
    );
  }
}
