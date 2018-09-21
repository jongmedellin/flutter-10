import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  String avatar_url;
  int id;
  String login;

  UserInfo({this.id,this.login,this.avatar_url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text('$id'),),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Image.network(avatar_url),
          new Text('Login : $login',style: Theme.of(context).textTheme.headline,),
        ],
      ),
    );
  }
}
