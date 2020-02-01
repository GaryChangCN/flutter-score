
import 'dart:convert';

import 'package:score/entities/match_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Persist {


  final _instance = SharedPreferences.getInstance();

  Future<int> getUniqueId () async {
    var prefs = await this._instance;
    int counter = (prefs.getInt('uniqureIncreaseId') ?? 0) + 1;
    await prefs.setInt('uniqureIncreaseId', counter);
    return counter;
  }

  Future<void> setUniqueIdList (List<String> value) async {
    var prefs = await this._instance;
    prefs.setStringList('uniqueIncreaseId', value);
  }


  setMatchInfoList (List<MatchInfoEntity> value) async {
    String str = jsonEncode(value);
    var prefs = await this._instance;
    prefs.setString('MatchInfoList', str);
  }

  Future<List<MatchInfoEntity>> getMatchInfoList () async {
    var prefs = await this._instance;

    var list = prefs.getString('MatchInfoList') ?? "[]";


    try {
      var originList = jsonDecode(list) as List<dynamic>;
      List<MatchInfoEntity> ret = originList.map((value) {
        return MatchInfoEntity.fromJSON(value);
      }).toList();
      return ret;
    } catch (e) {
      print(e);
      return null;
    }
  }
}

final persist = new _Persist();

