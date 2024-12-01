import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarot/core/data/cards_list.dart';
import 'package:tarot/core/utils/size_config.dart';
import 'package:tarot/features/three_card_spread/cubit/three_card_cubit.dart';
import 'package:tarot/features/three_card_spread/cubit/three_card_state.dart';
import 'package:tarot/main.dart';

class ThreeCardSpreadPage extends StatelessWidget {
  const ThreeCardSpreadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThreeCardCubit(numberOfCards: 3),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              Spacer(),
              BlocBuilder<ThreeCardCubit, ThreeCardState>(
                  builder: (context, state) {
                if (state is ThreeCardCompleted) {
                  return TextButton(
                    onPressed: () {
                      final cubit = context.read<ThreeCardCubit>();
                      cubit.updateList();
                    },
                    child: const Icon(
                      Icons.refresh_rounded,
                      size: 35,
                    ),
                  );
                } else {
                  return SizedBox(
                    width: 35,
                  );
                }
              }),
            ],
          ),
          body: SizedBox(
            width: double.infinity,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Spacer(),
                      CardWidgetSpread(
                        cardNumber: 1,
                        cardWidth: 150,
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CardWidgetSpread(
                        cardNumber: 2,
                        cardWidth: 150,
                      ),
                      SizedBox(
                        width: 32,
                      ),
                      CardWidgetSpread(cardNumber: 3, cardWidth: 150),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

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

  String appBarText = ""; // Picked card name
  String titleText = "";
  String descriptionText = "";

  // randomly selected card index
  int selectedCardIndex = 0;

  // height of the card
  late double cardWidth;
  bool isReversed = false; // If card reversed or not
  bool isShowText = false; //Used to show card text data conditionally

  late ThreeCardCubit cubit;
  @override
  void initState() {
    cubit = context.read<ThreeCardCubit>();
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

    // Future.delayed(const Duration(milliseconds: 300), () {
    //   if (mounted) onOpenCard(); // Here we are opening the card
    // });

    super.initState();
  }

  // This simple function selects random card and contorolls animation
  void onOpenCard() async {
    if (_status == AnimationStatus.dismissed) {
      selectedCardIndex = Random().nextInt(cards.length);

      if (cubit.cardsIdList.any((id) => id == cards[selectedCardIndex].id)) {
        onOpenCard();
      } else {
        cubit.addToList(cards[selectedCardIndex].id);
      }

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

  void reverseCard() {
    cubit.clearList();
    _controller.reverse();
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
                            bottom: 10,
                            // top: 1,
                            child: CircleAvatar(
                              child: Text(widget.cardNumber.toString()),
                            )),
                      ]),
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
    );
  }
}
