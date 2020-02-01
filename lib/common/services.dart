
import 'package:score/common/storage.dart';
import 'package:score/entities/match_entity.dart';

class _Services {
  addMatch (String name) async {
    var id = await storage.addMatchList(name);
    return id;
  }

  Future<List<MatchInfoEntity>> listMatch () async {
    var list = await storage.getMatchList();
    return list;
  }

  Future<MatchInfoEntity> getMatch (String id) async {
    var ret = await storage.getMatchInfo(id);
    return ret;
  }
  
  Future<void> updMatch (String id, MatchInfoEntity data) async {
    await storage.updateMatchInfo(id, data);
  }
}

var services = new _Services();
