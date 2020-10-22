import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  RangeValues _rangeValues = RangeValues(0, 100);

  @override
  void initState() {
    super.initState();
    _loadSavedValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body:
          _buildBody(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 30, bottom: 10),
            child: Text(
              'Set random range',
              style: TextStyle(
                color: Colors.purple,
                shadows: [
                  Shadow(
                    color: Colors.deepPurple.shade300,
                    blurRadius: 5.0,
                    offset: Offset(0, 0),
                  )
                ],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 30, bottom: 10),
            child: RangeSlider(
              values: _rangeValues,
              min: 0,
              max: 100,
              divisions: 100,
              labels: RangeLabels(_rangeValues.start.round().toString(),
                  _rangeValues.end.round().toString()),
              onChanged: (RangeValues values) {
                setState(() {
                  _rangeValues = values;
                });
              },
              activeColor: Colors.purple,
              inactiveColor: Colors.deepPurpleAccent,
            ),
          ),
          Container(
            child: RaisedButton(
              onPressed: _saveButtonPressed,
              color: Colors.purple,
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Text('Save'),
            ),
          ),
        ],
      ),
    );
  }

  void _saveButtonPressed() {
    int minimumValue = _rangeValues.start.round();
    int maximumValue = _rangeValues.end.round();
    SharedPreferences.getInstance().then((value) {
      value.setInt("min", minimumValue);
      value.setInt("max", maximumValue);
    });
  }

  void _loadSavedValues() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    if (_sharedPreferences != null &&
        _sharedPreferences.containsKey("min") &&
        _sharedPreferences.containsKey("max")) {
      int min = _sharedPreferences.getInt("min");
      int max = _sharedPreferences.getInt("max");
      setState(() {
        _rangeValues = RangeValues(min.roundToDouble(), max.roundToDouble());
      });
    }
  }
}
