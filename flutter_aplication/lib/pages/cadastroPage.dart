// ignore_for_file: prefer_interpolation_to_compose_strings
import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_aplication/http.dart';
import 'package:flutter_aplication/pages/homePage.dart';
import 'package:flutter_aplication/models/user.dart';
import '../prefs_service.dart';

class cadastroPage extends StatefulWidget {
  static String routeName = '/cadastro';
  State<cadastroPage> createState() => cadastroPageState();
}

// ignore: camel_case_types
class cadastroPageState extends State<cadastroPage> {
  var users = [];
  String nome = '';
  String email = '';
  String endereco = '';
  String senha = '';
  String senhaConfirm = '';

  _postUser() {
    servidor.cadastrarUsuario(nome, email, endereco, senha).then((response) {
      var jsonData =
          '{"nome": "$nome", "email": "$email", "endereco": "$endereco", "senha": "$senha"}';
      var parsedJson = json.decode(jsonData);
      print('${parsedJson.runtimeType} : $parsedJson');

      var nomee = parsedJson['nome'];
      var emaill = parsedJson['email'];
      print('$nomee e $emaill');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 159, 175, 202),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 14, 56, 122),
        title: const Text(
          'Cadastro',
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
                      const Text('Preencha com suas informações:',
                          style: TextStyle(fontSize: 20)),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                            label: Text(
                              'Nome',
                              style: TextStyle(color: Colors.black),
                            ),
                            border: OutlineInputBorder()),
                        onChanged: (nome) => setState(() => this.nome = nome),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                            label: Text(
                              'E-mail',
                              style: TextStyle(color: Colors.black),
                            ),
                            border: OutlineInputBorder()),
                        onChanged: (email) =>
                            setState(() => this.email = email),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                            label: Text(
                              'Endereço',
                              style: TextStyle(color: Colors.black),
                            ),
                            border: OutlineInputBorder()),
                        onChanged: (endereco) =>
                            setState(() => this.endereco = endereco),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                            label: Text(
                              'Senha',
                              style: TextStyle(color: Colors.black),
                            ),
                            border: OutlineInputBorder()),
                        obscureText: true,
                        onChanged: (senha) =>
                            setState(() => this.senha = senha),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                            label: Text(
                              'Confirme a sua senha',
                              style: TextStyle(color: Colors.black),
                            ),
                            border: OutlineInputBorder()),
                        onChanged: (senhaConfirm) =>
                            setState(() => this.senhaConfirm = senhaConfirm),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              child: const Text('Já tenho conta'),
                              onPressed: () {
                                setState(() {
                                  try {
                                    Navigator.pushReplacementNamed(
                                        context, '/login');
                                  } catch (e) {}
                                });
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(255, 14, 56, 122)),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              child: const Text('Criar conta'),
                              onPressed: () {
                                setState(() {
                                  try {
                                    if (senha == senhaConfirm) {
                                      _postUser();
                                      PrefsService.save(email);
                                      Timer(Duration(seconds: 2), () {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                '/homepage',
                                                (Route<dynamic> route) =>
                                                    false);
                                      });
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return const AlertDialog(
                                              backgroundColor: Color.fromARGB(
                                                  255, 159, 175, 202),
                                              title: Text(
                                                'Atenção',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              content:
                                                  Text('Senhas não coincidem'),
                                            );
                                          });
                                    }
                                  } catch (e) {
                                    print('error');
                                  }
                                });
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(255, 14, 56, 122)),
                              ),
                            ),
                          ])
                    ]))),
      ),
    );
  }
}
