import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class HistoryPage extends StatelessWidget {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: itemBuilder,
      itemCount: count,
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return Card(
        child: Row(
      children: [
        Icon(
          FontAwesome.smile_o,
          color: Colors.yellow,
        ),
        ListTile(
          title: Text('Date'),
          subtitle: Text('other'),
        ),
        Text(
          'Result',
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text('BPM'),
        IconButton(
          icon: Icon(Entypo.cross),
          color: Colors.grey,
          onPressed: () {},
        )
      ],
    ));
  }
}
