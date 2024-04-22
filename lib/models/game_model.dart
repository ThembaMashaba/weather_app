class Game {
  //Game score
  static int score = 0;

  //List of options
  static List<String> choices = ['Rock', 'Paper', 'Scissors'];
}

class Choice {
  String? type = '';
  //Map for game rules
  static var gameRules = {
    'Rock': {
      'Rock': 'Draw',
      'Paper': 'Lose',
      'Scissor': 'Win',
    },
    'Paper': {
      'Rock': 'Win',
      'Paper': 'Draw',
      'Scissor': 'Lose',
    },
    'Scissor': {
      'Rock': 'Lose',
      'Paper': 'Win',
      'Scissor': 'Draw',
    }
  };
  Choice(this.type);
}
