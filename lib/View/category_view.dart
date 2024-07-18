import 'package:flutter/material.dart';
import 'package:nuvolahub/AppManager/Component/app_carousel.dart';
import 'package:nuvolahub/AppManager/Component/image_card.dart';
import 'package:nuvolahub/Model/news_model.dart';
import 'package:nuvolahub/Model/user_model.dart';
import 'package:nuvolahub/View/Account/login_view.dart';
import 'package:nuvolahub/View/course_view.dart';
import 'package:nuvolahub/ViewModel/AccountVM/login_view_model.dart';
import 'package:nuvolahub/ViewModel/category_view_model.dart';
import 'package:nuvolahub/Model/category_model.dart';
import 'package:provider/provider.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    User user=LoginViewModel.of(context).user;
    CategoryViewModel categoryVM = CategoryViewModel.of(context);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName:Text(user.name??""),
              accountEmail:  Text(user.email??""),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
              child: Icon(Icons.people,color: Colors.grey.shade300,),
              ),
            ),
            ListTile(
              title: const Text('Result'),
              onTap: () {
                // Handle item 1 tap
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                      (Route<dynamic> route) => false, // Pop all routes
                );
              },
            ),
          ],
        ),
      ),
      appBar: buildAppBar(context),
      // bottomNavigationBar: BottomNavigationBar(
      //   elevation: 0,
      //   fixedColor: Colors.black87,
      //   backgroundColor: Colors.white24,
      //   items: const [
      //     BottomNavigationBarItem(
      //         label: "home", icon: Icon(Icons.home_outlined)),
      //     BottomNavigationBarItem(
      //         label: "Category", icon: Icon(Icons.category_outlined)),
      //     BottomNavigationBarItem(
      //         label: "Result", icon: Icon(Icons.file_copy_outlined))
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              const SizedBox(height: 20),
              AppCarousel(
                  height: 260,
                  itemCount: categoryVM.newsList.length,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    News list = categoryVM.newsList[itemIndex];
                    return ImageCard(
                      imageUrl: list.image,
                      widget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            list.subject ?? "",
                          ),
                          Text(
                            list.description ?? "",
                          ),
                        ],
                      ),
                    );
                  }),
              const SizedBox(height: 15),
              Container(
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    CircleAvatar(
                      radius: 33,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person_2_outlined,
                        color: Colors.grey.shade300,
                        size: 50,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(user.name??"")
                  ],
                ),
              ),
              const SizedBox(height: 15),
              GridView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: categoryVM.categoryList.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 3 / 2.5),
                  itemBuilder: (context, index) {
                    CategoryRecord list = categoryVM.categoryList[index];
                    return InkWell(
                      onTap: () {
                        categoryVM.selectedCourse=list;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CourseView(record: list)));
                      },
                      child: ImageCard(
                        elevation: 5,
                        imageUrl: list.imageUrl,
                        widget: Text(list.courseName ?? "",
                            style: theme.titleSmall?.copyWith(
                                color: Colors.black54,
                                fontWeight: FontWeight.w400)),
                      ),
                    );
                  }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.black87,
      backgroundColor: Colors.white24,
      elevation: 0,
      title: const Text("Category"),
    );
  }
}
