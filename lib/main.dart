import 'package:flutter/material.dart';
import 'package:styla_designs/chip_list.dart';
import 'package:styla_designs/mychips.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ChipData> chipItems = ChipList.all;

  bool showBox = true;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SafeArea(
        child: Column(
          children: [
            TableCalendar(
              rowHeight: 70,
              daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle: TextStyle(
                    color: Colors.white,
                  ),
                  weekdayStyle: TextStyle(
                    color: Colors.white,
                  )),
              headerStyle: HeaderStyle(
                  leftChevronIcon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 15,
                  ),
                  rightChevronIcon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 15,
                  ),
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
                selectedTextStyle: TextStyle(color: Colors.black, fontSize: 20),
                disabledTextStyle: TextStyle(color: Colors.grey, fontSize: 20),
                defaultTextStyle: TextStyle(color: Colors.white, fontSize: 20),
                todayTextStyle: TextStyle(color: Colors.black, fontSize: 20),
                weekendTextStyle: TextStyle(color: Colors.white, fontSize: 20),
                cellMargin: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
                isTodayHighlighted: false,
                selectedDecoration: showBox
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white,
                        ),
                        color: Colors.white,
                      )
                    : BoxDecoration(),
              ),
              calendarFormat: CalendarFormat.week,
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(2050, 2, 20),
              focusedDay: DateTime.now(),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  showBox = false;
                  Future.delayed(const Duration(milliseconds: 300), () {
                    setState(() {
                      _focusedDay =
                          focusedDay; // update `_focusedDay` here as well
                      _selectedDay = selectedDay;
                      Future.delayed(const Duration(milliseconds: 300), () {
                        setState(() => showBox = true);
                      });
                    });
                  });
                });
              },
            ),
            Container(margin: EdgeInsets.all(10), child: buildChips()),
            InkWell(
                onTap: () {
                  openDialog();
                },
                child: Container(
                  height: 100,
                  color: Colors.red,
                ))
          ],
        ),
      ),
    );
  }

  Widget buildChips() => Wrap(
        children: chipItems
            .map((inputChip) => InputChip(
                  label: Text(inputChip.label),
                  labelStyle: TextStyle(color: Colors.black),
                  onDeleted: () => setState(() => chipItems.remove(inputChip)),
                ))
            .toList(),
      );

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Search'),
            content: Container(
              height: 300,
              child: Column(
                children: [
                  TextField(),
                  Text('hello'),
                  Chip(label: Text('hey'))
                ],
              ),
            ),
          ));
}
