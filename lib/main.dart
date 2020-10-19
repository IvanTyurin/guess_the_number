import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Guess the Number',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Practice 2'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Random rnd = Random();
  TextEditingController controller = TextEditingController();

  int computerNum;
  String text = "Try to guess the number";
  bool userWin = false;

  @override
  void initState() {
    super.initState();
    computerNum = rnd.nextInt(100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildScreenBody(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildScreenBody() {
    return Center(

      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50,),
            Text("$text",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 100,
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: controller,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                RaisedButton(
                  onPressed: _tryBtnPressed,
                  color: Colors.purple,
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Text("try!"),
                )
              ],
            ),
            Visibility(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.purple,
                      size: 40,
                    ),
                    onPressed: _refreshButton,
                    alignment: Alignment.center,
                )],
              ),
              visible: userWin,
            ),
            // Text("$computerNum")
          ],
        ),
      ),
    );
  }

  void _tryBtnPressed() {
    String inputData = controller.text;
    String message = "";
    int userNum = int.parse(inputData);

    if(userNum > computerNum) {
      message = "To much";
    }
    if(userNum == computerNum) {
      message = "Congratulations!";
      userWin = true;
    }
    if(userNum < computerNum) {
      message = "Few";
    }

    setState(() {
      text = message;
    });
  }

  void _refreshButton() {
    userWin = !userWin;
    computerNum = rnd.nextInt(100);
    setState(() {
      text = "Try to guess the number";
    });
  }
}
