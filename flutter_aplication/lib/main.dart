import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_aplication/roupa.dart';

import 'roupa.dart';
import 'http.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Roupas',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var roupas = [];

  _getRoupas() {
    servidor.listarRoupas().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        roupas = lista.map((model) => Roupa.fromJson(model)).toList();
      });
    });
  }

  HomePageState() {
    _getRoupas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Loja de roupas',
        style: const TextStyle(fontSize: 30),
      )),
      body: ListView.builder(
          itemCount: roupas.length,
          itemBuilder: (context, index) {
            var foto = roupas[index].foto.toString();

            return ListTile(
                leading: Image.network(
                  foto,
                  width: 100,
                  height: 300,
                ),
                title: Text(roupas[index].nome,
                    style: const TextStyle(fontSize: 25, color: Colors.black)),
                subtitle: Text(roupas[index].descricao.toString() +
                    roupas[index].medidas.toString()),
                trailing: FloatingActionButton(
                  child: Icon(Icons.add_shopping_cart),
                  onPressed:
                      null, /*() {
                      servidor.comprar(roupas[index].id).then((response) {
                        dynamic resultado = json.decode(response.body);
                        print('Resultado = ${resultado['resultado']}');
                      });
                    }*/
                ));
          }),
    );
  }
}
