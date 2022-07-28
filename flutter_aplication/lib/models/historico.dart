class ItemHistorico {
  int? id;
  String? nome;
  String? descricao;
  String? foto;
  String? tamanho;
  String? quantidade;
  String? valor;
  String? data;

  ItemHistorico(
      {this.id,
      this.nome,
      this.descricao,
      this.foto,
      this.tamanho,
      this.quantidade,
      this.valor,
      this.data});

  ItemHistorico.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    descricao = json['descricao'];
    foto = json['foto'];
    tamanho = json['tamanho'];
    quantidade = json['quantidade'];
    valor = json['valor'];
    data = json['data'];
  }
}
