import 'package:flutter/material.dart';
import 'package:quizing_app/model/question_model.dart';
import 'package:quizing_app/enums/enum_file.dart';





abstract class BaseQuizRepository
{

  Future<List<Questions>> getQuestions(
      {
        required int numQuestions,
        required int categoryId,
        required Difficulty difficulty,
      });

}