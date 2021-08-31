import 'package:flutter/material.dart';
import 'package:game_prototype/components/board.dart';
import 'package:game_prototype/home/drawer.dart';
import 'package:game_prototype/enum/fonts.dart';
import 'package:game_prototype/home/preview_panel.dart';

import '../components/app_text.dart';
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
      appBar: AppBar(
        title: AppText(
          label: 'CCG Prototyper',
          fontSize: FontSizes.header,
        ),
        backgroundColor: AppColors.appBarBackground,
        elevation: 0,
      ),
      drawer: AppDrawer(),
      body: Container(
        color: AppColors.background,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: PreviewPanel(),
            ),
            Spacer(),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: ColorPalette.paleWhite,
                      width: size.width * 0.4,
                      child:
                          Center(child: AppText(label: 'Opponents Hand Area')),
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
                    child: Container(
                      color: ColorPalette.paleWhite,
                      width: size.width * 0.4,
                      child: Center(child: AppText(label: 'Player Hand Area')),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Expanded(
              flex: 3,
              child: Container(
                color: AppColors.panel,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(label: 'Chat / Settings Panel'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
