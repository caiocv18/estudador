import 'package:plano_de_estudos/models/model.dart';

import 'nivel.dart';

class PlanoEstudoModel extends Model<PlanoEstudoModel> {
  String titulo = '';
  int tempoEstudado = 0;
  List<NivelModel> niveis = [];
  NivelModel nivelAtual = NivelModel();

  @override
  PlanoEstudoModel fromJson(Map<String, dynamic> json) {
    this.titulo = json['titulo'];
    this.tempoEstudado = json['tempoEstudado'];
    this.niveis = json['niveis'];
    this.nivelAtual = json['nivelAtual'];
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map();
    json['titulo'] = this.titulo;
    json['tempoEstudado'] = this.tempoEstudado;
    json['niveis'] = this.niveis;
    json['nivelAtual'] = this.nivelAtual;
    return json;
  }
}
