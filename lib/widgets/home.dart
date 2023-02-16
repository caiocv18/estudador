import 'package:flutter/material.dart';
import 'package:plano_de_estudos/models/planoestudo.dart';
import 'package:plano_de_estudos/services/planoestudo.dart';
import 'package:plano_de_estudos/utils/string.dart';
import 'package:plano_de_estudos/widgets/planoestudo.dart';
import 'package:plano_de_estudos/widgets/timer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PlanoEstudoService _planoEstudoService = PlanoEstudoService();
  List<PlanoEstudoModel> _planos = [];

  @override
  void initState() {
    super.initState();
    _updateList();
  }

  void _updateList() {
    _planoEstudoService.list().then((planos) {
      if (planos != null) {
        setState(() {
          this._planos = planos;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: _buildPlanosEstudos(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlanoEstudoPage(),
            ),
          );
          _updateList();
        },
        tooltip: 'Adicionar',
        child: Icon(Icons.add),
      ),
    );
  }

  List<Widget> _buildPlanosEstudos() {
    return _planos.map((p) {
      return GestureDetector(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TimerPage(_planos.indexOf(p), p),
            ),
          );
          _updateList();
        },
        child: Card(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    p.titulo,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    '${StringUtils.printDuration(p.tempoEstudado)} estudado',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Expanded(
                  child: Text(
                    p.nivelAtual!.descricao,
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }).toList();
  }
}
