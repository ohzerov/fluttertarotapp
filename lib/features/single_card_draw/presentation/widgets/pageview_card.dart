import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarot/features/single_card_draw/providers/page_view_holder.dart';
import 'package:tarot/features/single_card_draw/presentation/widgets/single_card.dart';
import 'package:tarot/features/single_card_draw/presentation/pages/single_card_result_page.dart';

class CardPageViewPage extends StatefulWidget {
  final double number;
  //final double fraction;
  const CardPageViewPage({
    super.key,
    required this.number,
    // required this.fraction,
  });

  @override
  State<CardPageViewPage> createState() => _PageState();
}

class _PageState extends State<CardPageViewPage> {
  @override
  Widget build(BuildContext context) {
    double value = Provider.of<PageViewHolder>(context).value;

    double diff = (widget.number - value);

    final Matrix4 pvMatrix = Matrix4.identity()
      ..setEntry(3, 3, 0.95) // Increasing Scale by 90%
      ..setEntry(1, 1, 0.83) // Changing Scale Along Y Axis
      ..setEntry(3, 0, 0.002 * -diff);

    return Align(
      child: SizedBox(
        height: 450,
        width: 300,
        child: Transform(
          transform: pvMatrix,
          alignment: FractionalOffset.center,
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SingleCardResultPage()));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                'assets/cards/back.jpg',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
