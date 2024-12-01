import 'package:tarot/core/domain/card_model.dart';

List<CardModel> cards = [
  CardModel(
    id: 1,
    name: "The Fool",
    description:
        "The Fool signals a fresh start or a new chapter in your life. It encourages you to take bold steps, trust your instincts, and follow your heart without overthinking the risks. This card is about letting go of fear, embracing curiosity, and allowing yourself to grow through experiences. While it celebrates freedom and spontaneity, it also reminds you to stay mindful and avoid recklessness.",
    reversedDescription:
        "The reversed Fool cautions against impulsive or naive decisions. It suggests hesitation, fear of the unknown, or an unwillingness to take risks. It may also warn of carelessness, poor judgment, or neglecting important details. The reversed Fool urges you to pause and reconsider your path, ensuring your enthusiasm does not lead to avoidable mistakes.",
    imgSrc: 'assets/cards/card2.jpg',
  ),
  CardModel(
    id: 2,
    name: "Empress",
    description:
        "The Empress is a symbol of love, fertility, and creation. She encourages you to nurture yourself and others while celebrating life’s pleasures. This card may suggest a time of abundance, creative inspiration, or the manifestation of your efforts. It also reminds you to connect with nature and honor your intuition.",
    reversedDescription:
        "The reversed Empress indicates a lack of nurturing or an imbalance in giving and receiving. You may feel blocked creatively or disconnected from your emotional and physical needs. This card can also suggest over-dependence on others or neglecting your self-care in favor of external demands.",
    imgSrc: 'assets/cards/card3.jpg',
  ),
  CardModel(
    id: 3,
    name: "Death",
    description:
        "Death signifies transformation and the release of what no longer serves you. It marks a profound ending, clearing the way for new opportunities and personal growth. Embrace this time of change, as it allows for a rebirth into something greater. The process may feel challenging, but it leads to deeper understanding and renewal.",
    reversedDescription:
        "The reversed Death suggests resistance to change or fear of letting go. You may be clinging to something that has reached its natural conclusion, which could lead to stagnation or unnecessary suffering. This card urges you to confront your fears and embrace the inevitable, even if it feels difficult.",
    imgSrc: 'assets/cards/card1.jpg',
  ),
];
