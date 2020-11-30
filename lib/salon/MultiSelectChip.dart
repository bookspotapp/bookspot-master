import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MultiSelectChip extends StatefulWidget{
  List<String> timeSlotList;
  double height;
  Function(String) onClick;



  MultiSelectChip({Key key, this.timeSlotList, this.height, this.onClick}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SingleSelectChip(timeSlotList, height);

}

class _SingleSelectChip extends State<MultiSelectChip>{
  List<String> timeSlotList = [];
  String SelectedTimeSlot = "";
  double height;
  
  _SingleSelectChip(this.timeSlotList, this.height);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: height*0.3,
      child: SingleChildScrollView(
        child: Wrap(
          children: _buildTimeSlots(),
        ),
      ),
    );
  }

  _buildTimeSlots() {
    List<Widget> TimeSlots = List();

    widget.timeSlotList.forEach(  (item) {
      TimeSlots.add(  Container(
        padding: EdgeInsets.all(5.0),
        child: ChoiceChip(
          backgroundColor: Colors.grey,
          selectedColor: Colors.orange[800],
          shadowColor: Colors.white,
          labelStyle: TextStyle(
            color: Colors.white
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          label: Text(item),
          selected: SelectedTimeSlot == item,
          onSelected: (selected){
            setState(() {
              SelectedTimeSlot = item;
              widget.onClick(item);
            });
          },
        ),
      ));
    });

    return TimeSlots;
  }
}