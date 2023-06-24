
import 'package:algorithmvisualizer/Pages/BubbleSort.dart';
import 'package:algorithmvisualizer/Pages/CycleSort.dart';
import 'package:algorithmvisualizer/Pages/InsertionSortAlgo.dart';
import 'package:algorithmvisualizer/Pages/LinearSearchPage.dart';
import 'package:algorithmvisualizer/Pages/SelectionSort.dart';
import 'package:flutter/material.dart';

import '../Widgets/AlgoCard.dart';
import 'BinarySearchAlgo.dart';

class AlgoList extends StatelessWidget {
  void binarySearch(BuildContext context){
    Navigator.pushNamed(context, BinarySearchVisualization.routeName);
  }

  static String routeName = '/algo-list';

  const AlgoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Algorithm List"),
      ),
      body: ListView(

        children: [
          CardView(text: "Cycle Sort", tap: () => CycleSort(context)),

          CardView(text: "Selection Sort", tap: () => SelectionSort(context)),
          CardView(text: "Insertion Sort", tap: () => InsertionSort(context)),
          CardView(text: "Bubble Sort", tap: () => BubbleSort(context)),
          
          CardView(text: "Linear Search", tap: () => LinearSearch(context)),
          CardView(text: "Binary Search", tap: ()=> binarySearch(context)),
        ],
      ),
    );
  }
}

void binarySearch(BuildContext context){
  Navigator.pushNamed(context, BinarySearchVisualization.routeName);
}

void LinearSearch(BuildContext context){
  Navigator.pushNamed(context, LinearSearchAlgo.routeName);
}

void BubbleSort(BuildContext context){
  Navigator.pushNamed(context, BubbleSortAlgo.routeName);
}

void InsertionSort(BuildContext context){
  Navigator.pushNamed(context, InsertionSortAlgo.routeName);
}

void SelectionSort(BuildContext context){
  Navigator.pushNamed(context, SelectionSortAlgo.routeName);
}

void CycleSort(BuildContext context){
  Navigator.pushNamed(context, CycleSortAlgo.routeName);
}