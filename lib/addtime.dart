part of 'main.dart';

class AddTimeState extends State<AddTime> {
  final List<List<String>> _times = [];

  void getTime(BuildContext context, int count) async {
    final now = DateTime.now();
    final List<String> _result = [];
    print(_times);
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
    _result.add(
        '${selectedDate.year}/${selectedDate.month + 1}/${selectedDate.day}');
    if (selectedDate == null) {
      return;
    }
    for (var i = 0; i < count; i++) {
      TimeOfDay selectedTime = await showTimePicker(
        initialTime: TimeOfDay.now(),
        context: context,
      );
      if (selectedTime == null) {
        return;
      }
      _result.add('${selectedTime.hour}:${selectedTime.minute}');
    }
    setState(() {
      _times.add(_result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
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
                    child: const Text('ADD DURATION'),
                    onPressed: () {
                      getTime(context, 2);
                    },
                  ),
                  FlatButton(
                    textColor: Colors.indigo,
                    child: const Text('ADD TIME'),
                    onPressed: () {
                      getTime(context, 1);
                    },
                  ),
                ],
              ),
              // Divider(
              //   color: Colors.grey,
              //   indent: 0,
              //   height: 0,
              // ),
              Expanded(
                  child: new CustomScrollView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      slivers: <Widget>[
                    new SliverPadding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0),
                        sliver: new SliverList(
                            delegate: new SliverChildBuilderDelegate(
                          (context, index) => Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new ListTile(
                                  leading: Icon(Icons.access_time),
                                  title: Text(_times[index][0]),
                                  subtitle: Text(_times[index].length>2?'${_times[index][1]}-${_times[index][2]}':'${_times[index][1]}'),
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
                          childCount: _times.length,
                        )))
                  ])),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Go back!'),
              ),
            ])),
      );
    });
  }
}

class AddTime extends StatefulWidget {
  @override
  AddTimeState createState() => AddTimeState();
}
