import 'package:flutter/material.dart';
import 'package:nuvolahub/Model/category_model.dart';
import 'package:nuvolahub/Model/course_model.dart';
import 'package:nuvolahub/ViewModel/category_view_model.dart';
import 'package:nuvolahub/ViewModel/paper_view_model.dart';
import 'package:provider/provider.dart';

class CourseView extends StatefulWidget {
  const CourseView({super.key, required this.record});
  final CategoryRecord record;

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  @override
  void initState() {
    get();
    super.initState();
  }

  get() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      String? id = widget.record.id;
      CategoryViewModel.of(context).getCourse(courseId: id ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
   // final categoryVM = CategoryViewModel.of(context);
    final theme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title:  Text(widget.record.courseName??""),
          backgroundColor: Colors.white24,
          elevation: 0,
          foregroundColor: Colors.black87,
        ),
        body: Selector<CategoryViewModel,List<Course>>(
          shouldRebuild: (previous, next) => true,
          selector: (p0, p1) => p1.courseList,
          builder: (context,List<Course> data, child) => ListView.separated(
              itemBuilder: (context, index) {
                Course course = data[index];
                return InkWell(
                  onTap: (){
                    PaperViewModel.of(context).getSubject(course: course);
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => const QuizView()));
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(TextSpan(children: [
                                const TextSpan(
                                  text: "Paper Name  ",
                                ),
                                TextSpan(
                                    text: course.paperName,
                                    style: theme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.red.shade500)),
                              ])),
                              Text.rich(TextSpan(children: [
                                const TextSpan(
                                  text: "Total Mark  ",
                                ),
                                TextSpan(
                                    text: course.totalMarks,
                                    style: theme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.red.shade500)),
                              ])),

                            ],
                          ),
                          const SizedBox(height: 5),
                          Text.rich(TextSpan(children: [
                            const TextSpan(
                              text: "Duration  ",
                            ),
                            TextSpan(
                                text: "${course.duration} min",
                                style: theme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.red.shade500)),
                          ])),
                          const SizedBox(height: 5),
                          Text.rich(TextSpan(children: [
                            const TextSpan(
                              text: "Total No. of Q.  ",
                            ),
                            TextSpan(
                                text: course.noOfQuestion,
                                style: theme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.red.shade500)),
                          ])),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              itemCount: data.length),
        ));
  }
}
