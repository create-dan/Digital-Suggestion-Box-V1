// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CanteenGallery extends StatefulWidget {
  const CanteenGallery({super.key});

  @override
  _CanteenGalleryState createState() => _CanteenGalleryState();
}

class _CanteenGalleryState extends State<CanteenGallery> {
  late PageController _pageController;
  int _currentIndex = 0;

  final List<String> images = [
    "assets/img3.jpeg",
    "assets/img1.jpeg",
    "assets/img4.jpeg",
    "assets/img5.jpeg",
    "assets/img6.jpeg",
    "assets/img7.jpeg",
    "assets/img8.jpeg",
    "assets/img10.jpeg",
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage: _currentIndex, keepPage: false, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Canteen Gallery"),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2.0),
                    ),
                    child: Image.asset(
                      images[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _currentIndex != 0
              ? FloatingActionButton(
                  onPressed: () => _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut),
                  child: Icon(Icons.arrow_back),
                )
              : Container(),
          _currentIndex != images.length - 1
              ? FloatingActionButton(
                  onPressed: () => _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut),
                  child: Icon(Icons.arrow_forward),
                )
              : Container(),
        ],
      ),
    );
  }
}
