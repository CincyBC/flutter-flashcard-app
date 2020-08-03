import 'package:flutter/cupertino.dart';

import 'quiz_brain.dart';
import 'score.dart';

QuizBrain quizBrain = QuizBrain();

class ScoreKeeper extends ChangeNotifier {
  List<Score> scoreKeeper = [];

  void checkAnswer(int questionNumber, bool userPickedAnswer) {
    scoreKeeper.add(Score(questionNumber, userPickedAnswer));
    quizBrain.nextQuestion();
  }
}
