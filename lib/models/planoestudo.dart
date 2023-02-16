import 'package:plano_de_estudos/models/model.dart';

import 'nivel.dart';

class PlanoEstudoModel extends Model<PlanoEstudoModel> {
  String titulo = '';
  int tempoEstudado = 0;
  List<NivelModel> niveis = [];
  NivelModel? nivelAtual;

  @override
  PlanoEstudoModel fromJson(Map<String, dynamic> json) {
    this.titulo = json['titulo'];
    this.tempoEstudado = json['tempoEstudado'];
    if (json['niveis'] != null) {
      List<NivelModel> niveis = (json['niveis'] as List).map((m) {
        NivelModel nivel = NivelModel();
        nivel.fromJson(m);
        return nivel;
      }).toList();
      this.niveis = niveis;
    }
    this.niveis = niveis;
    if (json['nivelAtual'] != null) {
      NivelModel nivel = NivelModel();
      nivel.fromJson(json['nivelAtual']);
      this.nivelAtual = nivel;
    }
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map();
    json['titulo'] = this.titulo;
    json['tempoEstudado'] = this.tempoEstudado;
    json['niveis'] = this.niveis.map((e) => e.toJson()).toList();
    if (this.nivelAtual != null) {
      json['nivelAtual'] = this.nivelAtual?.toJson();
    }
    return json;
  }
}
