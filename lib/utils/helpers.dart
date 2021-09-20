import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:file_picker/file_picker.dart';
import 'package:game_prototype/models/game_card.model.dart';
import 'package:game_prototype/providers/board_provider.dart';

Future<String?> pickFile(
  String? title,
  List<String>? allowedExtentions,
) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    dialogTitle: title,
    type: FileType.custom,
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
  lines = lines.sublist(1);
  for (String line in lines) {
    GameCardModel? card = GameCardModel.fromString(line);
    if (card == null) continue;
    cards.add(card);
  }
  return cards;
}

String convertCardsToCsvString(BoardProvider boardProvider) {
  List<GameCardModel> allCards = [];
  //loop through the cards
  for (int column in range(boardProvider.columns)) {
    for (int row in range(boardProvider.rows)) {
      allCards.addAll(boardProvider.getCardGroup(row, column).cards);
    }
  }
  String data = '';
  for (GameCardModel card in allCards) {
    data += card.toCsvString();
  }
  return data;
}

range(int x) {
  return Iterable.generate(x);
}

Future<void> downloadCsvToClient(String data) async {
  if (kIsWeb) {
    downloadCsvToClientWeb(data);
    return;
  }
  if (Platform.isWindows) {
    //TODO: implement downloading on windows
    return;
  }
  return;
}

Future<void> downloadCsvToClientWeb(String data) async {
  var bytes = utf8.encode(data);
  var blob = html.Blob([bytes]);
  var url = html.Url.createObjectUrlFromBlob(blob);
  var anchor = html.document.createElement('a') as html.AnchorElement
    ..href = url
    ..style.display = 'none'
    ..download = 'Card List.csv';
  html.document.body!.children.add(anchor);
  // download
  anchor.click();

// cleanup
  html.document.body!.children.remove(anchor);
  html.Url.revokeObjectUrl(url);
  return;
}
