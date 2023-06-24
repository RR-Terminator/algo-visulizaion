
import 'package:algorithmvisualizer/Pages/BinarySearchAlgo.dart';
import 'package:algorithmvisualizer/Pages/BubbleSort.dart';
import 'package:algorithmvisualizer/Pages/CycleSort.dart';
import 'package:algorithmvisualizer/Pages/InsertionSortAlgo.dart';
import 'package:algorithmvisualizer/Pages/LinearSearchPage.dart';
import 'package:algorithmvisualizer/Pages/SelectionSort.dart';
import 'package:algorithmvisualizer/Pages/algoList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Pages/HomeScreenPage.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Algorithm Visualizer",
    theme: ThemeData.light(),
    routes: {
      HomeScreen.routeName :(context) => const HomeScreen(),
      AlgoList.routeName : (context) => const AlgoList(),
      BinarySearchVisualization.routeName : (context) =>  BinarySearchVisualization(),
      LinearSearchAlgo.routeName : (context) => const LinearSearchAlgo(),
      BubbleSortAlgo.routeName : (context) => const BubbleSortAlgo(),
      InsertionSortAlgo.routeName : (context) => const InsertionSortAlgo(),
      SelectionSortAlgo.routeName : (context) => const SelectionSortAlgo(),
      CycleSortAlgo.routeName : (context) => const CycleSortAlgo(),

    },
    initialRoute: HomeScreen.routeName,
  ));
}