import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

void main() => runApp(DateRanges());

class DateRanges extends StatefulWidget {
  @override
  SelectedDateRange createState() => SelectedDateRange();
}
List<String> views = <String>['Month', 'Year', 'Decade', 'Century'];
class SelectedDateRange extends State<DateRanges> {
  String _startDate, _endDate;
  DateRangePickerController _controller;
  DateTime _start, _end,_today;

  @override
  void initState() {
    _controller = DateRangePickerController();

    _startDate = DateFormat('dd, MMMM yyyy').format(DateTime.now()).toString();
    _endDate = DateFormat('dd, MMMM yyyy')
        .format(DateTime.now().add(Duration(days: 3)))
        .toString();
    _today=DateTime.now();
    _start = _today;
    _end = _today.add(Duration(days: 3));
    _controller.selectedRange = PickerDateRange(_start, _end);
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(leading: PopupMenuButton<String>(
          icon: Icon(Icons.calendar_today),
          itemBuilder: (BuildContext context) => views.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList(),
          onSelected: (String value) {
            if (value == 'Month') {
              _controller.view = DateRangePickerView.month;
            } else if (value == 'Year') {
              _controller.view = DateRangePickerView.year;
            } else if (value == 'Decade') {
              _controller.view = DateRangePickerView.decade;
            } else if (value == 'Century') {
              _controller.view = DateRangePickerView.century;
            }
          },
        ),),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  height: 50, child: Text('StartRangeDate:' '$_startDate')),
              Container(height: 50, child: Text('EndRangeDate:' '$_endDate')),
              Card(
                margin: const EdgeInsets.fromLTRB(50, 40, 50, 100),
                child: SfDateRangePicker(
                  controller: _controller,
                  selectionMode: DateRangePickerSelectionMode.range,
                  onSelectionChanged: selectionChanged,
                  allowViewNavigation: false,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _startDate =
          DateFormat('dd, MMMM yyyy').format(args.value.startDate).toString();
      _endDate =
          DateFormat('dd, MMMM yyyy').format(args.value.endDate).toString();
    });
  }
}
