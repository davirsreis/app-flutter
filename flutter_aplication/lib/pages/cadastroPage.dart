// ignore_for_file: prefer_interpolation_to_compose_strings
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_aplication/http.dart';
import 'package:flutter_aplication/pages/homePage.dart';
import 'package:flutter_aplication/user.dart';
//import 'package:servidor/db.js';


class cadastroPage extends StatefulWidget{
  static String routeName = '/cadastro';
  State<cadastroPage> createState() => cadastroPageState();
}


// ignore: camel_case_types
class cadastroPageState extends State<cadastroPage> {
  var users = [];
  String nome = '';
  String email = '';
  String senha = '';
  String senhaConfirm = '';

_postUser() {
    servidor.cadastrarUsuario(nome, email, senha).then((response) { 
    var jsonData = '{"nome": "$nome", "email": "$email", "senha": "$senha"}';
    var parsedJson = json.decode(jsonData);
    print('${parsedJson.runtimeType} : $parsedJson');

    var nomee = parsedJson['nome'];
    var emaill = parsedJson['email'];
    print('$nomee e $emaill');
    //dynamic resultado = json.decode(response.body);

    // ignore: avoid_print
  //print('Resultado = ${resultado['resultado']}');
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      const Text('Preencha as com as suas informações:',
                          style: TextStyle(fontSize: 20)),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                            label: Text('Nome'), border: OutlineInputBorder()),
                            //@Operation.post()
                            //Future<Response> createNewRead() async {
                            //  return Response.nome;
                            //}
                        onChanged: (nome) => setState(() => this.nome = nome),
                      ),
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
                      TextFormField(
                        decoration: const InputDecoration(
                            label: Text('Confirme a sua senha'),
                            border: OutlineInputBorder()),
                        onChanged: (senhaConfirm) => setState(() => this.senhaConfirm = senhaConfirm),
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
                                }),
                            const SizedBox(width: 10),
                            ElevatedButton(
                                child: const Text('Criar conta'),
                                onPressed: () {
                                  setState(() {
                                    try{

                                      _postUser();
                                      
                                      
                                      
                                    } catch(e) {print('error'); }
                                  });
                                  

                                    // _postNovoUsuario() async {
                                    //   servidor.cadastrarUsuario(nome, email, senha).then((response) {
                                    //   // ignore: avoid_print
                                    //   print(response);
                                    //   // ignore: void_checks
                                    //   if (response.status == 200) { return response.json();}
  
                                    //   });
                                    // }
                                    // _postNovoUsuario();


                                    // ignore: unused_element
                                    //insertCustomer(data) async {
                                      //const sql = r'INSERT INTO usuarios(nome,email,senha) VALUES ($1,$2,$3);';
                                      //const values = [data.nome, data.email, data.senha];
                                      //return await client.query(sql, values);
                                    //}

                                    
                                  // setState(() {
                                  //   try {
                                  //    if (senha == senhaConfirm) {
                                  //       print(senha);
                                  //       print(senhaConfirm);
                                  //       print('entrou aqui no if');
                                  //       Navigator.popAndPushNamed(context, '/');
                                  //     } else {
                                  //       print('entrou aqui no else');
                                  //       AlertDialog(
                                  //          title: const Text(
                                  //               'Senhas não coincidem'),
                                  //           content: SingleChildScrollView(
                                  //               child: ElevatedButton(
                                  //                   child: const Text('Ok'),
                                  //                   onPressed: () {
                                  //                     Navigator.of(context)
                                  //                         .pop();
                                  //                   })));
                                  //     }
                                  //   } catch (e) {
                                  //     print(senha);
                                  //     print(senhaConfirm);
                                  //     print('error');
                                  //   }
                                  // });
                                }),
                          ])
                    ]))),
      ),
    );
  }
}
