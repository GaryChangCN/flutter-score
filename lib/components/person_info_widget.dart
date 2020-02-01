import 'package:flutter/material.dart';
import 'package:score/entities/personal_entity.dart';

class PersonalInfoWidget extends StatelessWidget {
  PersonalInfoWidget({
    Key key,
    this.personalInfo,
    this.onAdd,
    this.onRemove,
  }): super(key: key);

  final PersonalInfoEntity personalInfo;

  final onAdd;
  final onRemove;

  _renderBaseInfo () {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Container(
          height: 70,
          padding: new EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                this.personalInfo.name,
                style: new TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
        new Container(
          height: 50,
          width: 100,
          padding: new EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
                Text(
                    this.personalInfo.score.toString(),
                    style: new TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                ),
              ],
            )
          )
      ],
    );
  }

  _renderAction () {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Row(
          children: <Widget>[
            new IconButton(
              icon: Icon(Icons.remove_circle_outline),
              onPressed: () {
                this.onRemove('');
              },
            ),
            new IconButton(
              icon: Icon(Icons.add_circle_outline),
              onPressed: () {
                this.onAdd('');
              },
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
          flex: 7,
          child: this._renderBaseInfo(),
        ), new Expanded(
          flex: 3,
          child: this._renderAction()
        )
      ],
    );
    // return Row(
    //   children: <Widget>[
    //     Text(this.personalInfo.name),
    //     Text(this.personalInfo.score.toString()),
    //     Text('333'),
    //   ],
    // );
  }
}