import 'package:flutter/material.dart';

class AppBottomSheet {
  static open(BuildContext context,
      {List<Widget> children = const <Widget>[],
       String? tittle
      }) {
    final theme = Theme.of(context).textTheme;

    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.black12,
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      offset: const Offset(1, 2),
                      spreadRadius: 2,
                      blurRadius: 1)
                ],
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 50,
                  child: Center(
                      child: Text(
                    tittle??"",
                    style: theme.titleLarge?.copyWith(
                        color: Colors.black54, fontWeight: FontWeight.w500),
                  )),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: Column(children: children),
                )
              ],
            ),
          );
        });
  }
}
