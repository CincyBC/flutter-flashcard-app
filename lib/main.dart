import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
//import 'package:page_transition/page_transition.dart';

import 'question.dart';
import 'flashcard.dart';
import 'quiz_brain.dart';
//import 'Constants.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(StudyApp());
}

class StudyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    void choiceAction(String choice) {
//      if (choice == Constants.Import) {
//        print('Import');
//        loadAsset();
//        Navigator.push(
//          context,
//          PageTransition(
//            type: PageTransitionType.fade,
//            child: FlashScreen(),
//          ),
//        );
//      } else if (choice == Constants.Restart) {
//        {
//          Navigator.pushReplacement(
//            context,
//            PageRouteBuilder(
//              pageBuilder: (_, __, ___) => FlashCardPage(),
//              transitionDuration: Duration.zero,
//            ),
//          );
//        }
//      }
//    }

    return MaterialApp(
      title: 'Oeno Meleti',
      theme: ThemeData.light(),
      initialRoute: 'defaultpage',
      routes: <String, WidgetBuilder>{
        'defaultpage': (BuildContext context) => new DefaultPage(),
        'flashscreen': (BuildContext context) => new FlashScreen()
      },

//          actions: <Widget>[
//            PopupMenuButton<String>(
//              onSelected: choiceAction,
//              itemBuilder: (BuildContext context) {
//                return Constants.choices.map((String choice) {
//                  return PopupMenuItem<String>(
//                    value: choice,
//                    child: Text(choice),
//                  );
//                }).toList();
//              },
//            )
//          ],
    );
  }
}

class FlashScreen extends StatefulWidget {
  @override
  _FlashScreenState createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  String progress() {
    String firstNo = quizBrain.getQuestionNumber().toString();
    String breaker = ' / ';
    String secondNo = quizBrain.getQuestionBankLength().toString();
    return "Completed: " + firstNo + breaker + secondNo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(progress()),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: FlashCardPage(),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.red,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.close),
                        color: Colors.white,
                        onPressed: () {
                          scoreKeeper.checkAnswer(
                              quizBrain.getQuestionNumber(), false);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150.0,
                    width: 20.0,
                    child: VerticalDivider(color: Colors.teal.shade500),
                  ),
                  Expanded(
                    child: Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.green,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.check),
                        color: Colors.white,
                        onPressed: () {
                          scoreKeeper.checkAnswer(
                              quizBrain.getQuestionNumber(), true);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DefaultPage extends StatefulWidget {
  @override
  _DefaultPageState createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  bool loading = true;
  loadAsset() async {
    List<List<dynamic>> data = [];
    final myData = await rootBundle.loadString("assets/sample_questions.csv");
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);
    print('Starting');

    data = csvTable;
    quizBrain.eraseQuestionBank();
    for (var i = 0; i < data.length; i++) {
      print('Adding');
      quizBrain.questionBank.add(Question(data[i][0], data[i][1]));
    }
    print('Finished');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Center(
          child: Text('E-Z Flashcards'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text("Welcome to E-Z Flashcards!",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Center(
            child: RaisedButton(
              color: Colors.blue,
              onPressed: () {
                loadAsset().then(Navigator.pushNamed(context, 'flashscreen'));
              },
              child: Text('Import Cards to Start',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
