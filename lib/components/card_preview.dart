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
      child: card != null && card!.faceup
          ? Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          child: AppText(label: card!.topLeft),
                        ),
                        Flexible(
                          child: AppText(label: card!.name),
                        ),
                        Flexible(
                          child: AppText(label: card!.topRight),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: AppColors.hightlightPreviewBorder,
                  ),
                  Expanded(
                    flex: 9,
                    child: card?.hasImage == true
                        ? Center(
                            child: Image.network(card!.imageUrl!,
                                errorBuilder: (context, _, __) {
                              return AppText(label: 'Failed to load image');
                            }),
                          )
                        : Container(),
                  ),
                  Divider(
                    color: AppColors.hightlightPreviewBorder,
                  ),
                  Flexible(
                    child: AppText(
                      label: card!.descriptionAccent,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: SingleChildScrollView(
                      child: AppText(
                        label: card!.description,
                      ),
                    ),
                  ),
                  Divider(
                    color: AppColors.hightlightPreviewBorder,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          child: AppText(label: card!.bottomLeft),
                        ),
                        Flexible(
                          child: AppText(label: card!.bottomRight),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }
}
