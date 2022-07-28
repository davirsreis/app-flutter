import 'package:flutter_aplication/http.dart';

class Item {
  int? id;
  String? nome;
  String? descricao;
  String? foto;
  String? tamanho;
  String? quantidade;
  String? cor;
  String? valor;

  Item(
      {this.id,
      this.nome,
      this.descricao,
      this.foto,
      this.tamanho,
      this.quantidade,
      this.valor});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    descricao = json['descricao'];
    foto = json['foto'];
    tamanho = json['tamanho'];
    quantidade = json['quantidade'];
    cor = json['cor'];
    valor = json['valor'];
  }
}
