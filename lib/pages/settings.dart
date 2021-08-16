import 'package:flutter/material.dart';
import 'package:flutter_heart/components/settingsItem.dart';

class SettingsPage extends StatelessWidget {
  final List<String> complexIcons = [
    'assets/images/term_of_use_group/info.png',
    'assets/images/help_group/help1.png',
    'assets/images/about_group/info1.png'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // elevation: 0.0,
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
      ), //Image.asset('assets/images/privacy.png')
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SettingListItem(Image.asset('assets/images/privacy.png')),
              ...complexIcons.map(
                (e) => SettingListItem(
                  Stack(
                    alignment: Alignment(0.0, 0.0),
                    children: [
                      Image.asset('assets/images/about_group/layer.png'),
                      Image.asset(e)
                    ],
                  ),
                ),
              ),
              // Card(
              //   child: Container(
              //     alignment: Alignment.center,
              //     height: 72.0,
              //     child: ListTile(
              //       leading: Stack(
              //         alignment: Alignment(0.0, 0.0),
              //         children: [
              //           Image.asset('assets/images/info_group/layer.png'),
              //           Image.asset('assets/images/info_group/info.png')
              //         ],
              //       ),
              //       title: Text(
              //         'Privacy Policy',
              //         style: TextStyle(
              //           fontSize: 17,
              //           fontWeight: FontWeight.w600,
              //           color: Color.fromRGBO(38, 38, 38, 1),
              //         ),
              //       ),
              //       trailing:
              //           Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              //       onTap: () {},
              //     ),
              //   ),
              // ),
              Image.asset(
                'assets/images/full_heart.png',
                scale: 1.5,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 16, top: 32),
                child: Text(
                  "Heart Rate Monitor:\n bpm | bpm",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(38, 38, 38, 1),
                  ),
                ),
              ),
              Text(
                'V1.0',
                style: TextStyle(color: Colors.grey),
              )
            ]),
      ),
    );
  }
}
