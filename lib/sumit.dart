import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Suggestions extends StatefulWidget {
  const Suggestions({Key? key}) : super(key: key);

  @override
  State<Suggestions> createState() => _SuggestionsState();
}

class _SuggestionsState extends State<Suggestions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
                left: 20,
                top: 70,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.menu),
                        color: Colors.white)
                  ],
                )),
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: 350,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/mountain.jpg'),
                  fit: BoxFit.cover,
                )),
              ),
            ),
            Positioned(
              top: 320,
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                // color: Colors.red,
                width: MediaQuery.of(context).size.width,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Textstyling(
                          text: "Title",
                          color: Colors.black.withOpacity(0.8),
                          size: 26,
                        ),
                        Textstyling(
                          text: "13-07-2002",
                          size: 18,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 70,
                            ),
                            Textstyling(
                              text: "User",
                              color: Colors.black.withOpacity(0.8),
                              size: 24,
                            )
                          ],
                        ),
                        // SizedBox(height: 10,),
                        Row(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Textstyling(
                              text: "Description :",
                              color: Colors.black.withOpacity(0.8),
                              size: 20,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Apptext(
                              text:
                                  "DArd hota hai dard hone do jakham gehra hai,use rehne do, aankhe roti hai unhe rone do, yaad aayi hai muzhe peene do :",
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 150,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.heart_broken,
                              size: 40,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: StadiumBorder(),
                              ),
                              onPressed: () {
                                // Add your button press logic here
                              },
                              child: Text('Acknowledge'),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Textstyling extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  final padding;

  Textstyling(
      {super.key,
      this.padding,
      this.size = 30,
      required this.text,
      this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: size, fontWeight: FontWeight.bold),
    );
  }
}

class Apptext extends StatelessWidget {
  double size;
  final String text;
  final Color color;

  Apptext(
      {super.key,
      this.size = 16,
      required this.text,
      this.color = Colors.black54});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        // fontWeight: FontWeight.bold
      ),
    );
  }
}
