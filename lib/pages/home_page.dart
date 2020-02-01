import 'package:flutter/material.dart';
import 'package:score/common/services.dart';
import 'package:score/entities/match_entity.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool addModalVisivle = false;

  List<MatchInfoEntity> matchList = [];

  @override
  void initState() {
    super.initState();
    this.addMatchInputNameController.text = '新对局';
    this.freshMatchList();
  }

  freshMatchList () async {
    var value = await services.listMatch();
    this.setState(() {
      this.matchList = value;
    });
  }

  toggleAddModalVisible (bool status) {
    setState(() {
      this.addModalVisivle = status;
    });
  }

  final addMatchInputNameController = new TextEditingController();

  handleAddNewMatch () async {
    var name = this.addMatchInputNameController.text;
    await services.addMatch(name);
    await this.freshMatchList();
    this.toggleAddModalVisible(false);
  }


  @override
  Widget build(BuildContext context) {
    // final appStore = Provider.of<AppStore>(context);

    renderAddModal () {
      if (!addModalVisivle) {
        return SizedBox.shrink();
      }
      return (
        AlertDialog(
          title: Text("创建新对局"),
          elevation: 100,
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () {
                this.toggleAddModalVisible(false);
              },
            ),
            FlatButton(
              child: Text('确定'),
              color: Colors.blue,
              onPressed: () {
                this.handleAddNewMatch();
              },
            )
          ],
          content: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: "输入比赛名称",
                  labelText: "名称",
                ),
                controller: this.addMatchInputNameController
              )
            ],
          ),
        )
      );
    }

    renderMatchList () {
      if (this.addModalVisivle) {
        return SizedBox.shrink();
      }
      return (
        ListBody(
          children: this.matchList.map((item) {
            return Container(
              key: Key(item.id),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 10, color: Color(0xFFFFEEEEEE))
                )
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("/match", arguments: item.id);
                },
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 100,
                        alignment: Alignment.centerLeft,
                        padding: new EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text(item.id, style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        )),
                      )
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        height: 100,
                        alignment: Alignment.centerLeft,
                        padding: new EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Text(item.name, style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          // color: Color.fromARGB(75, 255, 255, 255),
                        )),
                      )
                    ),
                  ],
                )
              )
            );
          }).toList(),
        )
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("对局列表")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (this.addModalVisivle) {
            return null;
          }
          this.toggleAddModalVisible(true);
        },
      ),
      body: ListView(
        children: <Widget>[
          renderAddModal(),
          renderMatchList(),
        ],
      ),
    );
  }
}


