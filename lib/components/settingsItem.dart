import 'package:flutter/material.dart';

class SettingListItem extends StatelessWidget {
  late final Widget imageItem;
  late final String title;
  late final double height;

  SettingListItem(
      {required this.imageItem, required this.title, this.height = 72.0});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () => null,
        child: Container(
          alignment: Alignment.center,
          height: height,
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
