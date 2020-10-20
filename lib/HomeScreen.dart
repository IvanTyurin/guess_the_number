import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SettingsScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Random randomizer = Random();
  TextEditingController controller = TextEditingController();

  int computerNum;
  int _minRandomValue = 0;
  int _maxRandomValue = 100;
  int _count = 0;
  String text = "Try to guess the number";
  bool userWin = false;

  @override
  void initState() {
    super.initState();
    _loadSettingsValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice 2'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
              size: 30,
            ),
            onPressed: _showSettingsScreen,
            alignment: Alignment.center,
          ),
        ],
      ),
      body:
          _buildScreenBody(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildScreenBody() {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "$text",
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
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.purple,
                      size: 40,
                    ),
                    onPressed: _refreshButton,
                    alignment: Alignment.center,
                  )
                ],
              ),
              visible: userWin,
            ),
            _attemptCounter(),
          ],
        ),
      ),
    );
  }

  Widget _attemptCounter() {
    return Container(
        height: 30,
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Attempt counter: $_count',
              style: TextStyle(),
            )
          ],
        ));
  }

  void _tryBtnPressed() {
    String inputData = controller.text;
    String message = "";
    int userNum = int.parse(inputData);

    _count++;

    if (userNum > computerNum) {
      message = "To much";
    }
    if (userNum == computerNum) {
      message = "Congratulations!";
      userWin = true;
    }
    if (userNum < computerNum) {
      message = "Few";
    }

    setState(() {
      text = message;
    });
  }

  void _refreshButton() {
    userWin = !userWin;
    computerNum =
        randomizer.nextInt(_maxRandomValue - _minRandomValue) + _minRandomValue;
    setState(() {
      text = "Try to guess the number";
      _count = 0;
    });
  }

  void _showSettingsScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsScreen()));
  }

  void _loadSettingsValue() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    if (_sharedPreferences != null &&
        _sharedPreferences.containsKey("min") &&
        _sharedPreferences.containsKey("max")) {
      _minRandomValue = _sharedPreferences.getInt("min");
      _maxRandomValue = _sharedPreferences.getInt("max");
    }

    computerNum =
        randomizer.nextInt(_maxRandomValue - _minRandomValue) + _minRandomValue;
  }
}
