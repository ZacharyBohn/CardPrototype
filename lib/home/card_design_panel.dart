import 'package:flutter/material.dart';
import 'package:game_prototype/components/app_button.dart';
import 'package:game_prototype/components/app_text.dart';
import 'package:game_prototype/components/app_text_field.dart';
import 'package:game_prototype/components/spacing.dart';
import 'package:game_prototype/enum/app_colors.dart';
import 'package:game_prototype/providers/board_provider.dart';
import 'package:provider/provider.dart';

class CardDesignPanel extends StatefulWidget {
  const CardDesignPanel({Key? key}) : super(key: key);

  @override
  _CardDesignPanelState createState() => _CardDesignPanelState();
}

class _CardDesignPanelState extends State<CardDesignPanel> {
  @override
  Widget build(BuildContext context) {
    BoardProvider boardProvider = Provider.of<BoardProvider>(context);
    //This widget has 3/11 screen width
    //and 1/1 screen height -app bar
    Size size = MediaQuery.of(context).size;
    Size panelSize = Size(size.width * 3 / 11, size.height * 0.93);
    return Container(
      color: AppColors.panel,
      padding: EdgeInsets.symmetric(
        horizontal: panelSize.width * 0.05,
        vertical: panelSize.height * 0.02,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppTextField(
            hint: 'Name',
          ),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  hint: 'Top Left Value',
                ),
              ),
              HorizontalSpace(panelSize.width * 0.05),
              Expanded(
                child: AppTextField(
                  hint: 'Top Right Value',
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  hint: 'Bottom Left Value',
                ),
              ),
              HorizontalSpace(panelSize.width * 0.05),
              Expanded(
                child: AppTextField(
                  hint: 'Bottom Right Value',
                ),
              ),
            ],
          ),
          AppTextField(
            hint: 'Description',
          ),
          VerticalSpace(panelSize.height * 0.03),
          AppButton(
            label: 'Create Card',
            onTap: () {},
          ),
          VerticalSpace(panelSize.height * 0.01),
          AppButton(
            label: 'Delete Card',
            onTap: () {},
          ),
          VerticalSpace(panelSize.height * 0.01),
          AppButton(
            label: 'Reset Card',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
