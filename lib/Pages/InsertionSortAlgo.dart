import 'package:flutter/material.dart';

class InsertionSortAlgo extends StatefulWidget {
  static String routeName = '/insertion-sort';

  const InsertionSortAlgo({Key? key}) : super(key: key);

  @override
  State<InsertionSortAlgo> createState() => _InsertionSortAlgoState();
}

List<int> number = [];

class _InsertionSortAlgoState extends State<InsertionSortAlgo> {
  var inputList = TextEditingController();

  bool _showResetButton = false;
  bool _showsubmitButton = true;
  bool _showStartButton = false;

  Color currentIndexColor = Colors.amber;
  Color currentIndexColor2 = Colors.amber;

  int currIndex = 0;
  int currIndexNext = 1;

  void submit() {
    setState(() {
      _showsubmitButton = false;
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
      }
    });
  }

  void reset() {
    number.clear();
    currIndex = 0;
    currIndexNext = 1;
    setState(() {
      _showResetButton = false;
      _showsubmitButton = true;
      _showStartButton = false;
    });
  }

  Future<void> insertionSort() async {
    for (int i = 0; i < number.length - 1; i++) {
      for (int j = i + 1; j > 0; j--) {

        setState(() {
          currIndex = j;
          currIndexNext = j-1;
          currentIndexColor2 = Colors.greenAccent;
          currentIndexColor = Colors.greenAccent;
        });

        if (number[j] < number[j - 1]) {
          setState(() {



            currentIndexColor = Colors.redAccent;
            currentIndexColor2 = Colors.redAccent;

            int temp = number[j];
            number[j] = number[j - 1];
            number[j - 1] = temp;


          });
        }
        else{
          await Future.delayed(const Duration(seconds: 1));
          break;
        }

        await Future.delayed(const Duration(seconds: 1));
      }
    }
    setState(() {
      currentIndexColor = Colors.amber;
      currentIndexColor2 = Colors.amber;
      _showResetButton = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Insertion Sort"),
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
                )
              ],
            ),
            const SizedBox(height: 20),
            if (_showsubmitButton == true)
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
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                          color: index == currIndex
                              ? currentIndexColor
                              : index == currIndexNext
                                  ? currentIndexColor2
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
            const SizedBox(height: 20),
            if (_showStartButton)
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      insertionSort();
                    });
                  },
                  child: const Text('Start insertion Sort'),
                ),
              ),
            const SizedBox(
              height: 40,
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
              )
          ],
        ),
      ),
    );
  }
}
