import 'package:flutter/material.dart';

class BubbleSortAlgo extends StatefulWidget {
  static String routeName = '/bubble-sort';

  const BubbleSortAlgo({Key? key}) : super(key: key);

  @override
  State<BubbleSortAlgo> createState() => _BubbleSortAlgoState();
}

List<int> number = [];

class _BubbleSortAlgoState extends State<BubbleSortAlgo> {
  var inputList = TextEditingController();
  var inputTarget = TextEditingController();

  Color currentIndexColor = Colors.amber;
  Color currentIndexColor2 = Colors.amber;

  bool _showResetButton = false;
  bool _showsubmitButton = true;
  bool _showStartButton = false;


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

  Future<void> bubbleSort() async {
    bool swap = false;
    for (int i = 0; i < number.length; i++) {
      for (int j = 0; j < number.length - i - 1; j++) {
        setState(() {
          currIndex = j;
          currIndexNext = j + 1;
          currentIndexColor = Colors.green;
          currentIndexColor2 = Colors.green;
        });

        if (number[j] > number[j + 1]) {
          setState(() {

            currentIndexColor = Colors.redAccent;
            currentIndexColor2 = Colors.redAccent;
            int temp = number[j];
            number[j] = number[j + 1];
            number[j + 1] = temp;

            swap = true;

          });
        }
        await Future.delayed(const Duration(seconds: 1));
      }
      if(swap == false) break;
    }
    setState(() {
      // Reset the colors after sorting is complete
      currentIndexColor = Colors.amber;
      currentIndexColor2 = Colors.amber;

      _showResetButton = true;

    });
  }


  void reset() {
    number.clear();
    inputTarget.clear();
    number.clear();
    currIndex = 0;
    currIndexNext = 1;
    setState(() {
      _showResetButton = false;
      _showsubmitButton = true;
      _showStartButton = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bubble Sort"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Input Number List: ',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child:  Container(

                    height: 60,
                    child:  SingleChildScrollView(
                      child: TextField(
                        controller: inputList,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
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
            if(_showsubmitButton == true)
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
            if(_showStartButton)
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    bubbleSort();
                  });
                },
                child: const Text('Start Bubble Sort'),
              ),
            ),

            const SizedBox(height:  40,),

           if(_showResetButton)
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
