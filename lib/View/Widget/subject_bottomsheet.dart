import 'package:flutter/material.dart';
import 'package:nuvolahub/AppManager/Component/App_theme_button.dart';
import 'package:nuvolahub/AppManager/Helper/bottomsheet.dart';
import 'package:nuvolahub/Model/course_model.dart';
import 'package:nuvolahub/Model/subject_model.dart';
import 'package:nuvolahub/View/instruction_view.dart';
import 'package:nuvolahub/ViewModel/paper_view_model.dart';
import 'package:provider/provider.dart';

class SubjectBottomSheet {
  static show(BuildContext context, {Course? course}) {
   // final theme = Theme.of(context).textTheme;
    AppBottomSheet.open(context, tittle: course?.paperName ?? "", children: [
      Selector<PaperViewModel, List<Subject>>(
        shouldRebuild: (previous, next) => true,
        selector: (p0, p1) => p1.subject,
        builder: (context, List<Subject> data, child) => ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            Subject subject = data[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(subject.subjectName ?? ""),
                  leading: Text("${index + 1}."),
                )
              ],
            );
          },
        ),
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          Expanded(
            child: TextButtonTheme(
                data: AppButtonTheme.primary,
                child: TextButton(
                  onPressed: () {
                    PaperViewModel.of(context).isReadInstruction=false;
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const InstructionView()));
                  },
                  child: const Text("Start Test"),
                )),
          ),
          const SizedBox(height: 10),
        ],
      ),
    ]);
  }
}
