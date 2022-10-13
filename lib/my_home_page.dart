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

  Map<int, int> getfrequenciaDezena() {
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
    return frequenciaDezena.asMap();
  }

  List<int> getLargerDezena() {
    List<int> maioresDezenas = [0];
    List<int> refKeys = getfrequenciaDezena().keys.toList();
    int maiorValue = 0, maiorKey = 0;
    for (var i = 1; i < 26; i++) {
      for (var element in getfrequenciaDezena().entries) {
        if (element.value > maiorValue && refKeys.contains(element.key)) {
          maiorValue = element.value;
          maiorKey = element.key;
        }
      }
      maioresDezenas.add(maiorKey);
      refKeys.remove(maiorKey);
      maiorValue = 0;
    }

    setState(() {
      exibicao = maioresDezenas
          .toString()
          .substring(4, maioresDezenas.toString().length - 1);
    });

    return maioresDezenas;
  }

  // 1, 2, 3, 5, 8, 13, 21
  getFibonacci() {
    List<int> maiorFibonacci = getLargerDezena();
    List<int> fibonacci = [
      4,
      6,
      7,
      9,
      10,
      11,
      12,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      22,
      23,
      24,
      25
    ];
    for (var fibo in fibonacci) {
      maiorFibonacci.removeWhere((element) => element == fibo);
    }
    setState(() {
      exibicao = maiorFibonacci
          .toString()
          .substring(4, maiorFibonacci.toString().length - 1);
    });
  }

  // 1, 2, 3, 5, 8, 13, 21
  getVezFibonacci() {
    List<int> fibonacci = [1, 2, 3, 5, 8, 13, 21];
    Map<int, int> maisFibonacci = {};

    setState(() {
      exibicao = maisFibonacci.toString();
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
                child: const Text("Ordem dos números que mais saiu"),
              ),
              const Divider(height: 15),
              ElevatedButton(
                onPressed: getFibonacci,
                child: const Text("Ordem dos números Fibonacci que mais saiu"),
              ),
              const Divider(height: 1),
              ElevatedButton(
                onPressed: getVezFibonacci,
                child: const Text("Fibonacci"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// sequencia normal, vez e media
// atraso normal, vez e media
// pares e impares
// primos
// soma
// fibonacci