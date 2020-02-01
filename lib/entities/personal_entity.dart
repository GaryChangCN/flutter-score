class PersonalInfoEntity {
  String name = '';
  int score = 0;
  int step = 5;

  PersonalInfoEntity({
    this.name,
    this.score,
    this.step
  });

  factory PersonalInfoEntity.fromJson(Map<String, dynamic> json) {
    return PersonalInfoEntity(name: json['name'], score: json['score'], step: json['step']);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "score": score,
      "step": step
    };
  }
}