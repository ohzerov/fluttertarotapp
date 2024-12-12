import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarot/features/three_card_spread/cubit/three_card_cubit.dart';
import 'package:tarot/features/three_card_spread/cubit/three_card_state.dart';
import 'package:tarot/features/three_card_spread/spread_card_widget.dart';

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
              const Spacer(),
              BlocBuilder<ThreeCardCubit, ThreeCardState>(
                  builder: (context, state) {
                if (state is ThreeCardCompleted) {
                  return TextButton(
                    onPressed: () {
                      context.read<ThreeCardCubit>().updateList();
                    },
                    child: const Icon(
                      Icons.refresh_rounded,
                      size: 35,
                    ),
                  );
                } else {
                  return const SizedBox(
                    width: 35,
                  );
                }
              }),
            ],
          ),
          body: const SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 25),
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
