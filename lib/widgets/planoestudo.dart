import 'package:flutter/material.dart';
import 'package:plano_de_estudos/models/nivel.dart';
import 'package:plano_de_estudos/models/planoestudo.dart';

class PlanoEstudoPage extends StatefulWidget {
  @override
  _PlanoEstudoPageState createState() => _PlanoEstudoPageState();
}

class _PlanoEstudoPageState extends State<PlanoEstudoPage> {
  _save() {}

  PlanoEstudoModel _planoEstudo = PlanoEstudoModel();
  NivelModel _nivel = NivelModel();

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
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(labelText: "Descrição do nível"),
              style: TextStyle(fontSize: 20),
              onChanged: (value) {
                setState(() {
                  _nivel.descricao = value;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration(labelText: "Quantidade de horas"),
                      style: TextStyle(fontSize: 20),
                      onChanged: (value) {
                        setState(() {
                          _nivel.qtdHoras = int.parse(value);
                        });
                      },
                    )),
                Expanded(
                    child: IconButton(onPressed: () {}, icon: Icon(Icons.add)))
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _save(),
        child: Icon(Icons.check),
      ),
    );
  }
}
