

import 'package:flutter/material.dart';

class CycleSortAlgo extends StatefulWidget {
  static String routeName = '/cycle-sort';

  const CycleSortAlgo({Key? key}) : super(key: key);

  @override
  State<CycleSortAlgo> createState() => _CycleSortAlgoState();
}

List<int> number = [];

class _CycleSortAlgoState extends State<CycleSortAlgo> {
  var inputList = TextEditingController();

  Color currentIndexColor = Colors.amber;
  Color correctIndexColor = Colors.amber;

  int currentIndex = 0;
  int correctIndex = -1;

  bool _showResetButton = false;
  bool _showSubmitButton = true;
  bool _showStartButton = false;

  void submit() {
    setState(() {
      _showSubmitButton = false;
      _showStartButton = true;
      try {
        List<String> inputItems = inputList.text.split(",");
        for (var item in inputItems) {
          number.add(int.parse(item.trim()));
        }
        inputItems.clear();
        inputList.clear();
      } catch (e) {
        number = [];
        _showResetButton = true;
        _showStartButton = false;
      }
    });
  }

  void reset() {
    number.clear();

    setState(() {
      correctIndex = 0;
      correctIndexColor = Colors.amber;
      currentIndex =-1;
      correctIndexColor = Colors.amber;
      _showResetButton = false;
      _showSubmitButton = true;
      _showStartButton = false;
    });
  }

  Future<void> cycleSort() async {
    int i = 0;

    while (i <= number.length) {
      setState(() {
        currentIndex = i;
        currentIndexColor = Colors.deepOrangeAccent;
      });
      int correctPos = number[i] - 1;



      if (number[i] != number[correctPos]) {

        setState(() {
          currentIndexColor = Colors.green;
          correctIndex = correctPos;
          correctIndexColor = Colors.greenAccent;
          int temp = number[i];
          number[i] = number[correctPos];
          number[correctPos] = temp;

        });

      }
      if(i==number.length-1) break;
      else {
        i++;
      }
      await Future.delayed(const Duration(seconds: 1));
    }
    setState(() {
      correctIndex = 0;
      currentIndex = 0;
      correctIndexColor = Colors.amber;
      currentIndexColor = Colors.amber;
      _showResetButton = true;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cycle Sort"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

             const Padding(
               padding:  EdgeInsets.only(top : 10, bottom: 40),
               child:  Text("Please Enter Number From Range 1 to N-1" , style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19),),
             ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Input Number List : ',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.black),
                    //   borderRadius: BorderRadius.circular(15)
                    // ),
                    height: 60,
                    child: SingleChildScrollView(
                      child: TextField(
                        controller: inputList,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter numbers separated from Comma",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_showSubmitButton == true)
              ElevatedButton(
                onPressed: submit,
                child: const Text('Submit'),
              ),
            const SizedBox(
              height: 30,
            ),
            GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5),
                itemCount: number.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                            color: index == currentIndex
                                ? currentIndexColor
                                : index == correctIndex
                                ? correctIndexColor
                                : Colors.amber,
                        ),
                        child: Center(
                          child: Text(
                            number[index].toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ));
                }),
            if (_showStartButton)
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      cycleSort();
                    });
                  },
                  child: const Text('Start Selection Sort'),
                ),
              ),
            const SizedBox(height: 40),
            if (_showResetButton)
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      reset();
                    });
                  },
                  child: const Text('Click here to reset'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
