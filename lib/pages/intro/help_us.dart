import 'package:flutter/material.dart';

class HelpUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'You can help us become even better',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          'Just leave your feedback\n about the app',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 17,
              color: Color.fromRGBO(177, 177, 177, 1)),
        ),
        Container(
          margin: EdgeInsets.only(top: 88.0),
          child: Stack(
            alignment: Alignment(-1.0, 2.23),
            children: [
              Image.asset('assets/images/Friend.png'),
              Image.asset('assets/images/Emoji.png')
            ],
          ),
        )
      ],
    );
  }
}
