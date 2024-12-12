import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarot/core/data/cards_list.dart';
import 'package:tarot/core/utils/size_config.dart';
import 'package:tarot/core/widgets/show_card_details_sheet.dart';
import 'package:tarot/features/three_card_spread/cubit/three_card_cubit.dart';
import 'package:tarot/features/three_card_spread/cubit/three_card_state.dart';

class CardWidgetSpread extends StatefulWidget {
  const CardWidgetSpread(
      {super.key, required this.cardWidth, required this.cardNumber});
  final double cardWidth;
  final int cardNumber; // used only for indicator
  @override
  State<CardWidgetSpread> createState() => _CardWidgetSpreadState();
}

class _CardWidgetSpreadState extends State<CardWidgetSpread>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  AnimationStatus _status = AnimationStatus.dismissed;

  String titleText = "";
  String descriptionText = "";

  // randomly selected card index
  int selectedCardIndex = 0;

  late double cardWidth;
  bool isReversed = false; //card reversed or not
  bool isShowText = false; //Used to show card text data conditionally

  late ThreeCardCubit cubit;
  @override
  void initState() {
    cubit = context.read<ThreeCardCubit>();
    cardWidth = (SizeConfig.screenHeight / 3.3);
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween(end: 1.0, begin: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _status = status;
      });

    super.initState();
  }

  // This simple function selects random card and contorolls animation
  void onOpenCard() async {
    if (_status == AnimationStatus.dismissed) {
      selectedCardIndex = Random().nextInt(cards.length);

      if (cubit.cardsIdList.any((id) => id == cards[selectedCardIndex].id)) {
        onOpenCard(); // This help us to prevent card repetition
      } else {
        cubit.addToList(cards[selectedCardIndex].id);
      }

      isReversed = Random().nextBool();
      //precaching card image to flip card withount any blinkings
      await precacheImage(AssetImage(cards[selectedCardIndex].imgSrc), context);
      _controller.forward();
      titleText = isReversed
          ? 'REVERSED ${cards[selectedCardIndex].name.toUpperCase()}'
          : cards[selectedCardIndex].name;

      descriptionText = isReversed
          ? cards[selectedCardIndex].reversedDescription
          : cards[selectedCardIndex].description;

      setState(() {
        isShowText = true;
      });
    }
  }

  void reverseCard() {
    cubit.clearList();
    _controller.reverse();
  }

  void showCardDetails(BuildContext context, int cardIndex) {
    showCardDetailsSheet(context, cardIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ThreeCardCubit, ThreeCardState>(
      listener: (context, state) {
        if (state is ThreeCardUpdateValue) {
          reverseCard();
        }
      },
      child: SizedBox(
        // width: cardWidth,
        height: cardWidth,
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
                  ? GestureDetector(
                      onTap: () {
                        if (mounted) onOpenCard(); //
                      },
                      child: Stack(alignment: Alignment.center, children: [
                        Image.asset(
                          'assets/cards/back.jpg',
                          fit: BoxFit.fill,
                        ),
                        Positioned(
                            bottom: 12,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(186, 106, 57, 109),
                                  border: Border.all(
                                      color: const Color.fromARGB(255, 255, 255, 255),
                                      width: 1.5),
                                  borderRadius: BorderRadius.circular(200)),
                              child: Center(
                                child: Text(
                                  widget.cardNumber.toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )),
                      ]),
                    )
                  : InkWell(
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        showCardDetailsSheet(context, selectedCardIndex);
                      },
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
    );
  }
}
