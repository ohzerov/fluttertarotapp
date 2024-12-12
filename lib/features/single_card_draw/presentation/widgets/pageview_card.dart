import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarot/core/utils/size_config.dart';
import 'package:tarot/features/single_card_draw/providers/page_view_holder.dart';
import 'package:tarot/features/single_card_draw/presentation/pages/single_card_result_page.dart';

class CardPageViewPage extends StatefulWidget {
  final double number;

  const CardPageViewPage({
    super.key,
    required this.number,
  });

  @override
  State<CardPageViewPage> createState() => _PageState();
}

class _PageState extends State<CardPageViewPage> {
  @override
  Widget build(BuildContext context) {
    double value = Provider.of<PageViewHolder>(context).value;

    double diff = (widget.number - value);

    final double screenWidth = SizeConfig.screenWidth;
    final double aspectRatio = SizeConfig.screenWidth / SizeConfig.screenHeight;
    final double scaleFactor = screenWidth > 550 ? 1.5 : 0.95;

    final Matrix4 pvMatrix = Matrix4.identity()
      ..setEntry(3, 3, scaleFactor) // Adjust scale
      ..setEntry(1, 1, aspectRatio * 0.93) // Adjust Y-scale
      ..setEntry(3, 0, 0.002 * -diff); // Perspective

    return Transform(
      transform: pvMatrix,
      alignment: FractionalOffset.center,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const SingleCardResultPage()));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: AspectRatio(
            aspectRatio: 10 / 16,
            child: Image.asset(
              'assets/cards/back.jpg',
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
