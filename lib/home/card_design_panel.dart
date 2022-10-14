import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_prototype/components/app_button.dart';
import 'package:game_prototype/components/app_text.dart';
import 'package:game_prototype/components/app_text_field.dart';
import 'package:game_prototype/components/board.dart';
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
  GameCardModel? previousSelectedCard;

  String? name;
  String? descriptionAccent;
  String? description;
  String? topLeft;
  String? topRight;
  String? bottomLeft;
  String? bottomRight;
  String? imageUrl;

  String? error;

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
    if (name == null) {
      setState(() {
        error = 'Name must be set.';
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
      name = null;
      descriptionAccent = null;
      description = null;
      topLeft = null;
      topRight = null;
      bottomLeft = null;
      bottomRight = null;
      imageUrl = null;
    });
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
    nameController.text = card.name;
    name = card.name;
    descriptionAccentController.text = card.descriptionAccent ?? '';
    descriptionAccent = card.descriptionAccent ?? '';
    descriptionController.text = card.description;
    description = card.description;
    topLeftController.text = card.topLeft ?? '';
    topLeft = card.topLeft ?? '';
    topRightController.text = card.topRight ?? '';
    topRight = card.topRight ?? '';
    bottomLeftController.text = card.bottomLeft ?? '';
    bottomLeft = card.bottomLeft ?? '';
    bottomRightController.text = card.bottomRight ?? '';
    bottomRight = card.bottomRight ?? '';
    imageUrlController.text = card.imageUrl ?? '';
    imageUrl = card.imageUrl ?? '';
    return;
  }

  bool editingHighlightedCard(BoardProvider boardProvider) {
    return boardProvider.highlightedCard != null;
  }

  Timer? maybeSaveTimer;

  void maybeSave() {
    maybeSaveTimer?.cancel();
    maybeSaveTimer = Timer(Duration(milliseconds: 200), () {
      if (editingHighlightedCard(context.read<BoardProvider>())) {
        save(errorResets: false);
      }
    });
    return;
  }

  void save({bool errorResets = true}) {
    BoardProvider boardProvider = context.read<BoardProvider>();
    //error checking
    if (checkCardValid() == false) return;
    if (editingHighlightedCard(boardProvider)) {
      var card = GameCardModel(
        name: name!,
        descriptionAccent: descriptionAccent,
        description: description,
        imageUrl: imageUrl,
        topLeft: topLeft,
        topRight: topRight,
        bottomLeft: bottomLeft,
        bottomRight: bottomRight,
        faceup: true,
      );
      boardProvider.highlightedCard = card;
      boardProvider.removeTopCard(
        boardProvider.highlightedRow!,
        boardProvider.highlightedColumn!,
      );
      boardProvider.addCardToTop(
        boardProvider.highlightedRow!,
        boardProvider.highlightedColumn!,
        card,
      );
      boardProvider.updateAllCardsWithName(card.name, card);
      if (errorResets) {
        clearError();
        clearDesignPanel();
      }
      return;
    }
    boardProvider.addCardToTop(
        boardProvider.rows - 1,
        boardProvider.columns - 1,
        GameCardModel(
          name: name!,
          descriptionAccent: descriptionAccent,
          description: description,
          imageUrl: imageUrl,
          topLeft: topLeft,
          topRight: topRight,
          bottomLeft: bottomLeft,
          bottomRight: bottomRight,
          faceup: true,
        ));
    boardProvider.highlightCard(
      boardProvider.rows - 1,
      boardProvider.columns - 1,
    );
    clearError();
    clearDesignPanel();
    return;
  }

  @override
  Widget build(BuildContext context) {
    BoardProvider boardProvider = Provider.of<BoardProvider>(context);
    if (boardProvider.highlightedCardChanged) {
      if (boardProvider.highlightedCard != null) {
        loadHighlightedCardInfo(boardProvider);
      } else {
        clearDesignPanel();
      }
      boardProvider.highlightedCardChanged = false;
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
          AppTextField(
            hint: 'Name',
            controller: nameController,
            onTextChange: (String value) {
              name = value;
              maybeSave();
              clearError();
            },
          ),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  hint: 'Top Left Value',
                  controller: topLeftController,
                  onTextChange: (String value) {
                    topLeft = value;
                    maybeSave();
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
                    maybeSave();
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
                    maybeSave();
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
                    maybeSave();
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
              maybeSave();
              clearError();
            },
          ),
          AppTextField(
            hint: 'Description',
            controller: descriptionController,
            oneLine: false,
            onTextChange: (String value) {
              description = value;
              maybeSave();
              clearError();
            },
          ),
          AppTextField(
            hint: 'Image URL',
            controller: imageUrlController,
            onTextChange: (String value) {
              imageUrl = value;
              maybeSave();
              clearError();
            },
          ),
          VerticalSpace(panelSize.height * 0.03),
          if (imageUrl != null && imageUrl!.isNotEmpty)
            Expanded(
              child: Image.network(imageUrl!, errorBuilder: (context, _, __) {
                return AppText(label: 'Failed to load image');
              }),
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
                    boardProvider.addCardToTop(
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
                  label: 'Save Card',
                  onTap: () {
                    save();
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
