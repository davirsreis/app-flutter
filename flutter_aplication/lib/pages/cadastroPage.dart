import 'package:flutter/material.dart';


class cadastroPage extends StatefulWidget{

  State<cadastroPage> createState() => cadastroPageState();
  TextEditingController nome = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  TextEditingController senhaConfirm = TextEditingController();

}


// ignore: camel_case_types
class cadastroPageState extends State<cadastroPage> {
  get nome => null;
  get email => null;
  get senha => null;
  get senhaConfirm => null;

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
                      TextField(
                        decoration: const InputDecoration(
                            label: Text('Nome'), border: OutlineInputBorder()),
                        controller: nome,
                      ),
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
                      TextField(
                        decoration: const InputDecoration(
                            label: Text('Confirme a sua senha'),
                            border: OutlineInputBorder()),
                        controller: senhaConfirm,
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
                                    try {
                                      if (senha == senhaConfirm) {
                                        print(senha);
                                        print(senhaConfirm);
                                        print('entrou aqui no if');
                                        Navigator.popAndPushNamed(context, '/');
                                      } else {
                                        print('entrou aqui no else');
                                        AlertDialog(
                                            title: const Text(
                                                'Senhas não coincidem'),
                                            content: SingleChildScrollView(
                                                child: ElevatedButton(
                                                    child: const Text('Ok'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    })));
                                      }
                                    } catch (e) {
                                      print(senha);
                                      print(senhaConfirm);
                                      print('error');
                                    }
                                  });
                                }),
                          ])
                    ]))),
      ),
    );
  }
}
