import 'item.dart';

class Activity extends Item {
  String time;

  Activity(
      {required super.title,
      required super.note,
      required super.date,
      required this.time});

  Activity.fromJson(Map<String, dynamic> json)
      : time = json['time'],
        super.fromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['date'] = date;
    data['note'] = note;
    data['time'] = time;
    return data;
  }
}
