import 'package:flutter/material.dart';

class ImageSliderScreen extends StatefulWidget {

  final String title, urlImage1, urlImage2, urlImage3, urlImage4, urlImage5;
  final String itemColor, userNumber, itemdescription, address, itemPrice;
  final double lat, lng;

  ImageSliderScreen({
    required this.title,
    required this.urlImage1,
    required this.urlImage2,
    required this.urlImage3,
    required this.urlImage4,
    required this.urlImage5,
    required this.itemColor,
    required this.userNumber,
    required this.itemdescription,
    required this.address,
    required this.itemPrice,
    required this.lat,
    required this.lng


  });
  @override
  State<ImageSliderScreen> createState() => _ImageSliderScreenState();
}

class _ImageSliderScreenState extends State<ImageSliderScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orangeAccent, Colors.pinkAccent],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.0,1.0],
              tileMode: TileMode.clamp,
            )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(title: const Text('Image Slider Screen'),),
        )
    );
  }
}
