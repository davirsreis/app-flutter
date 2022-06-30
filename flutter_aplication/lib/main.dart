import 'dart:convert';
import 'dart:developer';

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
        style: TextStyle(fontSize: 30),
      )),
      body: ListView.builder(
          itemCount: roupas.length,
          itemBuilder: (context, index) {
            var foto = roupas[index].foto.toString();

            return ListTile(
                leading: Image.network(
                  foto,
                  width: 100,
                  height: 100,
                  fit: BoxFit.fitHeight,
                ),
                title: Text(
                    "${roupas[index].descricao} Tamanho: ${roupas[index].medidas}",
                    style: const TextStyle(fontSize: 20, color: Colors.black)),
                subtitle: Text("Valor: ${roupas[index].valor}",
                    style: const TextStyle(fontSize: 15, color: Colors.green)),
                trailing: FloatingActionButton(
                    child: const Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      servidor.comprar(roupas[index].id).then((response) {
                        dynamic resultado = json.decode(response.body);
                        print('Resultado = ${resultado['resultado']}');
                      });
                    }));
          }),
    );
  }
}
