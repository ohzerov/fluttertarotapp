import 'package:flutter/material.dart';
import 'package:tarot/core/data/cards_list.dart';
import 'package:tarot/core/utils/size_config.dart';
import 'package:tarot/features/single_card_draw/presentation/widgets/expandable_text.dart';
import 'package:tarot/features/single_card_draw/presentation/widgets/single_card.dart';

class SingleCardResultPage extends StatefulWidget {
  @override
  State<SingleCardResultPage> createState() => _SingleCardResultPageState();
}

class _SingleCardResultPageState extends State<SingleCardResultPage> {
  bool _isShowText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                  onTap: () {
                    setState(() {});
                    _isShowText = !_isShowText;
                  },
                  child: SingleCardWidget(cardWidth: 270)),
            ],
          ),
        ),
      ),
    );
  }
}
