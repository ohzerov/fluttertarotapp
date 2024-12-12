import 'package:flutter/material.dart';
import 'package:tarot/core/data/cards_list.dart';
import 'package:tarot/core/utils/size_config.dart';
import 'package:tarot/core/widgets/show_card_details_sheet.dart';

class AllCardsPage extends StatelessWidget {
  const AllCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("A L L  C A R D S"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: GridView.builder(
              itemCount: cards.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 10 / 16,
                  crossAxisCount: SizeConfig.screenWidth > 550 ? 3 : 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 16),
              itemBuilder: (_, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: GridViewCard(
                    index: index,
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class GridViewCard extends StatelessWidget {
  const GridViewCard({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showCardDetailsSheet(context, index),
      child: Image.asset(
        cards[index].imgSrc,
        fit: BoxFit.fill,
      ),
    );
  }
}
