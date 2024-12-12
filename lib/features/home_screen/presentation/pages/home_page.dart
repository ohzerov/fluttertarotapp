import 'package:flutter/material.dart';
import 'package:tarot/core/utils/size_config.dart';
import 'package:tarot/features/all_cards/pages/all_cards_page.dart';
import 'package:tarot/features/single_card_draw/presentation/pages/single_draw_page.dart';
import 'package:tarot/features/three_card_spread/three_card_spread_page.dart';

class HomePage extends StatelessWidget {
  void navigateTo(Widget goTo, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => goTo));
  }

  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color.fromARGB(255, 0, 0, 0),
              Color.fromARGB(255, 66, 1, 112),
              Color.fromARGB(255, 0, 0, 0),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.width(16)),
            child: Center(
              child: SizedBox(
                child: Column(
                  spacing: SizeConfig.height(25),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomePageButton(
                        text: 'DRAW A CARD',
                        onTapFunction: () {
                          navigateTo(const SingleDrawPage(), context);
                        }),
                    HomePageButton(
                        text: 'THREE CARDS SPREAD',
                        onTapFunction: () {
                          navigateTo(const ThreeCardSpreadPage(), context);
                        }),
                    HomePageButton(
                        text: 'DISCOVER CARDS',
                        onTapFunction: () {
                          navigateTo(AllCardsPage(), context);
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePageButton extends StatelessWidget {
  const HomePageButton(
      {super.key, required this.text, required this.onTapFunction});
  final VoidCallback onTapFunction;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth - SizeConfig.width(100),
      child: TextButton(
          style: TextButton.styleFrom(
            overlayColor: const Color.fromARGB(255, 120, 13, 226),
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                  color: Color.fromARGB(255, 196, 122, 249), width: 2.5),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: onTapFunction,
          child: Container(
            margin: EdgeInsets.all(SizeConfig.height(10)),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: SizeConfig.textSize(16), color: Colors.white),
            ),
          )),
    );
  }
}
