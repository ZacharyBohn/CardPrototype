import 'package:flutter/material.dart';
import 'package:game_prototype/enum/app_colors.dart';
import 'package:game_prototype/models/game_card.model.dart';

import 'app_text.dart';

class CardPreview extends StatelessWidget {
  final double width;
  final double height;
  final GameCardModel? card;
  const CardPreview({
    Key? key,
    required this.width,
    required this.height,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.hightlightPreviewBorder,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: card != null
          ? Stack(
              children: [
                //info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //top values
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: AppText(
                              label: card?.topLeft,
                            ),
                          ),
                          Expanded(
                            child: AppText(
                              label: card?.topRight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(
                      flex: 6,
                    ),
                    //bottom values
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: AppText(
                              label: card?.bottomLeft,
                            ),
                          ),
                          Expanded(
                            child: AppText(
                              label: card?.bottomRight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: AppColors.hightlightPreviewBorder,
                    ),
                    Expanded(
                      child: Center(
                        child: AppText(
                          label: card?.name,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: AppText(
                        label: card?.description,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                //image
                if (card?.imageUrl != null) Image.network(card!.imageUrl!),
              ],
            )
          : Container(),
    );
  }
}
