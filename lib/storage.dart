import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';

class Storage {
  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/db.txt');
  }

  Future<List<String>> readData() async {
    try {
      final file = await localFile;
      List<String> body = await file.readAsLines();
      return body;
    } catch (e) {
      List<String> error = ["$e", "Deu erro"];
      return error;
    }
  }

  /*Future<File> writeData(String data) async {
    final file = await localFile;
    return file.writeAsString(data);
  }*/
}

extension ExtInt on int {
  /// Converte um número inteiro em string de binario.
  String toBinario(int valueMax) {
    String res = toRadixString(2), imput = toRadixString(2);
    if (imput.length < valueMax) {
      String add = "0";
      for (var i = 1; i < (valueMax - imput.length); i++) {
        add = "0$add";
      }
      res = "$add$imput";
    }
    return res;
  }
}

extension ExtString on String {
  /// Retorna lista da posição onde tem bit alto
  List<int> binarioHigh(int value) {
    List<int> res = [];
    if (contains('1')) {
      do {} while (indexOf('1') != value - 1);
    }
    return res;
  }
}
