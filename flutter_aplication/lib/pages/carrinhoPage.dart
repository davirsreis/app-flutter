// ignore_for_file: file_names
import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_aplication/models/compras.dart';
import 'package:flutter_aplication/pages/loginPage.dart';

import '../prefs_service.dart';
import '../models/roupa.dart';
import '../http.dart';

class CarrinhoPage extends StatefulWidget {
  static String routeName = '/carrinho';
  @override
  State<CarrinhoPage> createState() => CarrinhoPageState();

}


class CarrinhoPageState extends State<CarrinhoPage> {
  var itens = [];
  // var roupas = [];
  // int j = 0;

    _getItens() {
    servidor.listarCarrinho().then((response) {
      if (mounted) {
        setState(() {
        Iterable lista = json.decode(response.body);
        itens = lista.map((model) => Item.fromJson(model)).toList();
      });
      }
      
    });
  }

  // void initState() {
  //   super.initState();
  //    Timer(Duration(seconds: 60), () => setState((){}));
  // }

  // _getRoupas() {
  //   servidor.listarRoupas().then((response) {
  //     if (mounted) {
  //       setState(() {
  //       Iterable lista = json.decode(response.body);
  //       roupas = lista.map((model) => Roupa.fromJson(model)).toList();
  //     });
  //     }
      
  //   });
  // }

Future sleep1() {
  return Future.delayed(const Duration(seconds: 3), () => "3");
}

  CarrinhoPageState() {  
    _getItens();
    // _getRoupas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Carrinho',
          style: TextStyle(fontSize: 30),
        ),
        actions: [IconButton(onPressed: () => {
          PrefsService.logout(),
          Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => true)
        }, icon: Icon(Icons.logout),)]
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: itens.length,
        itemBuilder: (context, i) {
          //var foto = itens[i].foto;
          return ListTile(

            //key: ValueKey(itens[i]),
            //leading: Image.network(foto,),
            title: Text("${itens[i].descricao}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text("Valor: ${itens[i].valor.toString()}",
              style: const TextStyle(fontSize: 15, color: Colors.green, fontWeight: FontWeight.bold)),
            trailing: FloatingActionButton(
              backgroundColor: Colors.white,
              hoverColor: Colors.red,
              child: const Icon(
                Icons.remove_shopping_cart,
                color: Colors.black),
              onPressed: () { 

                var desc = itens[i].descricao;
                servidor.removerCarrinho(desc).then((response) {
                
                var jsonData = '{"descricao": "$desc"';
                var parsedJson = json.decode(jsonData);
                initState();
                //print('${parsedJson.runtimeType} : $parsedJson');
                });

                },
            )
          );
        },
      ),
    );
  }
          
}
