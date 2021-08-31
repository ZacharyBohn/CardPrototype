import 'package:flutter/material.dart';
import 'package:game_prototype/enum/fonts.dart';

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
              height: size.height * 0.12,
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
              onTap: () {
                Navigator.of(context).pop();
                return;
              },
            ),
            ListTile(
              title: AppText(label: 'Download Card List Template'),
              onTap: () {
                Navigator.of(context).pop();
                return;
              },
            ),
            ListTile(
              title: AppText(label: 'Load Save State (.cpsave)'),
              onTap: () {
                Navigator.of(context).pop();
                return;
              },
            ),
            ListTile(
              title: AppText(label: 'Save State'),
              onTap: () {
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
