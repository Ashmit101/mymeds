import 'item.dart';

class Medicine extends Item {
  Meals meal;
  Sequence sequence;
  int dose;

  Medicine(
      {required super.title,
      required super.note,
      required super.date,
      required this.meal,
      required this.sequence,
      required this.dose,
      super.id});

  Medicine.fromJson(Map<String, dynamic> json)
      : dose = json["dose"],
        meal = json['meal'],
        sequence = json['sequence'],
        super.fromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['date'] = date;
    data['note'] = note;
    data['dose'] = dose;
    data['meal'] = meal;
    data['sequence'] = sequence;
    return data;
  }
}

enum Meals { breakfast, lunch, dinner }

enum Sequence { after, before }
