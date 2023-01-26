class CharacterModel{
  int? charId;
  String? name;
  String? nickName;
  String? image;
  List<dynamic>? jobs;
  List<dynamic>? appearanceInSeason;
  List<dynamic>? betterCallSaulAppearance;
  String? statusIfDeadOrAlive;
  String? actorName;
  String? categoryForSeries;

  CharacterModel.fromJson(Map<String,dynamic>json){
    charId=json["char_id"];
    name=json["name"];
    nickName=json["nickname"];
    image=json["img"];
    jobs=json["occupation"];
    appearanceInSeason=json["appearance"];
    betterCallSaulAppearance=json["better_call_saul_appearance"];
    statusIfDeadOrAlive=json["status"];
    actorName=json["portrayed"];
    categoryForSeries=json["category"];
  }

}