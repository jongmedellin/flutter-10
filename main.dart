import 'package:first_project_1/UserInfo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  return runApp(
    new MaterialApp(
      home: new MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<model> data = [];

  TextEditingController userController = new TextEditingController();
  final String URL = 'https://api.github.com/users/';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Drawer Example'),
      ),
      body: new Column(
        children: <Widget>[
          new TextFormField(
            controller: userController,
            decoration: new InputDecoration(hintText: 'Enter Github Username'),
          ),
          new SizedBox(
            height: 12.0,
          ),
          new RaisedButton(
            onPressed: getUser,
            child: new Text('Search'),
          ),
          new Flexible(
              child: new ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return new InkWell(
                child: new Card(
                  child: new Container(
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Image.network(
                          data[index].avatar_url,
                          height: 80.0,
                          width: 80.0,
                        ),
                        new SizedBox(
                          width: 20.0,
                        ),
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              '${data[index].id}',
                              style: Theme.of(context).textTheme.title,
                            ),
                            new SizedBox(
                              height: 10.0,
                            ),
                            new Text(
                              '${data[index].login}',
                              style: Theme.of(context).textTheme.headline,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return new UserInfo(
                        id: data[index].id,
                        avatar_url: data[index].avatar_url,
                        login: data[index].login);
                  }));
                },
              );
            },
          ))
        ],
      ),
    );
  }

  getUser() {
    String username = userController.text;
    String apiURL = URL + username + '/followers';
    http.get(apiURL).then((response) {
      if (response.statusCode == 200) {
        String body = response.body;
        var content = json.decode(body);
        print(content.length);
        data = [];
        for (var user in content) {
          model m = new model(
              id: user['id'],
              login: user['login'],
              avatar_url: user['avatar_url']);
          data.add(m);
          print(user['id']);
          setState(() {});
        }
      } else {
        print('Something went wrong ${response.statusCode}');
      }
    });
  }
}

class model {
  int id;
  String login;
  String avatar_url;

  model({this.id, this.login, this.avatar_url});
}
