import 'package:algorithmvisualizer/Pages/BinarySearchAlgo.dart';
import 'package:flutter/material.dart';

class LinearSearchAlgo extends StatefulWidget {

  static const routeName = '/linear-search-visualization';

  const LinearSearchAlgo({Key? key}) : super(key: key);

  @override
  State<LinearSearchAlgo> createState() => _LinearSearchAlgoState();
}

List<int> number = [];

class _LinearSearchAlgoState extends State<LinearSearchAlgo> {

  var inputList = TextEditingController();
  var inputTarget = TextEditingController();
  int currentIndex = 0;
  int answerIndex = -1;
  int notFoundAnswer = -2;

  Color currentIndexColor = Colors.amber;

  int target = 0;
  final bool _showResetButton = true;
  final bool _showSubmitButton = true;
   bool _showStartButton = false;

  Future<int> linearSearch() async {
    for (int i = 0; i < number.length; i++) {
      setState(() {
        currentIndex = i;
        currentIndexColor = (number[i] == target) ? Colors.green : Colors.red;
      });

      if (number[i] == target) {
        answerIndex = i;
        return answerIndex;
      }
      await Future.delayed(const Duration(seconds: 1));
    }
    setState(() {
      notFoundAnswer = -1;
      currentIndexColor = Colors.amber;
    });



    return notFoundAnswer;
  }
  void submit() {
    setState(() {
      _showStartButton = true;
      try {
        // Parse the input list
        List<String> inputItems = inputList.text.split(",");
        for (var item in inputItems) {
          number.add(int.parse(item.trim()));
        }
        inputItems.clear();
        inputList.clear();
      }
      catch (e) {
        number = [];
      }
    });
  }

  void reset() {
    _showStartButton = false;
    currentIndexColor = Colors.amber;
    inputTarget.clear();
    number.clear();
    answerIndex =-1;
    notFoundAnswer = -2;
  }


  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Linear Search Visualization'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                            borderSide: BorderSide(color: Colors.black),
                             borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                const Text(
                  ' Input Target Value : ',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    width: 70,
                    height: 50,
                    child: TextField(
                      controller: inputTarget,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            if (_showSubmitButton) // Only show the submit button if _showSubmitButton is true
              ElevatedButton(
                onPressed: submit,
                child: const Text('Submit'),
              ),
            const SizedBox(height: 20),
            Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                  ),
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
                          color: (index == currentIndex) ? currentIndexColor : Colors.amber,
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
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                if(_showStartButton)
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        try {
                          target = int.parse(inputTarget.text);
                        } catch (e) {
                          // Parsing failed, handle the error here
                          target = 0; // Set a default value for target
                        }
                        linearSearch();
                      });
                    },
                    child: const Text('Start Liner Search'),
                  ),
                ),
                const SizedBox(height: 40),
                if (answerIndex != -1 || notFoundAnswer == -1)
                  Column(
                    children: [
                      if (answerIndex != -1)
                        Text(
                          'Target found at index: $answerIndex',
                          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      if (notFoundAnswer == -1)
                        const Text(
                          'Target Value Does Not Exist in the array',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
