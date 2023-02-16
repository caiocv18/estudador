import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plano_de_estudos/models/planoestudo.dart';
import 'package:plano_de_estudos/services/planoestudo.dart';
import 'package:plano_de_estudos/utils/string.dart';

class TimerPage extends StatefulWidget {
  PlanoEstudoModel? planoEstudo;
  int? index;

  TimerPage(index, planoEstudo)
      : this.planoEstudo = planoEstudo,
        this.index = index;

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  PlanoEstudoService planoEstudoService = PlanoEstudoService();

  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contador para ${widget.planoEstudo?.titulo}'),
      ),
      body: Stack(
        children: [
          Center(
            child: GestureDetector(
              onTap: timer == null ? startCronometro : stopCronometro,
              child: new Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: timer == null ? Colors.black : Colors.red,
                      width: 2,
                    ),
                    shape: BoxShape.circle),
                child: Align(
                  alignment: FractionalOffset.center,
                  child: Text(
                    StringUtils.printDuration(
                        widget.planoEstudo?.tempoEstudado),
                    style: TextStyle(
                      fontSize: 24,
                      color: timer == null ? Colors.black : Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  startCronometro() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (widget.planoEstudo?.tempoEstudado == null) {
          widget.planoEstudo?.tempoEstudado = 0;
        }
        widget.planoEstudo?.tempoEstudado += 1;
        widget.planoEstudo?.nivelAtual = widget.planoEstudo?.niveis.firstWhere(
            (p) => (p.qtdHoras * 3600) > widget.planoEstudo!.tempoEstudado,
            orElse: () => widget.planoEstudo!.niveis.last);
        planoEstudoService.update(widget.index, widget.planoEstudo);
      });
    });
  }

  stopCronometro() {
    setState(() {
      timer?.cancel();
      timer = null;
    });
  }
}
