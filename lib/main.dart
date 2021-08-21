import 'package:flutter/material.dart';
import 'package:game_prototype/providers/board_provider.dart';
import 'package:provider/provider.dart';

import 'home.dart';

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<BoardProvider>(create: (context) => BoardProvider()),
      ],
      child: MaterialApp(
        home: Home(),
      ),
    );
  }
}
