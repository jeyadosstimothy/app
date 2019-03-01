import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      home: new FirstPage(title: "P'19 Tech Events"),
    );
  }
}

class FirstPage extends StatefulWidget {
  FirstPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FirstPageState createState() => new _FirstPageState();
}

class _FirstPageState extends State<FirstPage> with TickerProviderStateMixin {
  double _height = 80.0;
  double _width = 80.0;
  var _color = Colors.blue;
  bool _resized = false;

  Icon _notifyIcon = new Icon(IconData(0xe7f7, fontFamily: 'MaterialIcons'),
      color: Colors.yellowAccent);
  final events = [
    {'name': 'OSPC', 'date': 'March 8, 9:00 AM - 1:30 PM', 'id': 'ospc'},
    {
      'name': 'Mini Placement',
      'date': 'March 8, 9:00 AM - 1:30 PM',
      'id': 'miniplacement'
    },
    {
      'name': 'Amazon Hiring Event',
      'date': 'March 8, 9:00 AM - 1:30 PM',
      'id': 'amazon'
    },
    {
      'name': "Code 'N Chaos",
      'date': 'March 9, 9:00 AM - 1:30 PM',
      'id': 'cnc'
    },
    {
      'name': 'Parseltongue',
      'date': 'March 9, 9:00 AM - 1:30 PM',
      'id': 'python'
    },
    {
      'name': "OOPS! It's Java",
      'date': 'March 9, 9:00 AM - 1:30 PM',
      'id': 'java'
    },
    {'name': 'Web Hub', 'date': 'March 9, 9:00 AM - 1:30 PM', 'id': 'web'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        elevation: 7,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: new Text(widget.title),
      ),
      body: Container(
          padding: new EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
          child: new ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: events.length,
            itemBuilder: (context, index) => new Card(
                  elevation: 7.0,
                  margin:
                      new EdgeInsets.symmetric(horizontal: 6.0, vertical: 5.0),
                  child: new InkWell(
                      onTap: _launchURL,
                      splashColor: Color.fromRGBO(48, 56, 76, 1),
                      child: new Container(
                        // height: 250.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(64, 75, 96, .9),
                          // boxShadow: [new BoxShadow(
                          // color: Color.fromRGBO(64, 75, 99, .6),
                          // blurRadius: 20.0,
                          // ),]
                        ),
                        child: makeListTile(index),
                      )),
                ),
          )),
    );
  }

  ListTile makeListTile(index) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24))),
        child: Icon(Icons.autorenew, color: Colors.white),
      ),
      title: Text('${events[index]['name']}',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Padding(padding: new EdgeInsets.symmetric(vertical: 3.0)),
            new Row(children: <Widget>[
              Padding(padding: new EdgeInsets.symmetric(vertical: 3.0)),
              Align(
                  alignment: Alignment.center,
                  child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(IconData(0xe916, fontFamily: 'MaterialIcons'),
                            color: Colors.yellowAccent),
                        Text(' ${events[index]['date']}',
                            style: TextStyle(color: Colors.white)),
                      ])),
            ]),
            new Padding(padding: new EdgeInsets.symmetric(vertical: 3.0)),
            new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: FlatButton.icon(
                      onPressed: () => _contactPressed("tel:7358527747"),
                      icon: new Icon(
                          IconData(0xe0b0, fontFamily: 'MaterialIcons'),
                          color: Colors.yellowAccent),
                      label: Text("")),
                ),

                // new AnimatedSize(
                //   curve: Curves.easeInOut,
                //   child: new GestureDetector(

                //     onTap: () {
                //       setState(() {
                //         if (_resized) {
                //               _resized = false;

                //           _color = Colors.pink;
                //           _height = 80.0;
                //           _width = 80.0;
                //         } else {
                //             Navigator.push(
                //               context,
                //               MaterialPageRoute(builder: (context) => ColorPageRoute(palette[index].keys.first)),
                //               );

                //           _resized = true;
                // _color = Colors.blue;
                // _height = 320.0;
                // _width = 320.0;
                // // _color = _color;
                // _height = _height;
                // _width = _width;
                // }
                // });
                // },
                //   child: new Container(
                //     width: _width,
                //     height: _height,
                //     color: _color,
                //   ),
                //   ),
                //     vsync: this,
                //   duration: new Duration(seconds: 1),
                // ),
                // new AnimatedSize(
                //     vsync: this,
                //   duration: new Duration(seconds: 1),
                //   curve: Curves.easeInOut,
                //     child: new
                OutlineButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: const Text("View Results"),
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) {
                        return new MaterialApp(
                          title: '${events[index]['name']}',
                          home: new SecondPage(
                              title: '${events[index]['name']}',
                              id: '${events[index]['id']}'),
                        );
                      }));
                    }),

                //     ),
              ],
            ),
          ]),
    );
  }

  void _contactPressed(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchURL() async {
    const url = "https://www.prayatna.org.in";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class ColorPageRoute extends CupertinoPageRoute {
  ColorPageRoute() : super(builder: (BuildContext context) => new SecondPage());
  @override
  String title1;
  // ColorPageRoute(String t)  {
  //   title1 = t;
  // }
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: title1,
      theme: new ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: new SecondPage(),
    );
  }

//   Widget buildTransitions(BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation, Widget child) {
//     return FadeTransition(opacity: animation, child: child);
//   }
}

class SecondPage extends StatefulWidget {
  final Widget child;
  final String title, id;
  SecondPage({this.title, this.id, Key key, this.child}) : super(key: key);

  @override
  _SecondPageState createState() => new _SecondPageState(this.title, this.id);
}

class _SecondPageState extends State<SecondPage> {
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List<List<String>> names = new List<List<String>>();
  List<List<String>> filteredNames = new List<List<String>>();
  Icon _searchIcon = new Icon(Icons.search, color: Colors.yellowAccent);
  String title, id;
  Widget _appBarTitle;

  _SecondPageState(this.title, this.id) {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
    _appBarTitle = new Text(this.title, style: TextStyle(color: Colors.white));
  }

  @override
  void initState() {
    this._getNames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("BUILDSECONDPAGE");
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: _buildBar(context),
      body: _buildList(),
      //resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }

  Widget _buildList() {
    print("INSIDE BUILDLIST");
    if (!(_searchText.isEmpty)) {
      print("BUILDING");
      List<List<String>> tempList = new List();
      for (int i = 0; i < filteredNames.length; i++) {
        for (int j = 0; j < filteredNames[i].length; j++) {
          if (filteredNames[i][j]
              .toLowerCase()
              .contains(_searchText.toLowerCase())) {
            tempList.add(filteredNames[i]);
            break;
          }
        }
      }
      filteredNames = tempList;
      for (int i = 0; i < filteredNames.length; i++) {
        for (int j = 0; j < filteredNames[i].length; j++) {
          print(filteredNames[i][j]);
        }
      }
    }

    l = filteredNames.length;

    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: filteredNames == null ? 0 : filteredNames.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 10.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
              child: makeListTile2(index),
            ),
          );
        },
      ),
    );
  }

  int l = 1;
  Widget makeListTile2(index) {
    print("INSIDE MAKE LIST $index");
    if (filteredNames[index].length == 0) {
      print("LEN IS 0");
    } else {
      List<Widget> team = List<Widget>();
      for (int i = 0; i < filteredNames[index].length; i++) {
        print(filteredNames[index][i]);
        print("==");
        // teamNames.add(filteredNames[index][i]);
        team.add(Align(
          alignment: Alignment.centerLeft,
          child: Text('${filteredNames[index][i]}',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ));
        team.add(new Padding(padding: new EdgeInsets.symmetric(vertical: 3.0)));
      }
      print("_____");

      return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        title: Row(children: <Widget>[
          Column(children: team),
          Column(children: <Widget>[
            new Padding(
                padding:
                    new EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0)),
            Align(
              alignment: Alignment.centerRight,
              child: Text('                  Marks',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            new Padding(
                padding:
                    new EdgeInsets.symmetric(horizontal: 13.0, vertical: 3.0)),
            Align(
              alignment: Alignment.centerRight,
              child: Text('                      Selected',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ]),
        ]),
      );
    }
  }

  void _searchPressed() {
    Icon _searchIcon1 = new Icon(Icons.search, color: Colors.yellowAccent);
    Icon _close = new Icon(Icons.close, color: Colors.yellowAccent);

    setState(() {
      if (this._searchIcon.icon == _searchIcon1.icon) {
        this._searchIcon = _close;
        this._appBarTitle = new TextField(
          controller: _filter,
          style: TextStyle(color: Colors.white),
          decoration: new InputDecoration(
              prefixIcon: _searchIcon1, hintText: 'Search...'),
        );
      } else {
        this._searchIcon = _searchIcon1;
        this._appBarTitle =
            new Text(this.title, style: TextStyle(color: Colors.white));
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  void returnAlert(String promptText) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(promptText, textAlign: TextAlign.center),
          actions: <Widget>[
            new FlatButton(
                onPressed: () => Navigator.pop(context), child: new Text('Ok'))
          ],
        );
      },
    );
  }

  void _getNames() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {}
    } on SocketException catch (_) {
      return returnAlert('Connect to Internet and try again!');
    }
    String url = 'http://34.73.200.44/getResult',
        body = '{"event": "${this.id}"}';
    print('Sending request to server');
    final response = await http.post(Uri.encodeFull(url),
        headers: {
          "Accept": "application/json",
          HttpHeaders.contentTypeHeader: 'application/json'
        },
        body: body);
    print('Request Body: ' + body);
    print('Response: ' + response.body.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Response: ' + response.body.toString());
      setState(() {
        Map<String, dynamic> tempResponse =
            Map<String, dynamic>.from(json.decode(response.body));
        List<List<String>> tempList = new List<List<String>>();
        for (int i = 1; i <= tempResponse.keys.length; i++) {
          tempList.add(List<String>.from(tempResponse[i.toString()]['names']));
        }
        names = tempList;
        filteredNames = names;
      });
    }
    print(names);
    print("_GETNAMESENd");
  }
}
