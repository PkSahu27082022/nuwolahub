import 'package:flutter/material.dart';
import 'package:nuvolahub/Model/student_result_model.dart';
import 'package:nuvolahub/View/category_view.dart';
import 'package:nuvolahub/ViewModel/category_view_model.dart';
import 'package:nuvolahub/ViewModel/quiz_view_model.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key, this.studentResultList});
  final List<StudentResult>? studentResultList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoryView(),
                  ));
            },
            child: const Icon(Icons.arrow_back_ios)),
        title: const Text("Result"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
             StudentResult? result= studentResultList![index];
              return Card(
                surfaceTintColor: Colors.white,
                borderOnForeground: true,

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    children: [
                      TableRow(children: [
                        const Text("Student Name"),
                        Text(result.studentName ?? "")
                      ]),
                      TableRow(children: [
                        const Text("Paper Name"),
                        Text(result.paperName ?? "")
                      ]),
                      TableRow(children: [
                        const Text("Mark Obtained"),
                        Text(result.markObtained ?? "")
                      ]),
                      TableRow(children: [
                        const Text("Max Mark"),
                        Text(result.maxMark ?? "")
                      ]),
                      TableRow(children: [
                        const Text("Percentage"),
                        Text(result.percentage ?? "")
                      ]),
                      TableRow(children: [
                        const Text("Status"),
                        Text(result.status ?? '')
                      ])
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
            itemCount: studentResultList!.length),
      ),
    );
  }
}
