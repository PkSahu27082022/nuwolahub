
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget{
  const ImageCard({super.key, this.imageUrl,this.widget,this.elevation=0});
  final String? imageUrl;
  final Widget? widget;
  final double? elevation;


  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: elevation,
      color: Colors.grey.shade200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                    imageUrl!,
                    fit: BoxFit.fitWidth),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: widget,
            ),
          ),
          // const SizedBox(height: 6),
          // Text("No of Paper ${list.noOfPaper}",style: theme.titleSmall?.copyWith(color: Colors.black54)),
        ],
      ),
    );
  }
}