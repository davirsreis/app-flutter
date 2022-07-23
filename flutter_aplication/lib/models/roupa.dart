import 'package:flutter_aplication/http.dart';

class Roupa {
  int? id;
  String? nome;
  String? descricao;
  String? foto;
  String? medidas;
  String? valor;

  Roupa(
      {this.id,
      this.nome,
      this.descricao,
      this.foto,
      this.medidas,
      this.valor});

  Roupa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    descricao = json['descricao'];
    foto = json['foto'];
    medidas = json['medidas'];
    valor = json['valor'];
  }
}
