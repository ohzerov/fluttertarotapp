import 'package:flutter/material.dart';
import 'package:tarot/core/data/cards_list.dart';
import 'package:tarot/core/utils/size_config.dart';

void showCardDetailsSheet(BuildContext context, cardIndex) {
  showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.85,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(
                    width: double.infinity,
                  ),
                  Align(
                    child: Container(
                      decoration: const BoxDecoration(),
                      width: 300,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          cards[cardIndex].imgSrc,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(cards[cardIndex].name,
                      style: TextStyle(fontSize: SizeConfig.textSize(24))),
                  Text(cards[cardIndex].description,
                      style: TextStyle(fontSize: SizeConfig.textSize(16))),
                  const SizedBox(
                    height: 16,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(cards[cardIndex].reversedDescription,
                      style: TextStyle(fontSize: SizeConfig.textSize(16))),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
