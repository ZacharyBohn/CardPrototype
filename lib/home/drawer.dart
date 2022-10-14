import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:game_prototype/enum/fonts.dart';
import 'package:game_prototype/models/game_card.model.dart';
import 'package:game_prototype/models/game_card_group.model.dart';
import 'package:game_prototype/providers/board_provider.dart';
import 'package:game_prototype/utils/helpers.dart';
import 'package:provider/provider.dart';

import '../components/app_text.dart';
import '../enum/app_colors.dart';
import '../models/board.model.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Container(
        color: AppColors.drawerBody,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: size.height * 0.1,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.drawerHeader,
                ),
                child: Center(
                  child: AppText(
                    label: 'CCG Prototyper',
                    fontSize: FontSizes.header,
                  ),
                ),
              ),
            ),
            ListTile(
              title: AppText(label: 'Load from file (json)'),
              onTap: () async {
                BoardProvider boardProvider =
                    Provider.of<BoardProvider>(context, listen: false);
                String? data = await pickFile('Select Save File', ['json']);
                if (data != null) {
                  Map? map = jsonDecode(data);
                  if (map != null && map is Map<String, dynamic>) {
                    boardProvider.board = BoardModel.fromJson(map);
                  }
                }
                Navigator.of(context).pop();
                return;
              },
            ),
            ListTile(
              title: AppText(label: 'Save to file (json)'),
              onTap: () async {
                BoardProvider boardProvider =
                    Provider.of<BoardProvider>(context, listen: false);
                String data = jsonEncode(boardProvider.board.toJson());
                //download the file to the client here
                await downloadJsonToClient(data);
                Navigator.of(context).pop();
                return;
              },
            ),
          ],
        ),
      ),
    );
  }
}
