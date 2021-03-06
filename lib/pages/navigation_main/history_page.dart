import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heart/models/TestPulse.dart';
import 'package:flutter_heart/providers/data_helper.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget {
  final emojis = [
    'assets/images/svg/Emoji_happy.svg',
    'assets/images/svg/Emoji_normal.svg',
    'assets/images/svg/Emoji_sad.svg'
  ];
  @override
  Widget build(BuildContext context) {
    final dbHelper = Provider.of<DbHelper>(context);
    final records = dbHelper.records;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
          itemBuilder: (ctx, index) =>
              itemBuilder(ctx, records[index], dbHelper),
          itemCount: records.length),
    );
  }

  Widget itemBuilder(BuildContext context, TestPulse pulse, DbHelper dbHelper) {
    DateTime dateTime = pulse.date;
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(emojis[pulse.smile]),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${DateFormat.MMM().format(dateTime)} ${DateFormat.d().format(dateTime)}",
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                  Text(
                    '${DateFormat('hh:mm a').format(dateTime)}',
                    style: TextStyle(color: Colors.black, fontSize: 14.0),
                  ),
                ]),
            Text(
              pulse.metric.toString(),
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text('BPM'),
            IconButton(
              iconSize: 18.0,
              icon: Icon(Entypo.cross),
              color: Colors.grey,
              onPressed: () async {
                await showCupertinoDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (ctx) {
                      return CupertinoAlertDialog(
                        title: Text('Delete result?'),
                        content: Text('This action cannot be undone'),
                        actions: [
                          CupertinoDialogAction(
                            child: Text('Cancel'),
                            onPressed: () => Navigator.pop(context),
                          ),
                          CupertinoDialogAction(
                            isDefaultAction: true,
                            child: Text('Delete'),
                            onPressed: () {
                              dbHelper.removeRecord(pulse: pulse);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
