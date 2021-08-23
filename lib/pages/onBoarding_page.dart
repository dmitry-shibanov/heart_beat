import 'package:flutter/material.dart';
import 'package:flutter_heart/components/button.dart';
import 'package:flutter_heart/pages/intro/help_us.dart';
import 'package:flutter_heart/pages/intro/OnBoardingOne.dart';
import 'package:flutter_heart/pages/intro/onBoardingCommon.dart';
import 'package:flutter_heart/pages/intro/onBoardingFinal.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:in_app_review/in_app_review.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController();
  final onBoardingPages = [
    OnBoardingOne(),
    HelpUsPage(),
    OnBoardingCommon(
      imageStr: 'assets/images/gif/green_man.json',
      content: 'Hold your finger on the camera lens and the flashlight',
    ),
    OnBoardingCommon(
      imageStr: 'assets/images/gif/run_man.json',
      content:
          'The orthostatic test is one of the tools that allows you to find a balance between training and recovery',
    ),
    OnBoardingCommon(
      imageStr: 'assets/images/gif/bodybuilding_man.json',
      content:
          'The orthostatic test is one of the tools that allows you to find a balance between training and recovery',
    ),
    OnBoardingFinal()
  ];
  int currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _rateAndReviewApp() async {
    final _inAppReview = InAppReview.instance;
    if (await _inAppReview.isAvailable()) {
      _inAppReview.requestReview();
    } else {
      // TODO: use your own store ids
      _inAppReview.openStoreListing(
        appStoreId: '<your app store id>',
        microsoftStoreId: '<your microsoft store id>',
      );
    }
  }

  void onPressButton() {
    if (onBoardingPages.length == currentPage + 1) {
      Navigator.pushReplacementNamed(context, '/main');
    } else {
      _pageController.animateToPage(
        currentPage + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      if (currentPage + 1 == 1) {
        _rateAndReviewApp();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: currentPage == 5
            ? IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Color.fromRGBO(70, 70, 70, 1),
                ),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/main'),
              )
            : null,
        backgroundColor: Colors.white10,
        elevation: 0.0,
        actions: [
          if (currentPage == 5)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              height: 15.0,
              decoration: ShapeDecoration(
                shape: StadiumBorder(),
              ),
              child: MaterialButton(
                height: 15.0,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: const StadiumBorder(),
                child: const Text(
                  'Restore Purcheses',
                  style: TextStyle(
                      color: Color.fromRGBO(70, 70, 70, 1),
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
                onPressed: () async {},
              ),
            )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            child: PageView(
              controller: _pageController,
              physics: new NeverScrollableScrollPhysics(),
              children: onBoardingPages,
              onPageChanged: (currentPage) {
                setState(() {
                  this.currentPage = currentPage;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 36),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(6, (index) {
                  String initialImage = 'assets/images/Ellipse.png';
                  if (index == this.currentPage) {
                    initialImage = 'assets/images/Rectangle.png';
                  }
                  return Container(
                    child: Image.asset(
                      initialImage,
                      scale: 3,
                    ),
                    margin: EdgeInsets.only(right: 6.0),
                  );
                })
              ],
            ),
          ),
          if (currentPage == 5)
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: Text(
                'FREE unlimited access',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                  color: Color.fromRGBO(38, 38, 38, 1),
                ),
              ),
            ),
          Button(
            height: MediaQuery.of(context).size.height * 0.06,
            insetsGeometry: EdgeInsets.symmetric(horizontal: 16.0),
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(252, 90, 68, 1),
                Color.fromRGBO(196, 20, 50, 1)
              ],
            ),
            onPressed: onPressButton,
            title: currentPage == 5 ? 'Subscribe' : 'Next',
          ),
          if (currentPage == 5)
            Container(
              margin: EdgeInsets.only(right: 24.0, left: 24.0, top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(70, 70, 70, 1)),
                  ),
                  Text(
                    'Terms Of Use',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(70, 70, 70, 1)),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}
