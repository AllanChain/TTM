import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  var _tasks = new Map();

  void getTime() async {
    final now = DateTime.now();
    DateTime selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 9),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (selectedDate != null) {
      print(selectedDate.toIso8601String());
      TimeOfDay selectedTime = await showTimePicker(
        initialTime: TimeOfDay.now(),
        context: context,
      );
      if (selectedTime != null) {
        print(selectedTime.format(context));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    for (var i = 0; i < _dayNames.length; i++) {
      _tasks[_dayNames[i]] = ['hello', 'bye', '', 'fuck', 'damn'];
    }
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(widget.title),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddTime()));
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
          body: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: viewportConstraints.maxHeight,
              ),
              child: Column(children: <Widget>[
                Row(
                    children: _dayNames.map<Widget>((day) {
                  return Expanded(child: Text(day));
                }).toList()),
                Expanded(
                    child: new CustomScrollView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        slivers: <Widget>[
                      new SliverPadding(
                          padding: const EdgeInsets.symmetric(vertical: 0.0),
                          sliver: new SliverList(
                              delegate: new SliverChildBuilderDelegate(
                            (context, index) => Row(
                                children: _dayNames.map<Widget>((day) {
                              return Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                //        mainAxisAlignment: MainAxisAlignment.center,
                                children: _tasks[_dayNames[index]]
                                    .map<Widget>((task) {
                                  return Container(
                                    // grey box
                                    child: Text(
                                      task,
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Georgia",
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: task != ''
                                          ? Colors.grey[300]
                                          : Colors.white,
                                    ),
                                    height: 200,
                                  );
                                }).toList(),
                              ));
                            }).toList()),
                            childCount: 1,
                          )))
                    ]))
              ])));
    });
  }
}

class AddTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Time"),
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(children: <Widget>[
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.alarm,
                  color: Colors.lime,
                ),
                FlatButton(
                  textColor: Colors.indigo,
                  child: const Text('ADD TIME'),
                  onPressed: () {/* ... */},
                ),
              ],
            ),
            // Divider(
            //   color: Colors.grey,
            //   indent: 0,
            //   height: 0,
            // ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.access_time),
                    title: Text('Thursday'),
                    subtitle: Text('8:00 - 9:50'),
                  ),
                  ButtonTheme.bar(
                    // make buttons use the appropriate styles for cards
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('Edit'),
                          onPressed: () {/* ... */},
                        ),
                        FlatButton(
                          child: const Text('Delete'),
                          onPressed: () {/* ... */},
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back!'),
            ),
          ])),
    );
  }
}
