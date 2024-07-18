import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuvolahub/Model/question_model.dart';
import 'package:nuvolahub/Model/question_option_model.dart';
import 'package:nuvolahub/ViewModel/category_view_model.dart';
import 'package:nuvolahub/ViewModel/quiz_view_model.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class QuizView extends StatefulWidget {
  const QuizView({super.key});

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  @override
  void initState() {
    get();
    super.initState();
  }

  get() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      QuizViewModel.of(context).callInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return PopScope(
      onPopInvoked: (didPop) {
        _showAlertPopup();
      },
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(
           maxLines: 2, CategoryViewModel.of(context).selectedCourse?.courseName ?? "",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            const Icon(Icons.access_time),
            Selector<QuizViewModel, String>(
              shouldRebuild: (previous, next) => true,
              selector: (p0, p1) => p1.updateDisplayTime(),
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Text( value,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black54)),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Selector<QuizViewModel, Question?>(
                        shouldRebuild: (previous, next) => true,
                        selector: (p0, p1) => p1.currentQuestion,
                        builder: (context, Question? data, child) => Row(
                          children: [
                            Text("Subject", style: theme.titleMedium),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              data?.subjectName ?? "",
                              style: theme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.pink.shade50,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // const SizedBox(height: 8),
                    Selector<QuizViewModel, Tuple2<int, Question?>>(
                        shouldRebuild: (previous, next) => true,
                        selector: (p0, p1) =>
                            Tuple2(p1.currentIndex + 1, p1.currentQuestion),
                        builder:
                            (context, Tuple2<int, Question?> data, child) {
                          Question? question = data.item2;
                          int qNum = data.item1;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Q.$qNum ', style: theme.titleMedium),
                                const SizedBox(width: 10),
                                Expanded(
                                    child: Text(
                                  question?.eQuestion ?? "",
                                  style: theme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.normal),
                                ))
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Consumer<QuizViewModel>(
                builder: (context, value, child) => Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(5)),
                  child: Selector<QuizViewModel, List<QuestionOption>>(
                    shouldRebuild: (previous, next) => previous != next,
                    selector: (context, quizViewModel) =>
                        quizViewModel.questionOptions,
                    builder: (context, options, child) => ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        QuestionOption option = options[index];
                        return _buildOptionRadioTile(context, option, value);
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 15),
                      itemCount: options.length,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Selector<QuizViewModel, int>(
                shouldRebuild: (previous, next) => true,
                selector: (p0, p1) => p1.currentIndex,
                builder: (context, int currentIndex, child) => Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: currentIndex != 0,
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              QuizViewModel.of(context)
                                  .moveToPreviousQuestion();
                            },
                            child: const Text('Previous'),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: currentIndex !=
                          QuizViewModel.of(context).questions.length - 1,
                      child: ElevatedButton(
                        onPressed: () {
                          QuizViewModel.of(context).moveToNextQuestion();
                        },
                        child: const Text('Next'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15),
          child: ElevatedButton(
            onPressed: (){
              QuizViewModel.of(context).finalSubmit();
            },
            child: const Text("Submit"),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionRadioTile(BuildContext context, QuestionOption option,
      QuizViewModel quizViewModel) {
    bool isSelected = quizViewModel.getSelectedOption(int.parse(quizViewModel.currentQuestion!.id.toString()))?.id==option.id;

    return RadioListTile<QuestionOption>(
      title: Text(option.optionTextEng ?? ""),
      value: option,
      groupValue: isSelected ? option : null,
      // selected:  isSelected ,
      onChanged: (QuestionOption? value) {
        if (value != null) {
          quizViewModel.saveAnswerOfQuestion(option: option);
          quizViewModel.addSelectedOption(
              int.parse(quizViewModel.currentQuestion!.id.toString()), value);
        }
      },
    );
  }

  _showAlertPopup() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title:
                  const Icon(Icons.warning_amber, color: Colors.red, size: 50),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Are you sure?",
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 15),
                  Text(
                      "Do you want to close this paper? Once it is closed, it cannot come back to the same state.",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.normal)),
                ],
              ),
              actions: [
                OutlinedButton(onPressed: () {}, child: const Text("No")),
                OutlinedButton(onPressed: () {
                  QuizViewModel.of(context).paperCancel();
                }, child: const Text("Yes")),
              ],
            ));
  }



}
