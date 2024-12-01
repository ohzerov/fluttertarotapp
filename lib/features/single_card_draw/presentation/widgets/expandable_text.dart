import 'package:flutter/material.dart';
import 'package:tarot/core/utils/size_config.dart';

class ExpandableText extends StatelessWidget {
  ExpandableText(
      {super.key,
      required this.isShowText,
      required this.titleText,
      required this.descriptionText});
  bool isShowText = false;
  String titleText;
  String descriptionText;
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      child: isShowText
          ? Padding(
              padding: const EdgeInsets.only(
                  left: 8, right: 8.0, top: 16, bottom: 64),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      titleText,
                      style: TextStyle(fontSize: SizeConfig.textSize(25)),
                    ),
                    SizedBox(
                      height: SizeConfig.height(12),
                    ),
                    Text(
                      descriptionText,
                      style: TextStyle(fontSize: SizeConfig.textSize(18)),
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
