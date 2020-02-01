
import 'package:score/entities/personal_entity.dart';

class MatchInfoEntity {

  MatchInfoEntity({
    this.id,
    this.name,
    this.current,
    this.history
  });

  String id = '';
  String name = '新的比赛';

  List<PersonalInfoEntity> current;

  List<List<PersonalInfoEntity>> history;

  factory MatchInfoEntity.fromJSON(Map<String, dynamic> json) {
    final originCurrent = (json['current'] ?? []) as List;
    List<PersonalInfoEntity> current = originCurrent.map((value) => PersonalInfoEntity.fromJson(value)).toList();

    final originHistory = (json['history'] ?? []) as List<dynamic>;
    List<List<PersonalInfoEntity>> history = originHistory.map((value) {
      var v = (value ?? []) as List;
      return v.map((f) => PersonalInfoEntity.fromJson(f)).toList();
    }).toList();


    return MatchInfoEntity(
      current: current,
      history: history,
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "id": id,
      "current": current ?? [],
      "history": history ?? []
    };
  }
}