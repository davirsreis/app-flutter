// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_aplication/roupa.dart';

import '../roupa.dart';
import '../http.dart';

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
        ),
      ),
      body: ListView.builder(
          itemCount: roupas.length,
          itemBuilder: (context, i) {
            var foto = roupas[i].foto;

            return ListTile(
                leading: SizedBox(
                  width: 100.0,
                  height: 300.0,
                  child: Image.network(
                    foto,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
                title: Text(
                    "${roupas[i].descricao} Tamanho: ${roupas[i].medidas}",
                    style: const TextStyle(fontSize: 20, color: Colors.black)),
                subtitle: Text("Valor: ${roupas[i].valor}",
                    style: const TextStyle(fontSize: 15, color: Colors.green)),
                trailing: FloatingActionButton(
                    child: const Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      // ignore: avoid_print
                      print("Id produto: ${roupas[i].id}");
                      servidor.comprar(roupas[i].id).then((response) {
                        //dynamic resultado = json.decode(response.body);
                        //print('Resultado = ${resultado['resultado']}');
                      });
                    }));
          }),
    );
  }
}
