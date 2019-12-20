import 'package:flutter/material.dart';
import 'chat_screen.dart';

class CheckBox extends StatefulWidget {
  CheckBox({this.controller});

  TextEditingController controller;

  @override
  _CheckBoxState createState() => _CheckBoxState();
}

void printOnConsoleAndTextField(
    List<String> daysList, List<bool> checkBoxValue,controller) {
  List<String> outputList = [];
  for (int i = 0; i < checkBoxValue.length; i++) {
    if (checkBoxValue[i]) {
      outputList.add(daysList[i]);
    }
  }
 // controller.text=outputList;
  print(outputList);
}

class _CheckBoxState extends State<CheckBox> {
  List<String> daysList = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];
  List<bool> checkBoxValue = [false, false, false, false, false, false, false];

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(daysList[index]),
            value: checkBoxValue[index],
            onChanged: (bool value) {
              setState(() {
                checkBoxValue[index] = value;
              });
              printOnConsoleAndTextField(daysList, checkBoxValue,widget.controller);
            },
          );
        },
        itemCount: daysList.length,
        shrinkWrap: true,
      ),
    );
  }
}

/*

*/
/*
 ListView(
        shrinkWrap: true,
        children: <Widget>[
          CheckboxListTile(
            title: const Text('Sunday'),
            value: valueSunday,
            onChanged: (bool value) {
              // if(value){print("Sunday");}

              setState(() {
                valueSunday=value;
                values["Sunday"]=valueSunday;

                values.forEach((key,value){
                  if(value){
                    // print(key);
                    daysChecked.add(key);

                    print(daysChecked);
                  }
                });
              });
            },

          ),CheckboxListTile(
            title: const Text('Monday'),
            value: valueMonday,
            onChanged: (bool value) {
              // if(value){print("Monday");}

              setState(() {
                valueMonday=value;
                values["Monday"]=valueMonday;
                values.forEach((key,value){
                  if(value){
                    // print(key);
                    daysChecked.add(key);

                    print(daysChecked);
                  }
                });
              });
            },

          ),CheckboxListTile(
            title: const Text('Tuesday'),
            value: valueTuesday ,
            onChanged: (bool value) {
              // if(value){print("Tuesday");}

              setState(() {
                valueTuesday=value;
                values["Tuesday"]=valueTuesday;
                values.forEach((key,value){
                  if(value){
                    // print(key);
                    daysChecked.add(key);

                    print(daysChecked);
                  }
                });
              });
            },

          ),CheckboxListTile(
            title: const Text('Wednesday'),
            value: valueWednesday,
            onChanged: (bool value) {
              // if(value){print("Wednesday");}

              setState(() {
                valueWednesday=value;
                values["Wednesday"]=valueWednesday;
                values.forEach((key,value){
                  if(value){
                    // print(key);
                    daysChecked.add(key);

                    print(daysChecked);
                  }
                });
              });
            },

          ),CheckboxListTile(
            title: const Text('Thursday'),
            value: valueThursday,
            onChanged: (bool value) {
              // if(value){print("Thursday");}

              setState(() {

                valueThursday=value;
                values["Thursday"]=valueThursday;
                values.forEach((key,value){
                  if(value){
                    //print(key);
                    daysChecked.add(key);

                    print(daysChecked);
                  }
                });
              });
            },

          ),CheckboxListTile(
            title: const Text('Friday'),
            value: valueFriday,
            onChanged: (bool value) {
              // if(value){print("Friday");}

              setState(() {

                valueFriday=value;
                values["Friday"]=valueFriday;
                values.forEach((key,value){
                  if(value){
                    //  print(key);
                    daysChecked.add(key);

                    print(daysChecked);
                  }
                });
              });
            },

          ),CheckboxListTile(
            title: const Text('Saturday'),
            value: valueSaturday,
            onChanged: (bool value) {
              // if(value){print("Saturday");}

              setState(() {
                valueSaturday=value;
                values["Saturday"]=valueSaturday;
                values.forEach((key,value){
                  if(value){
                    // print(key);
                    daysChecked.add(key);

                    print(daysChecked);
                  }
                });
              });
            },

          ),
        ],
      )
*/
