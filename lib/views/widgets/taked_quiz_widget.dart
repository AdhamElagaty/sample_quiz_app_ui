import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_quiz_app_ui/models/models/quiz_model/quiz_model.dart';
import 'package:sample_quiz_app_ui/models/models/taked_quiz_model/taked_quiz_model.dart';
import 'package:sample_quiz_app_ui/utils/app_style.dart';
import 'package:sample_quiz_app_ui/utils/helper.dart';
import 'package:sample_quiz_app_ui/views/answer_taked_quiz_view.dart';
import 'package:sample_quiz_app_ui/views/cubits/quiz_cubit/quiz_cubit.dart';
import 'package:sample_quiz_app_ui/views/cubits/taked_quize_cubit/taked_quize_cubit.dart';
import 'package:sample_quiz_app_ui/views/cubits/taked_quize_cubit/taked_quize_state.dart';
import 'package:sample_quiz_app_ui/views/cubits/task_quiz_cubit/take_quiz_cubit.dart';
import 'package:sample_quiz_app_ui/views/take_a_quiz_view.dart';
import 'package:sample_quiz_app_ui/views/widgets/custom_elevated_button_widget.dart';

class TakedQuizWidget extends StatelessWidget {
  const TakedQuizWidget({
    super.key,
    required this.takedQuizModel,
    required this.onLongPress,
  });

  final TakedQuizModel takedQuizModel;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(12),
        child: GestureDetector(
          onTap: () {
            BlocProvider.of<TakedQuizCubit>(context).changeExpantion();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: BlocConsumer<TakedQuizCubit, TakedQuizState>(
              listener: (context, state) async {},
              builder: (context, state) {
                if (state is TakedQuizInitial) {
                  BlocProvider.of<TakedQuizCubit>(context).takedQuizModel =
                      takedQuizModel;
                  BlocProvider.of<TakedQuizCubit>(context)
                      .getQuiz(takedQuizModel.quizId!);
                }
                return Column(
                  children: [
                    _buildQuizCard(),
                    _buildAnimatedExpansion(context),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizCard() {
    return Card(
      color: const Color(0xffABBFB8),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildQuizHeader(),
            _displayInformation("Name", takedQuizModel.personName!.trim()),
            _displayInformation(
                "Date", Helper.formatDate(takedQuizModel.dateTime!)),
            _displayInformation(
                "Time", Helper.formatTime(takedQuizModel.dateTime!)),
            _displayInformation("Score",
                "${takedQuizModel.score} / ${takedQuizModel.quiz!.questions!.length}"),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                "${takedQuizModel.quiz!.name!.trim()} Quiz",
                style: AppStyle.styleBold22.copyWith(fontSize: 26),
                maxLines: 2,
              ),
              Text(
                "${takedQuizModel.quiz!.questions!.length} Questions",
                style: AppStyle.styleBold22,
                maxLines: 2,
              ),
            ],
          ),
          Hero(
            tag: takedQuizModel.key ?? "quiz_logo",
            child: Image.asset(
              "assets/images/quiz_logo.png",
              width: 90,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedExpansion(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutBack,
      child: BlocProvider.of<TakedQuizCubit>(context).isExpanded
          ? AnimatedOpacity(
              opacity: BlocProvider.of<TakedQuizCubit>(context).isExpanded
                  ? 1.0
                  : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
                  children: [
                    CustomElevatedButtonWidget(
                      textName: BlocProvider.of<TakedQuizCubit>(context).state
                              is QuizLoading
                          ? "Loading ...."
                          : BlocProvider.of<TakedQuizCubit>(context)
                                      .quizModel ==
                                  null
                              ? "Quiz is Deleted 😔"
                              : "Take Quiz Again",
                      onPressed:
                          BlocProvider.of<TakedQuizCubit>(context).quizModel ==
                                  null
                              ? null
                              : () async {
                                  if (BlocProvider.of<TakedQuizCubit>(context)
                                          .quizModel !=
                                      null) {
                                    _navigateToTakeQuizView(
                                      context,
                                      BlocProvider.of<TakedQuizCubit>(context)
                                          .quizModel!,
                                      takedQuizModel.key,
                                    );
                                  }
                                },
                    ),
                    const SizedBox(height: 6),
                    CustomElevatedButtonWidget(
                      textName: "View My Answers",
                      onPressed: () {
                        _navigateToAnswerView(
                            context,
                            BlocProvider.of<TakedQuizCubit>(context)
                                .takedQuizModel!);
                      },
                    ),
                    const Icon(Icons.expand_more, color: Colors.white),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  void _navigateToTakeQuizView(
      BuildContext context, QuizModel quiz, int imageTag) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => TakeQuizCubit(),
          child: TakeAQuizView(
            quizModel: quiz,
            imageTag: imageTag,
          ),
        ),
      ),
    );
    // ignore: use_build_context_synchronously
    BlocProvider.of<QuizCubit>(context).getAllTakedQuizzes();
  }

  void _navigateToAnswerView(
      BuildContext context, TakedQuizModel takedQuizModel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => TakeQuizCubit(),
          child: AnswerTakedQuizView(
            takedQuizModel: takedQuizModel,
          ),
        ),
      ),
    );
  }

  Row _displayInformation(String title, String info) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$title:",
          style: AppStyle.styleBold22,
          maxLines: 2,
        ),
        Text(
          " $info",
          style: AppStyle.styleBold22.copyWith(fontWeight: FontWeight.w600),
          maxLines: 2,
        ),
      ],
    );
  }
}
