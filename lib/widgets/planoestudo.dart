import 'package:flutter/material.dart';
import 'package:plano_de_estudos/models/nivel.dart';
import 'package:plano_de_estudos/models/planoestudo.dart';
import 'package:plano_de_estudos/services/planoestudo.dart';

class PlanoEstudoPage extends StatefulWidget {
  @override
  _PlanoEstudoPageState createState() => _PlanoEstudoPageState();
}

class _PlanoEstudoPageState extends State<PlanoEstudoPage> {
  PlanoEstudoModel _planoEstudo = PlanoEstudoModel();
  PlanoEstudoService _planoEstudoService = PlanoEstudoService();

  var descricaoCtrl = TextEditingController();
  var qtdHorasCtrl = TextEditingController();

  var currentIndex = null;

  _save() async {
    _planoEstudo.niveis.sort((n1, n2) => n1.qtdHoras - n2.qtdHoras);
    _planoEstudo.nivelAtual = _planoEstudo.niveis.first;
    await _planoEstudoService.save(_planoEstudo);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plano de Estudo'),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 48, left: 32, right: 32),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: TextFormField(
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(labelText: "Título"),
              style: TextStyle(fontSize: 20),
              onChanged: (value) {
                setState(() {
                  _planoEstudo.titulo = value;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8, top: 8),
            child: Text(
              "Níveis",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: TextFormField(
                controller: descricaoCtrl,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(labelText: "Descrição do nível"),
                style: TextStyle(fontSize: 20)),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: qtdHorasCtrl,
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration(labelText: "Quantidade de horas"),
                      style: TextStyle(fontSize: 20),
                    )),
                Visibility(
                    visible: currentIndex == null,
                    child: Expanded(
                      child: IconButton(
                          onPressed: _addAoPlano, icon: Icon(Icons.add)),
                    )),
                Visibility(
                    visible: currentIndex != null,
                    child: Expanded(
                      child: IconButton(
                          onPressed: _alterarDoPlano, icon: Icon(Icons.edit)),
                    )),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: Column(
              children: _planoEstudo.niveis.map((e) {
                return GestureDetector(
                  onTap: () => _editarDoPlano(e),
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text(
                                e.descricao,
                                style: TextStyle(fontSize: 18),
                              )),
                          Expanded(
                              flex: 2,
                              child: Text(
                                '${e.qtdHoras} horas',
                                style: TextStyle(fontSize: 18),
                              )),
                          Expanded(
                              child: IconButton(
                                  onPressed: () => _removeDoPlano(
                                      _planoEstudo.niveis.indexOf(e)),
                                  icon: Icon(Icons.delete)))
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
      floatingActionButton: Visibility(
        visible: _planoEstudo.niveis.isNotEmpty,
        child: FloatingActionButton(
          onPressed: () => _save(),
          child: Icon(Icons.check),
        ),
      ),
    );
  }

  _addAoPlano() {
    if (_validarNivel()) {
      return;
    }
    setState(() {
      _planoEstudo.niveis.add(
        NivelModel(
            descricao: descricaoCtrl.text,
            qtdHoras: int.parse(qtdHorasCtrl.text)),
      );
      descricaoCtrl.clear();
      qtdHorasCtrl.clear();
    });
    print(_planoEstudo);
  }

  _removeDoPlano(int index) {
    setState(() {
      _planoEstudo.niveis.removeAt(index);
      print(_planoEstudo);
    });
  }

  _editarDoPlano(NivelModel e) {
    setState(() {
      currentIndex = _planoEstudo.niveis.indexOf(e);
      descricaoCtrl.text = e.descricao;
      qtdHorasCtrl.text = e.qtdHoras.toString();
      print(_planoEstudo);
    });
  }

  _alterarDoPlano() {
    if (_validarNivel()) {
      return;
    }
    setState(() {
      var nivel = _planoEstudo.niveis[currentIndex];
      nivel.descricao = descricaoCtrl.text;
      nivel.qtdHoras = int.parse(qtdHorasCtrl.text);

      descricaoCtrl.clear();
      qtdHorasCtrl.clear();
      currentIndex = null;
    });
    print(_planoEstudo);
  }

  bool _validarNivel() {
    return descricaoCtrl.text.trim().isEmpty ||
        qtdHorasCtrl.text.trim().isEmpty;
  }
}
