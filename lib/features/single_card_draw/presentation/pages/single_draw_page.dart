import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:tarot/features/single_card_draw/providers/page_view_holder.dart';
import 'package:tarot/features/single_card_draw/presentation/widgets/pageview_card.dart';

class SingleDrawPage extends StatefulWidget {
  @override
  State<SingleDrawPage> createState() => _SingleDrawPageState();
}

class _SingleDrawPageState extends State<SingleDrawPage>
    with TickerProviderStateMixin {
  late PageViewHolder pageViewHolder;
  late PageController pageCtrl;
  double viewPortFraction = 0.5;

  @override
  void initState() {
    super.initState();

    pageCtrl = PageController(initialPage: 10, viewportFraction: 0.5);

    pageViewHolder = PageViewHolder(value: 10);
    pageCtrl.addListener(() {
      pageViewHolder.setValue(pageCtrl.page);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("CHOOSE YOUR CARD"),
        ),
        body: ChangeNotifierProvider<PageViewHolder>.value(
          value: pageViewHolder,
          child: PageView.builder(
            itemCount: 25,
            controller: pageCtrl,
            itemBuilder: (context, index) {
              return CardPageViewPage(
                number: index.toDouble(),
              );
            },
          ),
        ));
  }
}
