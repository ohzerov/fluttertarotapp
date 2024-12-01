import 'package:flutter/material.dart';
import 'package:tarot/core/data/cards_list.dart';
import 'package:tarot/core/utils/size_config.dart';
import 'dart:math';

import 'package:tarot/features/single_card_draw/presentation/widgets/expandable_text.dart';

class SingleCardWidget extends StatefulWidget {
  const SingleCardWidget({super.key, required this.cardWidth});
  final double cardWidth;
  @override
  State<SingleCardWidget> createState() => _SingleCardWidgetState();
}

class _SingleCardWidgetState extends State<SingleCardWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  AnimationStatus _status = AnimationStatus.dismissed;

  String appBarText = ""; // Picked card name
  String titleText = "";
  String descriptionText = "";
  // randomly selected card index
  late final int selectedCardIndex;

  // height of the card
  late double cardWidth;
  bool isReversed = false; // If card reversed or not
  bool isShowText = false; //Used to show card text data conditionally

  @override
  void initState() {
    cardWidth = SizeConfig.width(widget.cardWidth);
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween(end: 1.0, begin: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _status = status;
      });

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) onOpenCard(); // Here we are opening the card
    });

    super.initState();
  }

  // This simple function selects random card and contorolls animation
  void onOpenCard() async {
    if (_status == AnimationStatus.dismissed) {
      selectedCardIndex = Random().nextInt(cards.length);
      isReversed = Random().nextBool();
      appBarText =
          "${isReversed ? "REVERSED" : ""} ${cards[selectedCardIndex].name.toUpperCase()}";

      //precaching card image to flip card withount any blinkings
      await precacheImage(AssetImage(cards[selectedCardIndex].imgSrc), context);
      _controller.forward();
      titleText = isReversed
          ? 'REVERSED ${cards[selectedCardIndex].name.toUpperCase()}'
          : cards[selectedCardIndex].name;

      descriptionText = isReversed
          ? cards[selectedCardIndex].reversedDescription
          : cards[selectedCardIndex].description;

      appBarText = isReversed
          ? 'REVERSED ${cards[selectedCardIndex].name}'
          : cards[selectedCardIndex].name;
      setState(() {
        isShowText = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          SizedBox(
            width: cardWidth,
            child: AspectRatio(
              aspectRatio: 10 / 16,
              child: Transform(
                alignment: FractionalOffset.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.00055)
                  ..rotateY(pi * _animation.value),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(cardWidth * 0.15)),
                  child: _animation.value <=
                          0.5 //Here we are choosing which side of card t display based on animation value
                      ? Image.asset(
                          'assets/cards/back.jpg',
                          fit: BoxFit.fill,
                        )
                      : InkWell(
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {},
                          child: Transform.flip(
                            //This part reverses thhe card based on random bool value
                            flipX: true,
                            child: Transform.scale(
                              scaleY: isReversed ? -1 : 1,
                              child: Image.asset(
                                cards[selectedCardIndex].imgSrc,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.height(20),
          ),
          ExpandableText(
              isShowText: isShowText,
              titleText: titleText,
              descriptionText: descriptionText)
        ],
      ),
    );
  }
}
