import 'package:flutter/material.dart';

class loginPage extends StatefulWidget {
  @override
  State<loginPage> createState() => loginPageState();
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
}

// ignore: camel_case_types
class loginPageState extends State<loginPage> {
  get email => null;

  get senha => null;

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
                      TextField(
                        decoration: const InputDecoration(
                            label: Text('E-mail'),
                            border: OutlineInputBorder()),
                        controller: email,
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        decoration: const InputDecoration(
                            label: Text('Senha'), border: OutlineInputBorder()),
                        controller: senha,
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                child: const Text('Criar conta'),
                                onPressed: () {
                                  setState(() {
                                    try {
                                      Navigator.pushReplacementNamed(
                                          context, '/cadastro');
                                    } catch (e) {}
                                  });
                                }),
                            const SizedBox(width: 10),
                            ElevatedButton(
                                child: const Text('Logar'),
                                onPressed: () {
                                  setState(() {
                                    try {
                                      Navigator.pushReplacementNamed(
                                          context, '/');
                                    } catch (e) {}
                                  });
                                }),
                          ])
                    ]))),
      ),
    );
  }
}
