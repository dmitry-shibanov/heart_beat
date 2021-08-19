import 'package:flutter/material.dart';
import 'package:flutter_heart/components/settingsItem.dart';

class SettingsPage extends StatelessWidget {
  final _map = {
    'Term of Use': 'assets/images/term_of_use.png',
    'Support': 'assets/images/help.png',
    'About app': 'assets/images/info.png'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.blue),
        backgroundColor: Colors.white,
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(right: 24.0, left: 24.0, top: 40.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SettingListItem(
                imageItem: Image.asset('assets/images/privacy.png'),
                title: 'Privacy Policy',
              ),
              ..._map.entries
                  .map(
                    (entry) => SettingListItem(
                      imageItem: Stack(
                        alignment: Alignment(0.0, 0.0),
                        children: [
                          Image.asset('assets/images/layer.png', scale: 3,),
                          Image.asset(entry.value)
                        ],
                      ),
                      title: entry.key,
                    ),
                  )
                  .toList(),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 24.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/smaller_heart.png',
                            scale: 3,
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
                ),
              )
            ]),
      ),
    );
  }
}
