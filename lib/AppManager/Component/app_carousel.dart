import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AppCarousel extends StatelessWidget{
  const AppCarousel({super.key, this.height,required this.itemBuilder,required this.itemCount});
  final double? height;
  final  Widget Function(BuildContext, int, int)? itemBuilder;
  final int? itemCount;


  @override
  Widget build(BuildContext context) {
    return  CarouselSlider.builder(
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      //itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          // Container(
          //   margin: const EdgeInsets.all(5),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(15),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey.withOpacity(0.4), // Use a semi-transparent grey color
          //         spreadRadius: 0,
          //         blurRadius: 3,
          //         offset: const Offset(0, 2),
          //       )
          //     ]
          //   ),
          //   width: MediaQuery.of(context).size.width,
          //
          //   child: Center(child: Text(itemIndex.toString())),
          // ),
      options: CarouselOptions(
      height: height,
      aspectRatio: 16/9,
      viewportFraction: 1.0,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 4),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      scrollDirection: Axis.horizontal,
    ),
    );
  }
}