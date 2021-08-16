import 'package:flutter/material.dart';
import 'package:flutter_heart/pages/intro/help_us.dart';
import 'package:flutter_heart/pages/intro/OnBoardingOne.dart';
import 'package:flutter_heart/pages/intro/onBoardingCommon.dart';
import 'package:flutter_heart/pages/intro/onBoardingFinal.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:rating_dialog/rating_dialog.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController();
  final onBoardingPages = [
    OnBoardingOne(),
    HelpUsPage(),
    OnBoardingCommon(0),
    OnBoardingCommon(1),
    OnBoardingCommon(2),
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
      _inAppReview.requestReview();

    if (await _inAppReview.isAvailable()) {
      print('request actual review from store');
      _inAppReview.requestReview();
    } else {
      print('open actual store listing');
      // TODO: use your own store ids
      _inAppReview.openStoreListing(
        appStoreId: '<your app store id>',
        microsoftStoreId: '<your microsoft store id>',
      );
    }
  }

  // show the rating dialog
  void _showRatingDialog() {
    final _dialog = RatingDialog(
      // your app's name?
      title: 'Rating Dialog',
      // encourage your user to leave a high rating?
      message:
          'Tap a star to set your rating. Add more description here if you want.',
      // your app's logo?
      image: const FlutterLogo(size: 100),
      submitButton: 'Submit',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');

        // TODO: add your own logic
        if (response.rating < 3.0) {
          // send their comments to your email or anywhere you wish
          // ask the user to contact you instead of leaving a bad review
        } else {
          _rateAndReviewApp();
        }
      },
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
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
            margin: EdgeInsets.only(bottom: 48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(6, (index) {
                  String initialImage = 'assets/images/Ellipse.png';
                  if (index == this.currentPage) {
                    initialImage = 'assets/images/Rectangle.png';
                  }
                  return Container(
                    child: Image.asset(initialImage),
                    margin: EdgeInsets.only(right: 6.0),
                  );
                })
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            height: 55.0,
            decoration: ShapeDecoration(
              shape: StadiumBorder(),
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(252, 90, 68, 1),
                  Color.fromRGBO(196, 20, 50, 1)
                ],
              ),
            ),
            child: MaterialButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: StadiumBorder(),
              child: Text(
                'Next',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
              onPressed: _showRatingDialog
              //   print(currentPage);
              //   print(onBoardingPages.length);
              //   if (onBoardingPages.length == currentPage + 1) {
              //     Navigator.pushReplacementNamed(context, '/settings');
              //     await showDialog(
              //       context: context,
              //       builder: (context) => _dialog,
              //     );
              //   } else {
              //     _pageController.animateToPage(
              //       currentPage + 1,
              //       duration: const Duration(milliseconds: 400),
              //       curve: Curves.easeInOut,
              //     );
              //   }
              // },
            ),
          ),
        ],
      ),
    );
  }
}
