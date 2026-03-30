import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MoneyApp(),
    );
  }
}

class MoneyApp extends StatefulWidget {
  @override
  _MoneyAppState createState() => _MoneyAppState();
}

class _MoneyAppState extends State<MoneyApp> {
  double balance = 5000;
  double stake = 100;
  int wins = 0;
  int losses = 0;
  int step = 0;

  void win() {
    setState(() {
      balance += stake;
      wins++;
      step++;
      stake *= 1.2;
    });
  }

  void loss() {
    setState(() {
      balance -= stake;
      losses++;
      step++;
      stake *= 1.5;
    });
  }

  Widget box(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF2A003F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(color: Colors.white70)),
          SizedBox(height: 5),
          Text(value, style: TextStyle(color: color, fontSize: 18)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double target = 10000; // ✅ updated
    double expected = stake * 3;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Money Management"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                box("STARTING", "৳5000", Colors.white),
                box("CURRENT", "৳${balance.toStringAsFixed(0)}", Colors.green),
                box("STEP", "$step / 30", Colors.white),
                box("TARGET", "৳${target.toStringAsFixed(0)}", Colors.blue),
                box("WINS", "$wins", Colors.green),
                box("LOSSES", "$losses", Colors.red),
              ],
            ),
            SizedBox(height: 15),
            box("NEXT STAKE", "৳${stake.toStringAsFixed(2)}", Colors.pink),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.white24),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text("EXPECTED RETURN (IF WIN)",
                      style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 5),
                  Text("+৳${expected.toStringAsFixed(2)}",
                      style: TextStyle(color: Colors.green, fontSize: 18)),
                ],
              ),
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: step / 30,
              backgroundColor: Colors.white12,
              color: Colors.green,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: win,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text("WIN"),
                ),
                ElevatedButton(
                  onPressed: loss,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text("LOSS"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
