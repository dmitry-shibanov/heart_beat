import 'package:flutter/material.dart';

class OrthostaticTestIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Text(
            'Orthostatic test is an easy way to monitor the state of your body and its adaptation to stress',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              color: Color.fromRGBO(38, 38, 38, 1),
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'The essence of the test is simple and consists in measuring the pulse lying down and then standing - the difference between these two measurements can tell a lot about your form, the degree of fatigue, the general state of the body, as well as signal problems in the central nervous and cardiovascular systems.,',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(70, 70, 70, 1),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
                height: 55.0,
                decoration: ShapeDecoration(
                  shape: StadiumBorder(),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(252, 90, 68, 0.5),
                      Color.fromRGBO(196, 20, 50, 0.5)
                    ],
                  ),
                ),
                child: MaterialButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: StadiumBorder(),
                  child: Text(
                    'Start',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () async {},
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
