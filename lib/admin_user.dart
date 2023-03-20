import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieButtonsScreen extends StatelessWidget {
  const LottieButtonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/wc.json',height: 500),
            // SizedBox.fromSize(size: Size(20,20 ),),
            Column(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 25,right: 25),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[400],
                      padding: const EdgeInsets.all(10),
                      textStyle: const TextStyle(fontSize: 24),
                      shape: StadiumBorder(),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Lottie.asset(
                        //   'assets/lottie/admin.json',
                        //   width: 30,
                        //   height: 30,
                        //   fit:BoxFit.fill,
                        //
                        // ),
                        // const SizedBox(width: 16),
                         Center(child: Text('Admin')),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding:  EdgeInsets.only(left: 25,right: 25),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding:  EdgeInsets.all(10),
                      textStyle: const TextStyle(fontSize: 24),
                      shape: StadiumBorder(),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Center(child: Text('User')),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
