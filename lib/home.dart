part of 'main.dart';

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
