import 'package:flutter/material.dart';
import 'package:lotofacil/storage.dart';

class MyHomePage extends StatefulWidget {
  final Storage storage;

  const MyHomePage({super.key, required this.storage});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String exibicao = "";
  List<String> results = [""];
  int sorteio = 0;

  @override
  void initState() {
    widget.storage.readData().then((List<String> values) {
      setState(() {
        sorteio = values.length;
        for (String value in values) {
          results.add(value.substring(value.length - 44));
        }
        exibicao = "Resultado do ultimo sorteio $sorteio: ${results[sorteio]}";
      });
    });
    super.initState();
  }

  List<int> getfrequenciaDezena() {
    List<bool> encontrarVez = [];
    List<int> frequenciaDezena = [0];
    List<String> ref = [];
    for (var i = 1; i < 26; i++) {
      ref.add((i < 10) ? "0${i.toString()}" : i.toString());
    }
    for (var refs in ref) {
      for (String element in results) {
        encontrarVez.add(element.contains(refs));
      }
      encontrarVez.removeWhere(((item) => item.toString().length == 5));
      frequenciaDezena.add(encontrarVez.length);
      encontrarVez.clear();
    }
    return frequenciaDezena;
  }

  getLargerDezena() {
    setState(() {
      exibicao = getfrequenciaDezena().toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lotofacil"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(exibicao),
              const Divider(height: 15),
              ElevatedButton(
                onPressed: getLargerDezena,
                child: const Text("Dezenas que mais saiu"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
