import 'package:flutter/material.dart';

import 'components/app_text.dart';
import 'enum/app_colors.dart';

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
          fontSize: 18,
        ),
        backgroundColor: AppColors.appBarBackground,
        elevation: 0,
        leading: Icon(
          Icons.menu,
          color: AppColors.menuIcon,
        ),
      ),
      body: Container(
        color: AppColors.background,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: AppColors.panel,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(label: 'Card Preview Panel'),
                  ],
                ),
              ),
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
                  Expanded(
                    flex: 10,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateX(-0.75),
                      alignment: FractionalOffset.center,
                      child: Container(
                        color: AppColors.board,
                        width: size.width * 0.4,
                        height: size.width * 0.45,
                        child: Center(
                          child: AppText(label: 'Board Area'),
                        ),
                      ),
                    ),
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
