import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:quizing_app/model/question_model.dart';

enum QuizStatus{
  initial,correct,incorrect,complete
}

class QuizState extends Equatable
{
  final String selectedAnswer;
  final QuizStatus status;
  final List<Questions> correct;
  final List<Questions> incorrect;

  bool get answered=>
    status==QuizStatus.incorrect ||status==QuizStatus.correct;

  const QuizState({
    required this.selectedAnswer,
    required this.status,
    required this.correct,
    required this.incorrect,
});

  factory QuizState.initial()
  {
    return QuizState(selectedAnswer: "", status: QuizStatus.initial, correct: [], incorrect: []);
  }

  QuizState copyWith(
  {
     String? selectedAnswer,
      QuizStatus? status,
      List<Questions>? correct,
      List<Questions>? incorrect,
  }){
      return QuizState(selectedAnswer: selectedAnswer??this.selectedAnswer, status: status??this.status, correct: correct??this.correct, incorrect: incorrect??this.incorrect);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [selectedAnswer,status,correct,incorrect];

}