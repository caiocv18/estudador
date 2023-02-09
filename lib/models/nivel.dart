import 'model.dart';

class NivelModel extends Model<NivelModel> {
  String descricao;
  int qtdHoras;

  NivelModel({this.descricao = '', this.qtdHoras = 0});

  @override
  NivelModel fromJson(Map<String, dynamic> json) {
    this.descricao = json['descricao'];
    this.qtdHoras = json['qtdHoras'];
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map();
    json['descricao'] = this.descricao;
    json['qtdHoras'] = this.qtdHoras;
    return json;
  }
}
