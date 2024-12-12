import 'package:flutter/material.dart';
import 'package:tarot/core/utils/size_config.dart';

class ExpandableText extends StatelessWidget {
  ExpandableText(
      {super.key,
      required this.isShowText,
      required this.titleText,
      required this.descriptionText});
  bool isShowText = false;
  final String titleText;
  final String descriptionText;
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      child: isShowText
          ? Padding(
              padding: EdgeInsets.all(
                SizeConfig.width(16),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      titleText,
                      style: TextStyle(
                          fontSize: SizeConfig.textSize(18),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: SizeConfig.height(12),
                    ),
                    Text(
                      descriptionText,
                      style: TextStyle(
                        fontSize: SizeConfig.textSize(15),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox(
              width: double.infinity,
              height: null,
            ),
    );
  }
}
