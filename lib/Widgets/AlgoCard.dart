import 'package:algorithmvisualizer/Widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  final String text;
  final VoidCallback tap;

  const CardView({Key? key, required this.text , required this.tap}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final width  = MediaQuery.of(context).size.width;
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white70
          ),


          height: 80,
          width: width,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(text, style:  TextStyle(fontSize:  24 , fontWeight: FontWeight.w400),),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: SmallCustomButton(onTap: tap, text: " Click here"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
