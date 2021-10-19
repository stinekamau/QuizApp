import 'dart:io';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:quizing_app/model/failure_model.dart';

import 'base_quiz_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:quizing_app/enums/enum_file.dart';
import 'package:quizing_app/model/question_model.dart';




final dioProvider=Provider<Dio>((ref)=>Dio());
final quizRepositoryProvider=Provider<QuizRepository>((ref)=>QuizRepository(ref.read));

class QuizRepository extends  BaseQuizRepository
{
    //This allows  Reading of other Providers
    final Reader _read;

    QuizRepository(this._read);

    Future<List<Questions>> getQuestions(
        {
            required int numQuestions,
            required int categoryId,
            required Difficulty difficulty,
        }) async
    {
        try
        {
            final queryParameters={
                'type':'multiple',
                'amount':numQuestions,
                'categoryId':categoryId,
            };

            if (difficulty!=Difficulty.any)
            {
                queryParameters.addAll(
                    {'difficulty':EnumToString.convertToString(difficulty)}
                );
            }

            final response=await _read(dioProvider).get('https://opentdb.com/api.php',queryParameters:queryParameters);
            if(response.statusCode==200)
                {
                    final data=Map<String,dynamic>.from(response.data);
                    final results=List<Map<String,dynamic>>.from(data['results'] ??[]);

                    if (results.isNotEmpty)
                        {
                            return results.map((e)=>Questions.fromMap(e)).toList();

                        }

                } return [];

        }on DioError catch (err){
            throw Failure(message: err.response!.statusMessage);
        }on SocketException catch(err)
        {
            print(err);
            throw const Failure(message: 'Please check your connection'); 
        }
    }


}