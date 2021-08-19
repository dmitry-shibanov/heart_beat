import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heart/providers/data_helper.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget {
  int count = 11;
  @override
  Widget build(BuildContext context) {
    final dbHelper = Provider.of<DbHelper>(context);
    final records = dbHelper.records;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
          itemBuilder: (ctx, index) => itemBuilder(ctx, index),
          itemCount: count),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return Card(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/svg/Emoji_normal.svg'),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Title",
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      Text(
                        'Sub Title',
                        style: TextStyle(color: Colors.black, fontSize: 14.0),
                      ),
                    ]),
                Text(
                  'Result',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Text('BPM'),
                IconButton(
                  iconSize: 18.0,
                  icon: Icon(Entypo.cross),
                  color: Colors.grey,
                  onPressed: () async {
                    final result = await showCupertinoDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (ctx) {
                          return CupertinoAlertDialog(
                            title: Text('Delete result?'),
                            content: Text('This action cannot be undone'),
                            actions: [
                              CupertinoDialogAction(
                                child: Text('Cancel'),
                                onPressed: () => Navigator.pop(context, 0),
                              ),
                              CupertinoDialogAction(
                                isDefaultAction: true,
                                child: Text('Delete'),
                                onPressed: () => Navigator.pop(context, 1),
                              ),
                            ],
                          );
                        });
                    print(result);
                  },
                )
              ],
            )));
  }
}
