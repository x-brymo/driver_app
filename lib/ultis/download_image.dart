import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

Future<File> downloadAndSaveImage(String imgPath) async {
  final response = await http.get(Uri.parse(imgPath));
  final documentDirectory = await getApplicationDocumentsDirectory();
  final uuid = Uuid();
  final fileName = '${uuid.v4()}.png';
  final file = File('${documentDirectory.path}/$fileName');
  file.writeAsBytesSync(response.bodyBytes);
  return file;
}