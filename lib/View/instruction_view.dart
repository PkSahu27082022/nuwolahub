import 'package:flutter/material.dart';
import 'package:nuvolahub/View/quiz_view.dart';
import 'package:nuvolahub/ViewModel/category_view_model.dart';
import 'package:nuvolahub/ViewModel/paper_view_model.dart';
import 'package:provider/provider.dart';

class InstructionView extends StatelessWidget {
  const InstructionView({super.key});


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(

        title:   Text(CategoryViewModel.of(context).selectedCourse?.courseName??""),
        surfaceTintColor: Colors.white,
      ),
      bottomNavigationBar: Selector<PaperViewModel, bool>(
        shouldRebuild: (previous, next) => true,
        selector: (p0, p1) => p1.isReadInstruction,
        builder: (context, bool isRead, child) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                      value: isRead,
                      onChanged: (val) {
                        if (val != null) {
                          PaperViewModel.of(context).isReadInstruction =
                              val;
                        }
                      }),
                  const SizedBox(width: 10),
                  const Text("Are you read it carefully?"),
                ],
              ),
              isRead
                  ? OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QuizView()));
                  },
                  child: const Text("Next"))
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text("Instructions", style: theme.headlineMedium),
              const SizedBox(height: 8),
              Text(
                "Please read the instructions carefully",
                style: theme.titleLarge?.copyWith(fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 10),
              Text("General Instruction", style: theme.titleLarge),
              const SizedBox(height: 8),
              _buildNormalText(
                  leadingSymbol: "1.",
                  data: "Total duration of examination is 60 minutes."),
              const SizedBox(height: 8),
              _buildNormalText(
                  leadingSymbol: "2.",
                  data:
                      "The clock will be set at the server. The countdown timer in the top right corner of screen will display the remaining time available for you to complete the examination. When the timer reaches zero, the examination will end by itself. You will not be required to end or submit your examination."),
              const SizedBox(height: 8),
              Text(
                "The Marked for Review status for a question simply indicates that you would like to look at that question again.",
                style: theme.titleLarge?.copyWith(fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 8),
              _buildNormalText(
                  leadingSymbol: "3.",
                  data:
                      'You can click on the ">" arrow which appears to the left of question palette to collapse the question palette thereby maximizing the question window. To view the question palette again, you can click on "< " which appears on the right side of question window.'),
              const SizedBox(height: 8),
              _buildNormalText(
                  leadingSymbol: "4.",
                  data:
                      'You can click on your "Profile" image on top right corner of your screen to change the language during the exam for entire question paper. On clicking of Profile image you will get a drop-down to change the question content to the desired language.'),
              const SizedBox(height: 8),
              _buildNormalText(
                  leadingSymbol: "5.",
                  data:
                      "You can click on  Scroll Down to navigate to the bottom and  Scroll Upto navigate to the top of the question area, without scrolling.Navigating to a Question:"),
              const SizedBox(height: 8),
              _buildNormalText(
                  leadingSymbol: "6.",
                  data: "To answer a question, do the following:"),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNormalText(
                        leadingSymbol: "A)",
                        data:
                            "Click on the question number in the Question Palette at the right of your screen to go to that numbered question directly. Note that using this option does NOT save your answer to the current question."),
                    _buildNormalText(
                        leadingSymbol: "B)",
                        data:
                            "Click on Save & Next to save your answer for the current question and then go to the next question."),
                    _buildNormalText(
                        leadingSymbol: "C)",
                        data:
                            "Click on Mark for Review & Next to save your answer for the current question, mark it for review, and then go to the next question."),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              _buildNormalText(
                  leadingSymbol: "7.",
                  data:
                      "Procedure for answering a multiple choice type question:"),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNormalText(
                        leadingSymbol: "A)",
                        data:
                            "To select your answer, click on the button of one of the options"),
                    _buildNormalText(
                        data:
                            "To deselect your chosen answer, click on the button of the chosen option again or click on the Clear Response button",
                        leadingSymbol: "B)"),
                    _buildNormalText(
                        leadingSymbol: "C)",
                        data:
                            "To change your chosen answer, click on the button of another option"),
                    _buildNormalText(
                        leadingSymbol: "D)",
                        data:
                            "To save your answer, you MUST click on the Save & Next button"),
                    _buildNormalText(
                        leadingSymbol: "E)",
                        data:
                            "To mark the question for review, click on the Mark for Review & Next button.")
                  ],
                ),
              ),
              const SizedBox(height: 8),
              _buildNormalText(
                  leadingSymbol: "8",
                  data:
                      "To change your answer to a question that has already been answered, first select that question for answering and then follow the procedure for answering that type of question.Navigating through sections:"),
              const SizedBox(height: 8),
              _buildNormalText(
                  leadingSymbol: "9.",
                  data:
                      "Sections in this question paper are displayed on the top bar of the screen. Questions in a section can be viewed by clicking on the section name. The section you are currently viewing is highlighted."),
              const SizedBox(height: 8),
              _buildNormalText(
                  leadingSymbol: "10.",
                  data:
                      "After clicking the Save & Next button on the last question for a section, you will automatically be taken to the first question of the next section."),
              const SizedBox(height: 8),
              _buildNormalText(
                  leadingSymbol: "11.",
                  data:
                      "You can shuffle between sections and questions anytime during the examination as per your convenience only during the time stipulated."),
              const SizedBox(height: 8),
              _buildNormalText(
                  leadingSymbol: "12.",
                  data:
                      "Candidate can view the corresponding section summary as part of the legend that appears in every section above the question palette."),
              const SizedBox(height: 8),
              _buildNormalText(
                  leadingSymbol: "13.",
                  data:
                      "To zoom the image provided in the question roll over it."),
              const SizedBox(height: 15),

            ],
          ),
        ),
      ),
    );
  }

  _buildNormalText({String? data, String? leadingSymbol}) {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: "$leadingSymbol ",
          style: const TextStyle(fontWeight: FontWeight.bold)),
      TextSpan(text: data ?? "")
    ]));
  }
}
