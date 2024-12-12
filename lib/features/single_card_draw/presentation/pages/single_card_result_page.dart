import 'package:flutter/material.dart';
import 'package:tarot/features/single_card_draw/presentation/widgets/single_card.dart';

class SingleCardResultPage extends StatefulWidget {
  const SingleCardResultPage({super.key});
  @override
  State<SingleCardResultPage> createState() => _SingleCardResultPageState();
}

class _SingleCardResultPageState extends State<SingleCardResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: const SingleCardWidgetMobile(
        cardWidth: 270,
      ),
    );
  }
}
