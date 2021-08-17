import 'package:flutter/material.dart';

class SettingListItem extends StatelessWidget {
  late Widget imageItem;
  late String title;

  SettingListItem({required this.imageItem, required this.title});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () => null,
        child: Container(
          alignment: Alignment.center,
          height: 72.0,
          child: ListTile(
            leading: this.imageItem,
            title: Text(
              this.title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(38, 38, 38, 1),
              ),
            ),
            trailing:
                const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
