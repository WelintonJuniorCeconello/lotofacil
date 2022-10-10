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
