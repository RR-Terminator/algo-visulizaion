import 'package:flutter/material.dart';

class SelectionSortAlgo extends StatefulWidget {

  static const routeName = '/selection- sort';

  const SelectionSortAlgo({Key? key}) : super(key: key);

  @override
  State<SelectionSortAlgo> createState() => _SelectionSortAlgoState();
}


List<int> number = [];


class _SelectionSortAlgoState extends State<SelectionSortAlgo> {

  var inputList = TextEditingController();


  Color currentIndexColor = Colors.amber;
  Color maxIndexColor = Colors.amber;


  bool _showResetButton = false;
  bool _showsubmitButton = true;
  bool _showStartButton = false;

  int currIndex = 0;
  int maxIndex = 0;


  void submit(){
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

  void reset(){

    number.clear();
    currIndex = 0;
    maxIndex = -1;
    setState(() {
      _showResetButton = false;
      _showsubmitButton = true;
      _showStartButton = false;
    });

  }

  Future<void> selectionSort() async {
    for (int i = 0; i <number.length; i++) {
      int maxValueIndex =  0;
      for (int j = 1; j <= number.length-i-1; j++) {
        if (number[maxValueIndex] < number[j]) {
          setState(() {
            maxIndex = j;
            maxIndexColor = Colors.redAccent;

          });

          maxValueIndex = j;

        }


      }

      setState(() {

        currIndex = i;
        maxIndexColor = Colors.redAccent;
        currentIndexColor = Colors.greenAccent;
        int temp = number[maxValueIndex];
        number[maxValueIndex] = number[number.length-i-1];
        number[number.length-i-1] = temp;

      });

      await Future.delayed(const Duration(seconds: 2));
    }

    setState(() {
      currentIndexColor =Colors.amber;
      maxIndexColor = Colors.amber;

      _showResetButton= true;
    });


  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selection Sort"),
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
                                : index == maxIndex
                                ? maxIndexColor
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
                      selectionSort();
                    });
                  },
                  child: const Text('Start Selection Sort'),
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
