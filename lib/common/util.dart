

import 'package:score/common/presist.dart';

/// 生成递增 id
Future<String> uniqueId () async {
  var ori = await persist.getUniqueId();
  return ori.toString();
}