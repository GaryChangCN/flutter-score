import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score/common/routers.dart';
import 'package:score/stores/app_store.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppStore())
      ],
      child: Consumer<AppStore>(
        builder: (context, counter, _) {
          return MaterialApp(
            title: '',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routes: routers,
            
          );
        },
      ),
    );
  }
}


