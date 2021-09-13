import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:game_prototype/components/app_button.dart';
import 'package:game_prototype/components/app_text.dart';
import 'package:game_prototype/components/app_text_field.dart';
import 'package:game_prototype/components/spacing.dart';
import 'package:game_prototype/enum/app_colors.dart';
import 'package:game_prototype/models/game_card.model.dart';
import 'package:game_prototype/providers/board_provider.dart';
import 'package:provider/provider.dart';

class CardDesignPanel extends StatefulWidget {
  const CardDesignPanel({Key? key}) : super(key: key);

  @override
  _CardDesignPanelState createState() => _CardDesignPanelState();
}

class _CardDesignPanelState extends State<CardDesignPanel> {
  String? name;
  String? description;
  String? topLeft;
  String? topRight;
  String? bottomLeft;
  String? bottomRight;
  String? imageUrl;
  Uint8List? imageBytes;

  String? error;

  bool checkCardValid() {
    if (name == null) {
      setState(() {
        error = 'Name must be set.';
      });
      return false;
    }
    if (description == null) {
      setState(() {
        error = 'Description must be set.';
      });
      return false;
    }
    return true;
  }

  void clearError() {
    setState(() {
      error = null;
    });
    return;
  }

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
            onTextChange: (String value) {
              name = value;
              clearError();
            },
          ),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  hint: 'Top Left Value',
                  onTextChange: (String value) {
                    topLeft = value;
                    clearError();
                  },
                ),
              ),
              HorizontalSpace(panelSize.width * 0.05),
              Expanded(
                child: AppTextField(
                  hint: 'Top Right Value',
                  onTextChange: (String value) {
                    topRight = value;
                    clearError();
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  hint: 'Bottom Left Value',
                  onTextChange: (String value) {
                    bottomLeft = value;
                    clearError();
                  },
                ),
              ),
              HorizontalSpace(panelSize.width * 0.05),
              Expanded(
                child: AppTextField(
                  hint: 'Bottom Right Value',
                  onTextChange: (String value) {
                    bottomRight = value;
                    clearError();
                  },
                ),
              ),
            ],
          ),
          AppTextField(
            hint: 'Description',
            onTextChange: (String value) {
              description = value;
              clearError();
            },
          ),
          AppTextField(
            hint: 'Image URL',
            onTextChange: (String value) {
              imageUrl = value;
              clearError();
            },
          ),
          VerticalSpace(panelSize.height * 0.03),
          if (imageUrl != null)
            Expanded(
              child: Image.network(
                imageUrl!,
              ),
            ),
          if (imageUrl == null)
            AppText(
              label: 'No image set.',
            ),
          Spacer(),
          if (error != null)
            AppText(
              label: '$error',
              fontColor: AppColors.error,
            ),
          VerticalSpace(panelSize.height * 0.01),
          AppButton(
            label: 'Load Image',
            onTap: () async {
              setState(() {
                imageUrl = imageUrl;
              });
              // imageBytes = null;
              // FilePickerResult? image = await FilePicker.platform.pickFiles(
              //   dialogTitle: 'Choose Image',
              //   type: FileType.image,
              //   withData: true,
              // );
              // if (image == null || image.count == 0) return;
              // PlatformFile file = image.files.first;
              // setState(() {
              //   imageBytes = file.bytes;
              // });
            },
          ),
          VerticalSpace(panelSize.height * 0.01),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'Copy Card',
                  onTap: () {
                    clearError();
                  },
                ),
              ),
              HorizontalSpace(panelSize.width * 0.05),
              Expanded(
                child: AppButton(
                  label: 'Delete Card',
                  onTap: () {
                    clearError();
                  },
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
                  onTap: () {
                    //error checking
                    if (checkCardValid() == false) return;
                    boardProvider.setTopCard(
                        0,
                        0,
                        GameCardModel(
                          name: name!,
                          description: description!,
                          imageUrl: imageUrl,
                          topLeft: topLeft,
                          topRight: topRight,
                          bottomLeft: bottomLeft,
                          bottomRight: bottomRight,
                        ));
                    boardProvider.highlightCard(0, 0);
                    clearError();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
