import 'package:flutter_aplication/http.dart';

class Roupa {
  int? id;
  String? nome;
  String? descricao;
  String? cor;
  String? foto;
  String? medidas;
  String? valor;

  Roupa(
      {this.id,
      this.nome,
      this.descricao,
      this.cor,
      this.foto,
      this.medidas,
      this.valor});

  Roupa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    descricao = json['descricao'];
    cor = json['cor'];
    foto = json['foto'];
    medidas = json['medidas'];
    valor = json['valor'];
  }
}
