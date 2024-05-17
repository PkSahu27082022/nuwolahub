import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuvolahub/Model/question_model.dart';
import 'package:nuvolahub/Model/question_option_model.dart';
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

  String _selectedOption = "data";
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return PopScope(
      onPopInvoked: (didPop) {
        _showAlertPopup();
      },
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column( 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Quiz",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Selector<QuizViewModel, int>(
                          shouldRebuild: (previous, next) => true,
                          selector: (p0, p1) => p1.remainingTime,
                          builder: (context, value, child) => Row(
                            children: [
                              Text("Timer :",
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              const SizedBox(width: 20),
                              Text(value.toString(),
                                  style: Theme.of(context).textTheme.titleLarge)
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
                      const SizedBox(height: 8),
                      Selector<QuizViewModel, Tuple2<int, Question?>>(
                          shouldRebuild: (previous, next) => true,
                          selector: (p0, p1) =>
                              Tuple2(p1.currentIndex + 1, p1.currentQuestion),
                          builder:
                              (context, Tuple2<int, Question?> data, child) {
                            Question? question = data.item2;
                            int qNum = data.item1;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Q.$qNum ', style: theme.titleMedium),
                                const SizedBox(width: 10),
                                Expanded(
                                    child: Text(
                                  question?.eQuestion ?? "",
                                  style: theme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.normal),
                                ))
                              ],
                            );
                          }),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(5)),
                  child: Selector<QuizViewModel, List<QuestionOption>>(
                    shouldRebuild: (previous, next) => true,
                    selector: (p0, p1) => p1.questionOption,
                    builder: (context, List<QuestionOption> data, child) =>
                        ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              QuestionOption option = data[index];
                              return _buildOptionRadioButton(
                                  option.optionTextEng.toString(),
                                  option.id.toString());
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 5),
                            itemCount: data.length),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        QuizViewModel.of(context).getPreviousQuestion();
                      },
                      child: const Text('Previous'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        QuizViewModel.of(context).getNextQuestion();
                      },
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionRadioButton(String optionText, String optionValue) {
    return Row(
      children: [
        Radio<String>(
          value: optionValue,
          groupValue: _selectedOption,
          onChanged: (value) {
            setState(() {
              _selectedOption = value!;
            });
          },
        ),
        Text(optionText),
      ],
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
                OutlinedButton(onPressed: () {}, child: const Text("Yes")),
              ],
            ));
  }
}
