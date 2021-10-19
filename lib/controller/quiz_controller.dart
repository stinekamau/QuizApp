import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizing_app/controller/quiz_state.dart';
import 'package:quizing_app/model/question_model.dart';

final QuizControllerProvider=StateNotifierProvider<QuizController>(
    (ref)=>QuizController(),
);

class QuizController extends StateNotifier<QuizState>
{
  QuizController():super(QuizState.initial());

  void submitAnswer(Questions currentQuestion,String answer)
  {
    if(state.answered) return;
    if(currentQuestion.correctAnswer==answer)
      {
        state=state.copyWith(selectedAnswer: answer, status: QuizStatus.correct, correct: state.correct..add(currentQuestion));
      }else
        {
          state=state.copyWith(
            selectedAnswer: answer,
            incorrect: state.incorrect..add(currentQuestion),
            status: QuizStatus.incorrect,
          );

        }
  }

  void nextQuestion(List<Questions> questions,int currentIndex)
  {

    state=state.copyWith(
      selectedAnswer: '',
      status: currentIndex+1<questions.length?QuizStatus.initial:QuizStatus.complete,
    );
  }

  void reset()
  {
    state=QuizState.initial();
  }
}