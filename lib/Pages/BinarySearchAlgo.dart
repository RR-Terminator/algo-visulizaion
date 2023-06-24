import 'package:flutter/material.dart';

class BinarySearchVisualization extends StatefulWidget {
  static const routeName = '/binary-search-visualization';

  @override
  _BinarySearchVisualizationState createState() =>
      _BinarySearchVisualizationState();
}

List<int> sortedList = [];

class _BinarySearchVisualizationState extends State<BinarySearchVisualization> {
  var inputTarget = TextEditingController();
  var inputList = TextEditingController();

  int target = 0;
  int low = 0;
  int high = 0;
  int mid = 0;

  Color leftBoxColor = Colors.red;
  Color rightBoxColor = Colors.red;
  Color midBoxColor = Colors.green;
  Color targetBoxColor = Colors.blue;
  int answerIndex = -1;
  int notFoundAnswer = -2;

  bool _showResetButton = true;
  bool _showSubmitButton = true;
  bool _showStartButton = false;

  Future<int> binarySearch() async {
    int left = 0;
    int right = sortedList.length - 1;

    while (left <= right) {
      mid = (left + right) ~/ 2;

      if (sortedList[mid] == target) {
        setState(() {
          answerIndex = mid;
          midBoxColor = Colors.purple;
          if (mid == left) {
            leftBoxColor = Colors.purple;
            rightBoxColor = Colors.amber;
          } else if (mid == right) {
            rightBoxColor = Colors.purple;
            leftBoxColor = Colors.amber;
          }
        });

        return mid;
      } else if (sortedList[mid] < target) {
        setState(() {
          left = mid + 1;
          low = left;
          rightBoxColor = Colors.red;
        });
      } else {
        setState(() {
          right = mid - 1;
          high = right;
          leftBoxColor = Colors.red;
        });
      }

      await Future.delayed(const Duration(seconds: 1));
    }
    setState(() {
      notFoundAnswer = -1;
    });
    return notFoundAnswer;
  }

  void reset() {
    setState(() {
      _showStartButton = false;
      sortedList.clear(); // Clear the sorted list
      low = 0;
      high = sortedList.length - 1;
      mid = (low + high) ~/ 2;
      leftBoxColor = Colors.redAccent;
      rightBoxColor = Colors.redAccent;
      targetBoxColor = Colors.amber;

      midBoxColor = Colors.green;
      _showResetButton = true; // Reset button becomes visible again
      _showSubmitButton = true;
      answerIndex = -1; // Reset answerIndex
      notFoundAnswer = -2; // Reset notFoundAnswer
      inputTarget.clear();
      sortedList.clear();
    });
  }

  void submit() {
    setState(() {
      _showStartButton = true;
      try {
        // Parse the input list
        List<String> inputItems = inputList.text.split(",");
        for (var item in inputItems) {
          sortedList.add(int.parse(item.trim()));
        }
        low = 0;
        high = sortedList.length - 1;
        mid = low + high ~/ 2;
        sortedList.sort();
        inputItems.clear();
        inputList.clear();
      } catch (e) {
        sortedList = []; // Set an empty list
      }
      _showSubmitButton = false; // Hide the submit button after it's clicked
    });
  }

  @override
  Widget build(BuildContext context) {
    int middleIndex = (low + high) ~/ 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Binary Search Visualization'),
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
                  'Input Sorted List : ',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 60,
                    child: SingleChildScrollView(
                      child: TextField(
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300),
                        controller: inputList,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
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
                    height: 40,
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
            const SizedBox(height: 30),
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
                  itemCount: sortedList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                          color: index == low
                              ? leftBoxColor
                              : index == high
                                  ? rightBoxColor
                                  : index == middleIndex
                                      ? midBoxColor
                                      : index == answerIndex
                                          ? targetBoxColor
                                          : Colors.amber,
                        ),
                        child: Center(
                          child: Text(
                            sortedList[index].toString(),
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
                        binarySearch();
                      });
                    },
                    child: const Text('Start Binary Search'),
                  ),
                ),
                const SizedBox(height: 40),
                if (answerIndex != -1 || notFoundAnswer == -1)
                  Column(
                    children: [
                      if (answerIndex != -1)
                        Text(
                          'Target found at index: $answerIndex',
                          style: const TextStyle(fontSize: 25),
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
