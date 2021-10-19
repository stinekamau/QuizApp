import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Questions extends Equatable
{
   final String type;
  final String category;
  final String difficulty;
  final String question;
  final  String correctAnswer;
  final List<String> answers;



    const Questions(
      {
        required this.type,
        required this.category,
        required this.difficulty,
        required this.question,
        required this.correctAnswer,
        required this.answers,

      }
      );




  @override
  // TODO: implement props
  List<Object?> get props => [

    type,category,difficulty,question,correctAnswer,answers,
  ];

  factory Questions.fromMap(Map<String,dynamic> map)
  {
      return Questions(
        type:map['type']??'',
        category:map['category'] ??'',
        difficulty:map['difficulty'] ?? '',
        question:map['question'] ??'',
        correctAnswer:map['correctAnswer']??'',
        answers: List<String>.from(map['incorrect_answers']??[])
          ..add(map['correct_answer']??'')
          ..shuffle(),

      );

  }
}
