import 'package:flutter/material.dart';

class SettingListItem extends StatelessWidget {
  late Widget imageItem;
  SettingListItem(this.imageItem);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      child: Container(
        alignment: Alignment.center,
        height: 72.0,
        child: ListTile(
          leading: this.imageItem,
          title: Text(
            'Privacy Policy',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(38, 38, 38, 1),
            ),
          ),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          onTap: () {},
        ),
      ),
    );
  }
}
