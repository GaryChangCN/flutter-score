
import 'package:score/common/presist.dart';
import 'package:score/common/util.dart';
import 'package:score/entities/match_entity.dart';

class _Sotrage {
  List<MatchInfoEntity> _matchInfoList = [];

  _Sotrage () {
    this._init();
  }

  _init () async {
    var list = await persist.getMatchInfoList();
    this._matchInfoList = list;
  }

  Future<List<MatchInfoEntity>> getMatchList () async {
    var list = await persist.getMatchInfoList();

    return list;
  }

  addMatchList (String name) async {
    var id = await uniqueId();
    var matchEntity = MatchInfoEntity(
      id: id,
      name: name,
    );
    this._matchInfoList.add(matchEntity);

    await persist.setMatchInfoList(this._matchInfoList);

    return id;
  }

  Future<MatchInfoEntity> getMatchInfo (String id) async {
    var list = this._matchInfoList;

    MatchInfoEntity curr;

    list.forEach((value) {
      if (value.id == id) {
        curr = value;
      }
    });

    return curr;
  }

  Future<void> updateMatchInfo (String id, MatchInfoEntity data) async {

    this._matchInfoList = this._matchInfoList.map((item) {
      if (item.id != id) {
        return item;
      }
      item.current = data.current;
      return item;
    }).toList();

    await persist.setMatchInfoList(this._matchInfoList);

  }
}

var storage = new _Sotrage();
