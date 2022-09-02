import 'package:flutter/material.dart';
import 'package:quizzer/QuizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzer());

class Quizzer extends StatelessWidget {
  const Quizzer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Quiz(),
          ),
        ),
      ),
    );
  }
}

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {

  QuizBrain quizBrain = QuizBrain();

  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer){
    bool correctAnswer =quizBrain.getCorrectAnswer();
    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
          context: context,
          type: AlertType.error,
          title: "Finished",
          desc: "You've reached the end of the quiz.",
        ).show();
        quizBrain.reset();
        scoreKeeper = [];
      }
      else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),);
        } else {
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),);
        }
        quizBrain.nextQuestion();
      }
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
      Expanded(
       flex: 5,
       child: Padding(
           padding: EdgeInsets.all(10.0),
            child: Center(
                child: Text(
                  quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
            ),
       ),
    ),
      Expanded(
       child:Padding(
        padding: const EdgeInsets.all(15.0),
         child: TextButton(
          style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.green,
      ),
           child: Text('True'),
           onPressed:(){
            checkAnswer(true);
         },
        ),
       ),
     ),
      Expanded(
       child: Padding(
        padding: const EdgeInsets.all(15.0),
         child: TextButton(
           style: TextButton.styleFrom(
           primary: Colors.white,
           backgroundColor: Colors.red,
          ),
          child: Text('False'),
           onPressed:(){
            checkAnswer(false);
      },
      ),
    ),
    ),
          Row(
            children: scoreKeeper,
          )
    ],
    );
  }
}



