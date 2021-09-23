import 'package:flutter/material.dart';
import 'package:game_prototype/enum/fonts.dart';
import 'package:game_prototype/models/game_card.model.dart';
import 'package:game_prototype/models/game_card_group.model.dart';
import 'package:game_prototype/providers/board_provider.dart';
import 'package:game_prototype/utils/helpers.dart';
import 'package:provider/provider.dart';

import '../components/app_text.dart';
import '../enum/app_colors.dart';

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
              title: AppText(label: 'Upload Card List (.csv)'),
              onTap: () async {
                String? data = await pickFile('Select Deck', ['csv']);
                List<GameCardModel>? cards = getCardsFromCsv(data);
                GameCardGroupModel cardGroup = GameCardGroupModel(
                  columnPosition: 0,
                  rowPosition: 0,
                  cards: cards,
                );
                Provider.of<BoardProvider>(context, listen: false)
                    .setCardGroup(0, 0, cardGroup);
                Navigator.of(context).pop();
                return;
              },
            ),
            ListTile(
              title: AppText(label: 'Download Card List (.csv)'),
              onTap: () async {
                BoardProvider boardProvider =
                    Provider.of<BoardProvider>(context, listen: false);
                String csvData = convertCardsToCsvString(boardProvider);
                String topLine =
                    'Name,Accent,Description,Image URL,Top Left,Top Right,Bottom Left,Bottom Right\n';
                csvData = topLine + csvData;
                //download the file to the client here
                await downloadCsvToClient(csvData);
                Navigator.of(context).pop();
                return;
              },
            ),
            // ListTile(
            //   title: AppText(label: 'Load Save State (.cpsave)'),
            //   onTap: () {
            //     Navigator.of(context).pop();
            //     return;
            //   },
            // ),
            // ListTile(
            //   title: AppText(label: 'Save State'),
            //   onTap: () {
            //     Navigator.of(context).pop();
            //     return;
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
