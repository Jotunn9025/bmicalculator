import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: AppHome(),
    ));

class AppHome extends StatefulWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  TextEditingController heightcntrl = TextEditingController();
  TextEditingController weightcntrl = TextEditingController();
  double BMIResult = 0.0;
  int unit = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BMI CALC",
        ),
        centerTitle: false,
        backgroundColor: Color.fromARGB(255, 225, 62, 51),
      ),
      body: Stack(
        children: [
          Image.asset('assets/bgimg.jpeg'),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RadioListTile(
                  value: 1,
                  groupValue: unit,
                  onChanged: (int? value) {
                    setState(() {
                      unit = value!;
                    });
                  },
                  title: Text('Metric system'),
                ),
                RadioListTile(
                  value: 2,
                  groupValue: unit,
                  onChanged: (int? value) {
                    setState(() {
                      unit = value!;
                    });
                  },
                  title: Text("Imperial system"),
                ),
                Text('Enter your height '),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2.0,
                      color: Colors.black54,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText:
                          unit == 1 ? 'Height(in cm)' : 'Height(in inches)',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 8.0,
                      ),
                    ),
                    controller: heightcntrl,
                  ),
                ),
                Text('\n\nEnter your weight'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2.0,
                      color: Colors.black54,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: unit == 1 ? 'Weight(in kg)' : 'Weight(in lbs)',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 8.0,
                      ),
                    ),
                    controller: weightcntrl,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 150,
        child: FloatingActionButton(
          onPressed: () {
            String heighttxt = heightcntrl.text;
            String weighttxt = weightcntrl.text;
            if (heighttxt.isEmpty || weighttxt.isEmpty) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Color.fromARGB(255, 245, 84, 72),
                    content: Text(
                      "Please input values\n\nClick outside the box or the back button to exit",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              );
            } else {
              double heightcm = double.tryParse(heighttxt) ?? 0.0;
              double weightkg = double.tryParse(weighttxt) ?? 0.0;
              if (unit == 1) {
                BMIResult = ((weightkg * 10000) / (heightcm * heightcm));
                BMIResult = roundNearestTenth(BMIResult);
              } else {
                BMIResult = ((703 * weightkg) / (heightcm * heightcm));
                BMIResult = roundNearestTenth(BMIResult);
              }
              if (!BMIResult.isFinite) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Color.fromARGB(255, 233, 118, 10),
                      content: Text(
                        "INVALID BMI",
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    );
                  },
                );
              } else {
                if (BMIResult < 18.5) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.red,
                        content: Text(
                          "Underweight:" + BMIResult.toString(),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  );
                } else if (BMIResult >= 18.5 && BMIResult < 25) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Color.fromARGB(255, 73, 234, 9),
                        content: Text(
                          "Normal Weight:" + BMIResult.toString(),
                          style: TextStyle(color: Colors.black87),
                        ),
                      );
                    },
                  );
                } else if (BMIResult >= 25 && BMIResult < 30) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: const Color.fromRGBO(233, 118, 10, 1),
                        content: Text(
                          "Overweight:" + BMIResult.toString(),
                          style: TextStyle(color: Colors.black54),
                        ),
                      );
                    },
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.red,
                        content: Text("Obese:" + BMIResult.toString()),
                      );
                    },
                  );
                }
              }
            }
          },
          child: Text("Calculate BMI"),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: const Color.fromARGB(255, 240, 105, 95),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

double roundNearestTenth(double BMIResult) {
  return ((BMIResult * 10).round()) / 10;
}
