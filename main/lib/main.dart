import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: new FirstPage(title: 'Events'),
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
  final FirebaseMessaging _messaging = FirebaseMessaging();
  @override
  void initState() {
    super.initState();
    _messaging.getToken().then((token) {
      print("TOkEN");
      print(token);
    });
  }

  Icon _notifyIcon = new Icon(IconData(0xe7f7, fontFamily: 'MaterialIcons'),
      color: Colors.yellowAccent);

  final palette = [
    {'Motorq Hackathon': 0xFFD81B60},
    {'OSPC': 0xFFE53935},
    {'DB Dwellers': 0xFF3949AB},
    {'Mini Placement': 0xFF8E24AA},
    {'Amazon Hiring Event': 0xFD8E24AB},
    {'Paper Presentation': 0xFF00ACC1},
    {'Code \'N Chaos': 0xFF5E35B1},
    {'Parseltongue': 0xFF1E88E5},
    {'OOPS! It\'s Java': 0xFF039BE5},
    {'Web Hub': 0xFF00897B},
  ];
  final dates = [
    {'March 2 & 3': '10:00 AM - 10:00 AM'},
    {'March 8': '9:00 AM - 1:30 PM'},
    {'March 8': '9:00 AM - 1:30 PM'},
    {'March 8': '9:00 AM - 1:30 PM'},
    {'March 8': '9:00 AM - 1:30 PM'},
    {'March 8': '9:00 AM - 1:30 PM'},
    {'March 9': '9:00 PM - 1:30 PM'},
    {'March 9': '9:00 PM - 1:30 PM'},
    {'March 9': '9:00 PM - 1:30 PM'},
    {'March 9': '9:00 PM - 1:30 PM'},
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          appBar: AppBar(
            elevation: 10,
            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
            title: new Text(widget.title),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.list),
                onPressed: () {},
              )
            ],
            bottom: TabBar(
              tabs: [
                Tab(text: "Technical"),
                Tab(
                  text: "Non Technical",
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            new Container(
                margin:
                    new EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
                child: new ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: palette.length,
                  itemBuilder: (context, index) => new Card(
                        elevation: 10.0,
                        margin: new EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        // child: new GestureDetector(

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
                          // color: new Color(palette[index].values.first),
                        ),
                      ),
                )
                // ),

                ),
            new Container(
                margin:
                    new EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
                child: new ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: palette.length,
                  itemBuilder: (context, index) => new Card(
                        elevation: 10.0,
                        margin: new EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        child: new Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(64, 75, 96, .9),
                            // boxShadow: [new BoxShadow(
                            //           color: Color.fromRGBO(64, 75, 99, .6),
                            //           blurRadius: 20.0,
                            //       ),]
                          ),
                          child: makeListTile(index),
                        ),
                      ),
                ))
          ]),
        ),
      ),
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
      title:
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
        new AspectRatio(
            aspectRatio: 100 / 100,
            // Align(
            // alignment: Alignment.center,
            child: Text(
              '${palette[index].keys.first}',
              // style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              // ),
            )),
        FlatButton.icon(
            onPressed: _launchURL,
            icon: new Icon(IconData(0xe88f, fontFamily: 'MaterialIcons'),
                color: Colors.yellowAccent),
            label: Text("")),
      ]),
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
                        Text(' ${dates[index].keys.first}, ',
                            style: TextStyle(color: Colors.white)),
                        Text('${dates[index].values.first}',
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
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton.icon(
                      onPressed: _notifyPressed,
                      icon: _notifyIcon,
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
                //       OutlineButton(
                //   shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                //       child: const Text("View Results"), textColor: Colors.white, onPressed: (){
                //               Navigator.push(
                //               context,
                //               MaterialPageRoute(builder: (context) => ColorPageRoute(palette[index].keys.first)),
                //               );
                //             }),

                //     ),

                OutlineButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: const Text("View Results"),
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).push(new ColorPageRoute());
                    })
              ],
            ),
          ]),
    );
  }

  void _notifyPressed() {
    Icon _notifytemp = new Icon(IconData(0xe7f7, fontFamily: 'MaterialIcons'),
        color: Colors.yellowAccent);
    Icon _notifyOff = new Icon(IconData(0xe7f6, fontFamily: 'MaterialIcons'),
        color: Colors.yellowAccent);
    setState(() {
      if (this._notifyIcon.icon == _notifytemp.icon) {
        this._notifyIcon = _notifyOff;
      } else {
        this._notifyIcon = _notifytemp;
      }
    });
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
  String t;
  // SecondPage(String t){
  //   this.t = t;
  // }
  @override
  _SecondPageState createState() => new _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List<List<String>> names = new List.generate(50, (i) => []);
  List<List<String>> filteredNames = new List.generate(50, (i) => []);
  Icon _searchIcon = new Icon(Icons.search, color: Colors.yellowAccent);
  Widget _appBarTitle = new Text('Event_Name');

  _SecondPageState() {
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
  }

  @override
  void initState() {
    this._getNames();
    super.initState();
  }

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
      for (int i = 0; i < filteredNames[index].length; i++) {
        print(filteredNames[index][i]);
        print("==");
        // teamNames.add(filteredNames[index][i]);
      }
      print("_____");
      return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        title: Row(children: <Widget>[
          Column(children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text('${filteredNames[index][0]}',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            new Padding(padding: new EdgeInsets.symmetric(vertical: 3.0)),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('${filteredNames[index][1]}',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            new Padding(padding: new EdgeInsets.symmetric(vertical: 3.0)),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('${filteredNames[index][2]}',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            new Padding(padding: new EdgeInsets.symmetric(vertical: 3.0)),
          ]),
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
          decoration: new InputDecoration(
              prefixIcon: _searchIcon1, hintText: 'Search...'),
        );
      } else {
        this._searchIcon = _searchIcon1;
        this._appBarTitle = new Text('OSPC');
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  void _getNames() async {
    print("_GETNAMES");
    List<List<String>> tempList = new List.generate(50, (i) => []);

    for (int i = 0; i < 50; i++) {
      for (int j = 0; j < 3; j++) {
        int k = i * 3 + j;
        tempList[i].add("Item $k");
        print("Item $k");
      }
    }

    setState(() {
      names = tempList;
      filteredNames = names;
    });

    print("_GETNAMESENd");
  }
}
