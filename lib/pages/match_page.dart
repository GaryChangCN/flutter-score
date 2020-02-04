import 'package:flutter/material.dart';
import 'package:score/common/services.dart';
import 'package:score/components/person_info_widget.dart';
import 'package:score/entities/match_entity.dart';
import 'package:score/entities/personal_entity.dart';

class MatchPage extends StatefulWidget {
  String id = '';
  MatchPage({Key key, this.id}) : super(key: key);


  @override
  _MatchPageState createState() => _MatchPageState();
}


class _MatchPageState extends State<MatchPage> {

  bool addPersonalVisible = false;

  final addPersonInputNameController = new TextEditingController();


  MatchInfoEntity matchInfo = new MatchInfoEntity();

  @override
  void initState() {
    super.initState();
    this.addPersonInputNameController.text = "新用户";
    this.freshMatchInfo();
  }

  toggleAddModalVisible (bool status) {
    setState(() {
      this.addPersonalVisible = status;
    });
  }


  freshMatchInfo () async {
    var ret = await services.getMatch(widget.id);
    setState(() {
      this.matchInfo = ret;
    });

  }


  debounceSubmit () async {
    await services.updMatch(widget.id, this.matchInfo);
  }

  handleAdd () {
    var name = this.addPersonInputNameController.text;
    var entity = new PersonalInfoEntity(name: name, score: 0, step: 10);
    this.matchInfo.current.add(entity);
    this.toggleAddModalVisible(false);
    this.debounceSubmit();
  }

  handleChange (int index, bool isAdd) {
    setState(() {
      if (isAdd) {
        this.matchInfo.current[index].score += 10;
      } else {
        this.matchInfo.current[index].score -= 10;
      }
      this.debounceSubmit();
    });
  }

  handleClear () {
    setState(() {
      this.matchInfo.history.add(this.matchInfo.current);
      this.matchInfo.current = this.matchInfo.current.map((item) {
        item.score = 0;
        return item;
      }).toList();
    });
    this.debounceSubmit();
  }


  @override
  Widget build(BuildContext context) {
    var list = this.matchInfo.current ?? [];

    Widget renderAddModal () {
      if (!this.addPersonalVisible) {
        return SizedBox.shrink();
      }
      return (
        AlertDialog(
          title: Text("创建新玩家"),
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
                this.handleAdd();
              },
            )
          ],
          content: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: "输入玩家昵称",
                  labelText: "昵称",
                ),
                controller: this.addPersonInputNameController
              )
            ],
          ),
        )
      );
    }

    Widget renderPersonalInfoArea () {
      if (this.addPersonalVisible) {
        return SizedBox.shrink();
      }
      var personalInfoList = list.asMap().keys.map((index) {
        var item = list[index];
        return new Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: Color(0xFFFFEEEEEE))
            )
          ),
          child: new PersonalInfoWidget(
            personalInfo: item,
            onAdd: (value) => this.handleChange(index, true),
            onRemove: (value) => this.handleChange(index, false),
          ),
        );
      });
      return new Container(
        child: new ListBody(
          children: personalInfoList.toList(),
        ),
      );
    }

    Widget renderClear () {
      if (this.matchInfo.current.length == 0) {
        return SizedBox.shrink();
      }
      return Container(
        alignment: Alignment.center,
        padding: new EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: RaisedButton(
          child: Text("清零/下一轮", style: TextStyle(color: Colors.white),),
          color: Colors.blue,
          onPressed: () {
            this.handleClear();
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(this.matchInfo.name ?? '-')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (this.addPersonalVisible) {
            return null;
          }
          this.toggleAddModalVisible(true);
        },
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            renderAddModal(),
            renderPersonalInfoArea(),
            renderClear(),
          ],
        ),
      ),
    );
  }
}
