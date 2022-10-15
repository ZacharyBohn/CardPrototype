import 'package:flutter/material.dart';
import 'package:game_prototype/components/board.dart';
import 'package:game_prototype/components/player_hand.dart';
import 'package:game_prototype/home/card_design_panel.dart';
import 'package:game_prototype/home/drawer.dart';
import 'package:game_prototype/enum/fonts.dart';
import 'package:game_prototype/home/preview_panel.dart';
import 'package:game_prototype/providers/board_provider.dart';
import 'package:provider/provider.dart';

import '../components/app_text.dart';
import '../components/game_card_stack_previewer.dart';
import '../enum/app_colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext conApptext) {
    Size size = MediaQuery.of(conApptext).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.07),
        child: AppBar(
          title: AppText(
            label: 'CCG Prototyper',
            fontSize: FontSizes.header,
          ),
          backgroundColor: AppColors.appBarBackground,
          elevation: 0,
        ),
      ),
      drawer: AppDrawer(),
      body: GestureDetector(
        onTap: () {
          Provider.of<BoardProvider>(context, listen: false).highlightedCard =
              null;
        },
        child: Container(
          color: AppColors.background,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: PreviewPanel(),
              ),
              Expanded(
                child: GameCardStackPreviewer(),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: PlayerHand(
                          isPlayer1: false,
                        ),
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      flex: 10,
                      child: Board(),
                    ),
                    Spacer(),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: PlayerHand(
                          isPlayer1: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Expanded(
                flex: 3,
                child: CardDesignPanel(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
