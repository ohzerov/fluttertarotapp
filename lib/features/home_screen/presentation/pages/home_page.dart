import 'package:flutter/material.dart';
import 'package:tarot/core/widgets/button_text.dart';
import 'package:tarot/features/single_card_draw/presentation/pages/single_draw_page.dart';
import 'package:tarot/features/three_card_spread/three_card_spread_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SingleDrawPage()));
                },
                child: ButtonText(
                    text: 'Single Card', fontSize: 20, textColor: Colors.black),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ThreeCardSpreadPage()));
                  },
                  child: ButtonText(
                    text: 'Three Cards Spread',
                    fontSize: 20,
                    textColor: Colors.black,
                  )),
              TextButton(
                onPressed: () {},
                child: ButtonText(
                  text: 'Discover Cards',
                  fontSize: 20,
                  textColor: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: ButtonText(
                  text: 'History',
                  fontSize: 20,
                  textColor: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
