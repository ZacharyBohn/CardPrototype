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
  String? id;
  String? name;
  String? descriptionAccent;
  String? description;
  String? topLeft;
  String? topRight;
  String? bottomLeft;
  String? bottomRight;
  String? imageUrl;

  String? error;

  late TextEditingController idController;
  late TextEditingController nameController;
  late TextEditingController topLeftController;
  late TextEditingController topRightController;
  late TextEditingController bottomLeftController;
  late TextEditingController bottomRightController;
  late TextEditingController descriptionAccentController;
  late TextEditingController descriptionController;
  late TextEditingController imageUrlController;

  @override
  initState() {
    idController = TextEditingController();
    nameController = TextEditingController();
    topLeftController = TextEditingController();
    topRightController = TextEditingController();
    bottomLeftController = TextEditingController();
    bottomRightController = TextEditingController();
    descriptionAccentController = TextEditingController();
    descriptionController = TextEditingController();
    imageUrlController = TextEditingController();
    super.initState();
    return;
  }

  bool checkCardValid() {
    if (id == null) {
      setState(() {
        error = 'ID must be set.';
      });
    }
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

  void clearDesignPanel() {
    setState(() {
      id = null;
      name = null;
      descriptionAccent = null;
      description = null;
      topLeft = null;
      topRight = null;
      bottomLeft = null;
      bottomRight = null;
      imageUrl = null;
    });
    idController.text = '';
    nameController.text = '';
    topLeftController.text = '';
    topRightController.text = '';
    bottomLeftController.text = '';
    bottomRightController.text = '';
    descriptionAccentController.text = '';
    descriptionController.text = '';
    imageUrlController.text = '';
    return;
  }

  void loadHighlightedCardInfo(BoardProvider boardProvider) {
    GameCardModel? card = boardProvider.highlightedCard;
    if (card == null) return;
    idController.text = card.id;
    nameController.text = card.name;
    descriptionAccentController.text = card.descriptionAccent;
    descriptionController.text = card.description;
    topLeftController.text = card.topLeft ?? '';
    topRightController.text = card.topRight ?? '';
    bottomLeftController.text = card.bottomLeft ?? '';
    bottomRightController.text = card.bottomRight ?? '';
    imageUrlController.text = card.imageUrl ?? '';
    return;
  }

  @override
  Widget build(BuildContext context) {
    BoardProvider boardProvider = Provider.of<BoardProvider>(context);
    if (boardProvider.highlightedCard != null) {
      loadHighlightedCardInfo(boardProvider);
    }
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
          Row(
            children: [
              Expanded(
                flex: 3,
                child: AppTextField(
                  hint: 'Name',
                  controller: nameController,
                  onTextChange: (String value) {
                    name = value;
                    clearError();
                  },
                ),
              ),
              HorizontalSpace(panelSize.width * 0.05),
              Expanded(
                child: AppTextField(
                  hint: 'ID',
                  controller: idController,
                  onTextChange: (String value) {
                    id = value;
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
                  hint: 'Top Left Value',
                  controller: topLeftController,
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
                  controller: topRightController,
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
                  controller: bottomLeftController,
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
                  controller: bottomRightController,
                  onTextChange: (String value) {
                    bottomRight = value;
                    clearError();
                  },
                ),
              ),
            ],
          ),
          AppTextField(
            hint: 'Description Accent',
            controller: descriptionAccentController,
            onTextChange: (String value) {
              descriptionAccent = value;
              clearError();
            },
          ),
          AppTextField(
            hint: 'Description',
            controller: descriptionController,
            onTextChange: (String value) {
              descriptionAccent = value;
              clearError();
            },
          ),
          AppTextField(
            hint: 'Image URL',
            controller: imageUrlController,
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
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'Copy Card',
                  onTap: () {
                    if (boardProvider.highlightedCard == null) {
                      setState(() {
                        error = 'A card must be highlighted to be copied.';
                      });
                      return;
                    }
                    boardProvider.setTopCard(
                      0,
                      0,
                      boardProvider.highlightedCard!.copy(),
                    );
                    clearError();
                    clearDesignPanel();
                  },
                ),
              ),
              HorizontalSpace(panelSize.width * 0.05),
              Expanded(
                child: AppButton(
                  label: 'Delete Card',
                  onTap: () {
                    if (boardProvider.highlightedColumn != null) {
                      boardProvider.removeTopCard(
                        boardProvider.highlightedRow!,
                        boardProvider.highlightedColumn!,
                      );
                    }
                    boardProvider.clearHighlight();
                    clearError();
                    clearDesignPanel();
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
                  label: 'Create Card',
                  onTap: () {
                    //error checking
                    if (checkCardValid() == false) return;
                    boardProvider.setTopCard(
                        0,
                        0,
                        GameCardModel(
                          id: id!,
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
                    clearDesignPanel();
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
