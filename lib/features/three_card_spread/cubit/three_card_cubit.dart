import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarot/core/domain/card_model.dart';
import 'package:tarot/features/three_card_spread/cubit/three_card_state.dart';

class ThreeCardCubit extends Cubit<ThreeCardState> {
  ThreeCardCubit({required this.numberOfCards}) : super(ThreeCardInitial());
  int numberOfCards;
  List<int> cardsIdList = [];

  void clearList() {
    cardsIdList.clear();
  }

  void addToList(int cardId) {
    cardsIdList.add(cardId);
    if (cardsIdList.length == numberOfCards) {
      emit(ThreeCardCompleted());
    }
  }

  void updateList() {
    emit(ThreeCardUpdateValue());
  }
}
