import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:game_prototype/models/game_card.model.dart';

Future<String?> pickFile(
  String? title,
  List<String>? allowedExtentions,
) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    dialogTitle: title,
    allowedExtensions: allowedExtentions,
    withData: true,
  );
  if (result == null) return null;
  Uint8List? bytes = result.files.first.bytes;
  if (bytes == null) return null;
  String thing = String.fromCharCodes(bytes);
  return thing;
}

List<GameCardModel>? getCardsFromCsv(String? csvData) {
  if (csvData == null || csvData.isEmpty) return null;
  List<GameCardModel> cards = [];
  List<String> lines = csvData.split('\n');
  for (String line in lines) {
    cards.add(GameCardModel.fromString(line));
  }
  return cards;
}
