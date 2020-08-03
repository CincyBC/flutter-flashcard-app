import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'quiz_brain.dart';
import 'scorekeeper.dart';

QuizBrain quizBrain = QuizBrain();
ScoreKeeper scoreKeeper = ScoreKeeper();

class FlashCardPage extends StatefulWidget {
  @override
  _FlashCardPageState createState() => _FlashCardPageState();
}

class _FlashCardPageState extends State<FlashCardPage> {
  _renderBg() {
    return Container(
      decoration: BoxDecoration(color: Colors.white38),
    );
  }

  _renderContent(context) {
    return Card(
      elevation: 0.0,
      margin: EdgeInsets.only(left: 32.0, right: 32.0, top: 20.0, bottom: 0.0),
      color: Color(0x00000000),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        speed: 1000,
        onFlipDone: (status) {
          print(status);
        },
        front: Container(
          decoration: BoxDecoration(
            color: Color(0xFF006666),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        back: Container(
          decoration: BoxDecoration(
            color: Color(0xFF006666),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                quizBrain.getQuestionAnswer(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Dismissible(
        key: UniqueKey(),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            _renderBg(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: _renderContent(context),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
//                _renderButtonBar(context),
              ],
            )
          ],
        ),
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            // Right Swipe

            setState(() {
              scoreKeeper.checkAnswer(quizBrain.getQuestionNumber(), true);
            });

//            Scaffold.of(context).showSnackBar(SnackBar(content: Text("$item dismissed")));

          } else if (direction == DismissDirection.endToStart) {
            //Left Swipe
            setState(() {
              scoreKeeper.checkAnswer(quizBrain.getQuestionNumber(), false);
            }); //add event to Calendar
          }
        },
      ),
    );
  }
}
