import 'package:flutter/material.dart';
import '../models/medicine.dart';
import 'date.dart';
import 'package:my_meds/widgets/themes.dart';


class ReminderTile extends StatelessWidget {
  final String title;
  final String note;
  final String date;
  final String? time;
  final int? dose;
  final int type;
  final int? meal;
  final int? sequence;

  const ReminderTile(
      {Key? key,
      required this.title,
      required this.note,
      required this.date,
      this.time,
      this.dose,
      required this.type,
      this.sequence,
      this.meal})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
            style: MyTheme.titleStyle,),
            Padding(
              padding: const EdgeInsets.only(top : 16.0),
              child: Text(note,
              style: MyTheme.noteStyle,),
            ),
            Visibility(
              visible: type == 2,
              child: Padding(
                padding: const EdgeInsets.only(top : 16.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DateWidget(date: date, isDate: true,),
                    DateWidget(time: time, isDate: false,)
                  ],
                ),
              ),
            ),
            Visibility(
                visible: type == 1,
                child: Text(
              'Dose left: ${dose.toString()}'
            )),
            Visibility(
                visible: type == 1,
                child: Text(
              _getTimeForMeal(meal ?? 1, sequence ?? 1)
            ))
          ],
        ),
      ),
    );
  }

  String _getTimeForMeal(int meal, int sequence) {
    String first, second;

    switch(meal){
      case 0:
        second = "breakfast";
        break;
      case 1:
        second = "lunch";
        break;
      default:
        second = "dinner";
    }

    switch(sequence){
      case 0:
        first = "After";
        break;
      default:
        first = "Before";
    }

    return '$first $second';
  }
}
