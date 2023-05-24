import 'package:flutter/material.dart';
import 'package:udemy_app/data/questions.dart';
import 'package:udemy_app/questions_screen.dart';
import 'package:udemy_app/results_screen.dart';
import 'package:udemy_app/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final List<String> selectedAnswers = [];
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'question-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'result-screen';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidjet = StartScreen(switchScreen);
    if (activeScreen == 'question-screen') {
      screenWidjet = QuestionsScreen(onSelectAnswer: chooseAnswer);
    }
    if (activeScreen == 'result-screen') {
      screenWidjet = ResultScreen(
        chosenAnswers: selectedAnswers,
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 107, 15, 168),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidjet,
        ),
      ),
    );
  }
}
