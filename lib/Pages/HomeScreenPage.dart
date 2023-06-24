import 'package:algorithmvisualizer/Pages/algoList.dart';
import 'package:algorithmvisualizer/responsive/responsive.dart';
import 'package:flutter/material.dart';

import '../Widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home-page';
  const HomeScreen({Key? key}) : super(key: key);

  void algolist(BuildContext context){
    Navigator.pushNamed(context, AlgoList.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:
          [

          const  Text(
              "Welcome To Algo Visualizer",
            style: TextStyle(fontSize: 30),
            ),


            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
                child: CustomButton(onTap: () => algolist(context), text: "Click Here To Proceed",))
          ],
        ),
      ),
    );
  }
}
