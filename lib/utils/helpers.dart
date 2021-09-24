import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:csv/csv.dart';
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
  List<List<dynamic>> convertedData = CsvToListConverter().convert(csvData);
  List<GameCardModel> cards = [];

  for (List<dynamic> line in convertedData.sublist(1)) {
    if (line[0].toString().startsWith('//')) continue;
    if (line[0].toString().isEmpty) continue;
    GameCardModel card;
    try {
      card = GameCardModel(
        name: line[0].toString().isNotEmpty ? line[0].toString() : null,
        descriptionAccent:
            line[1].toString().isNotEmpty ? line[1].toString() : null,
        description: line[2].toString().isNotEmpty ? line[2].toString() : null,
        imageUrl: line[3].toString().isNotEmpty ? line[3].toString() : null,
        topLeft: line[4].toString().isNotEmpty ? line[4].toString() : null,
        topRight: line[5].toString().isNotEmpty ? line[5].toString() : null,
        bottomLeft: line[6].toString().isNotEmpty ? line[6].toString() : null,
        bottomRight: line[7].toString().isNotEmpty ? line[7].toString() : null,
      );
    } catch (e) {
      continue;
    }
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
