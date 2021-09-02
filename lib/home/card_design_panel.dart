import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:game_prototype/components/app_button.dart';
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
  Uint8List? bytes;
  @override
  Widget build(BuildContext context) {
    BoardProvider boardProvider = Provider.of<BoardProvider>(context);
    //This widget has 3/11 screen width
    //and 1/1 screen height -app bar
    Size size = MediaQuery.of(context).size;
    Size panelSize = Size(size.width * 3 / 11, size.height * 0.93);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.panel,
        border: Border(
          left: BorderSide(
            width: 1,
            color: AppColors.panelBarrier,
          ),
        ),
      ),
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
          if (bytes != null)
            Image.memory(
              bytes!,
              width: panelSize.width * 0.8,
              height: panelSize.height * 0.3,
            ),
          VerticalSpace(panelSize.height * 0.03),
          AppButton(
            label: 'Upload Image',
            onTap: () async {
              bytes = null;
              print('picking image');
              FilePickerResult? image = await FilePicker.platform.pickFiles(
                dialogTitle: 'Choose Image',
                type: FileType.image,
              );
              print('image picked');
              if (image == null || image.count == 0) return;
              PlatformFile file = image.files.first;
              setState(() {
                bytes = file.bytes;
              });
            },
          ),
          VerticalSpace(panelSize.height * 0.01),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'Delete Card',
                  onTap: () {},
                ),
              ),
              HorizontalSpace(panelSize.width * 0.05),
              Expanded(
                child: AppButton(
                  label: 'Reset Card',
                  onTap: () {},
                ),
              ),
            ],
          ),
          VerticalSpace(panelSize.height * 0.01),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'Create New Card',
                  onTap: () {},
                ),
              ),
              HorizontalSpace(panelSize.width * 0.05),
              Expanded(
                child: AppButton(
                  label: 'Copy Card',
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
