import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ugcdesign/add_post.dart';
import 'package:ugcdesign/blue_shot_bottom_bar.dart';
import 'package:ugcdesign/comment_page.dart';
// import 'package:ugcdesign/notched_shapes.dart';
import 'package:ugcdesign/share_Page.dart';

import 'align_mobx.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Counter counter = Counter();
  int _counter = 0;
  double height = 0;
  double width = 0;
  Alignment value = Alignment(0.0, 3.0);
  var thunderGrey = Color(0xFF353b48);
  Animation<Alignment> animation;
  AnimationController animationController;
  AnimationController animationControllerOne;
  Animation degOne;
  Animation rotationAnimation;
  AnimationController animationControllernew;

  AnimationController animationControllerTwo;
  Animation degTwo;
  Animation rotationAnimationTwo;

  // -- Animation for bottom_menu

  AnimationController _controller;
  Animation<Offset> _offsetAnimation;
  AnimationController _controllerBottomBar;
  Animation<Offset> _offsetBottomBarAnimation;

  Animation<Offset> _offsetAnimationOne;
  AnimationController _offsetControllerOne;

  //XXXXXXXXXXXXXXXXXX Animation For Bottom Menu xxxxxxxx

  bool isvisible = true;
  int whichIconUserChoose = 0;
  final GlobalKey _fabKey = GlobalKey();
  var blueDrop = Color(0xFF027EE0);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // For short press btn
  int durationAnimationBtnShortPress = 500;

  AnimationController animControlBtnShortPress;
  Animation zoomIconLikeInBtn2, tiltIconLikeInBtn2;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    final curve =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    animation = Tween<Alignment>(
      begin: Alignment(0.0, 3.0),
      end: Alignment(0.0, 1.0),
    ).animate(curve)
      ..addListener(
        () {
          counter.value = animation.value;
        },
      );

    animControlBtnShortPress = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationBtnShortPress));
    zoomIconLikeInBtn2 =
        Tween(begin: 1.0, end: 0.2).animate(animControlBtnShortPress);
    tiltIconLikeInBtn2 =
        Tween(begin: 0.0, end: 0.8).animate(animControlBtnShortPress);

    zoomIconLikeInBtn2.addListener(() {
      setState(() {});
    });
    tiltIconLikeInBtn2.addListener(() {
      setState(() {});
    });

    animationBottomBar();
    animationBottomBarMenu();
  }

  animationBottomBar() {
    animationControllernew =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    animationControllerOne =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    animationControllerTwo =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    degTwo = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        curve: Curves.elasticInOut, parent: animationControllerTwo));

    degOne = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationControllernew, curve: Curves.elasticInOut));

    rotationAnimation = Tween<double>(begin: 0.0, end: 45.0).animate(
        CurvedAnimation(curve: Curves.easeIn, parent: animationControllerOne));
    animationControllerOne.addListener(() {
      setState(() {});
    });

    animationControllerTwo.addListener(() {
      setState(() {});
    });
  }

  animationBottomBarMenu() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 550),
      vsync: this,
    );
    _controllerBottomBar =
        AnimationController(vsync: this, duration: Duration(milliseconds: 550));
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, 20.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _offsetBottomBarAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, 20.0),
    ).animate(
      CurvedAnimation(
        parent: _controllerBottomBar,
        curve: Curves.easeIn,
      ),
    );
  }

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  void onTapBtn() {
    if (true) {
      if (whichIconUserChoose == 0) {
        isLiked = !isLiked;
      } else {
        whichIconUserChoose = 0;
      }
      if (isLiked) {
        //playSound('short_press_like.mp3');
        animControlBtnShortPress.forward();
      } else {
        animControlBtnShortPress.reverse();
      }
    }
  }

  double handleOutputRangeTiltIconLike(double value) {
    if (value <= 0.2) {
      return value;
    } else if (value <= 0.6) {
      return 0.4 - value;
    } else {
      return -(0.8 - value);
    }
  }

  double handleOutputRangeZoomInIconLike(double value) {
    if (value >= 0.8) {
      return value;
    } else if (value >= 0.4) {
      return 1.6 - value;
    } else {
      return 0.8 + value;
    }
  }

  String getImageIconBtn() {
    if (isLiked) {
      return 'assets/images/ic_like_fill.png';
    } else {
      return 'assets/images/ic_like.png';
    }
  }

  Color getTintColorIconBtn() {
    if (isLiked) {
      return Color(0xff3b5998);
    } else {
      return Colors.black;
    }
  }

  Color getColorTextBtn() {
    if ((isLiked)) {
      return Color(0xff3b5998);
    } else {
      return Colors.black;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animControlBtnShortPress.dispose();
    animationController.dispose();
    animationControllerTwo.dispose();
    animationControllerOne.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset.fromDirection(
                getRadiansFromDegree(0), degOne.value * 80),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationZ(getRadiansFromDegree(0))
                ..scale(degOne.value),
              child: Stack(
                children: <Widget>[
                  Transform.translate(
                    offset: Offset.fromDirection(
                        getRadiansFromDegree(0), degTwo.value * 80),
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(getRadiansFromDegree(0))
                        ..scale(degTwo.value),
                      child: FloatingActionButton(
                          onPressed: () {},
                          elevation: 2.0,
                          backgroundColor: Colors.white,
                          child: Center(
                            child: Text(
                              "GIF",
                              style: TextStyle(color: blueDrop, fontSize: 14),
                            ),
                          )),
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    elevation: 2.0,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.assignment,
                      size: 25,
                      color: blueDrop,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset.fromDirection(
                getRadiansFromDegree(180), degOne.value * 80),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationZ(
                  getRadiansFromDegree(rotationAnimation.value * 0))
                ..scale(degOne.value),
              child: Stack(
                children: <Widget>[
                  Transform.translate(
                    offset: Offset.fromDirection(
                        getRadiansFromDegree(180), degTwo.value * 80),
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(getRadiansFromDegree(0))
                        ..scale(degTwo.value),
                      child: FloatingActionButton(
                        onPressed: () {},
                        elevation: 2.0,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.videocam,
                          size: 25,
                          color: blueDrop,
                        ),
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    elevation: 2.0,
                    mini: false,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.camera_alt,
                      size: 25,
                      color: blueDrop,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform(
            transform: Matrix4.rotationZ(
                getRadiansFromDegree(rotationAnimation.value)),
            alignment: Alignment.center,
            child: Container(
              height: width * 0.13,
              width: width * 0.13,
              child: Center(
                child: FloatingActionButton(
                  onPressed: () {
                    // setState(() {
                    //   animationController.forward();
                    //   this.isvisible = false;
                    // });
                    if (animationControllerOne.isCompleted) {
                      animationControllerTwo.reverse();

                      Future.delayed(Duration(milliseconds: 300), () {
                        animationControllernew.reverse();
                      });

                      Future.delayed(Duration(milliseconds: 300), () {
                        animationControllerOne.reverse();
                      });
                      Future.delayed(Duration(milliseconds: 600), () {
                        // animationControllerOne.reverse();
                        _controllerBottomBar.reverse();
                      });
                      Future.delayed(Duration(milliseconds: 900), () {
                        // animationControllerOne.reverse();
                        _controller.reverse();
                      });
                    } else {
                      animationControllerOne.forward();
                      Future.delayed(Duration(milliseconds: 100), () {
                        animationControllernew.forward();
                      });
                      _controller.forward();
                      _controllerBottomBar.forward();
                      
                      Future.delayed(Duration(milliseconds: 300), () {
                        animationControllerTwo.forward();
                      });
                    }
                    // (animationControllerOne.isCompleted)
                    //     ? animationControllerOne.reverse()
                    //     : animationControllerOne.forward();
                  },
                  elevation: 4.0,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.add,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SlideTransition(
        position: _offsetBottomBarAnimation,
        child: BlueShotBottomBar(
          backgroundColor: Colors.white,
          valueOffset: _offsetAnimation,
          elevation: 20.0,
          shape: CircularNotchedRectangle(),
          initSelected: 0,
          notchMargin: 5.9,
          onBottomSelected: (i) {
            // print(i);nullnull
            //checkUserValid();

            //_dashBoardMobx.currentIndexOfBottmBar = i;
          },
          listIcons: <BlueShotTab>[
            BlueShotTab(
              valueSlide: _offsetAnimation,
              icon: AssetImage(
                "assets/icons/home_1.png",
              ),
              iconColor: blueDrop,
              iconSize: MediaQuery.of(context).size.width * 0.06,
              title: "Home",
            ),
            BlueShotTab(
              valueSlide: _offsetAnimation,
              icon: AssetImage(
                "assets/icons/coffee_cup_2.png",
              ),
              iconColor: blueDrop,
              iconSize: MediaQuery.of(context).size.width * 0.06,
              title: "Coffee",
            ),
            BlueShotTab(
              valueSlide: _offsetAnimation,
              icon: AssetImage(
                "assets/icons/agenda.png",
              ),
              iconColor: blueDrop,
              iconSize: MediaQuery.of(context).size.width * 0.06,
              title: "Events",
            ),
            BlueShotTab(
              valueSlide: _offsetAnimation,
              icon: AssetImage(
                "assets/icons/more.png",
              ),
              iconColor: blueDrop,
              iconSize: MediaQuery.of(context).size.width * 0.06,
              title: "More",
            ),
          ],
        ),
      ),
      body: Container(
        // margin: EdgeInsets.only(top: height * 0.0),
        child: Stack(
          children: <Widget>[
            Container(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: height * 0.6,
                        width: width,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    top: height * 0.02, left: width * 0.03),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: height * 0.07,
                                      width: height * 0.07,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/passport.jpg"),
                                            fit: BoxFit.cover),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.02,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(top: width * 0.01),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "Mr.Smith",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              text: "Bengaluru .",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: "Sep 9,10:14AM",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black
                                                        .withOpacity(0.6),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Icon(Icons.more_vert),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: width * 0.03),
                                width: width,
                                child: Text(
                                  "The Monster family embarks on a vacation on a luxury monster cruise ship so Drac can",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: width * 0.035,
                                  ),
                                ),
                              ),
                              SizedBox(height: height * 0.03),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/image_one.jpg"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              SizedBox(height: height * 0.02),
                              Container(
                                padding: EdgeInsets.only(bottom: width * 0.02),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: onTapBtn,
                                      child: Row(
                                        children: <Widget>[
                                          Transform.scale(
                                            scale:
                                                handleOutputRangeZoomInIconLike(
                                                    zoomIconLikeInBtn2.value),
                                            child: Transform.rotate(
                                              child: Image.asset(
                                                getImageIconBtn(),
                                                width: 22.0,
                                                height: 22.0,
                                                fit: BoxFit.contain,
                                                color: getTintColorIconBtn(),
                                              ),
                                              angle:
                                                  handleOutputRangeTiltIconLike(
                                                      tiltIconLikeInBtn2.value),
                                            ),
                                          ),
                                          SizedBox(width: width * 0.02),
                                          Transform.scale(
                                              child: Text(
                                                "Like",
                                                style: TextStyle(
                                                  color: getColorTextBtn(),
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                              scale:
                                                  handleOutputRangeZoomInIconLike(
                                                      zoomIconLikeInBtn2
                                                          .value)),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    CommentPage(
                                                      profilepic:
                                                          "assets/images/passport.jpg",
                                                      postPic:
                                                          "assets/images/assets/images/image_one.jpg",
                                                    )),
                                            (route) => true);
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          ImageIcon(
                                            AssetImage(
                                                "assets/images/comment.png"),
                                            size: 22,
                                          ),
                                          SizedBox(width: width * 0.02),
                                          Text(
                                            "Comment",
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(_createRoute(SharePage()));
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          ImageIcon(
                                            AssetImage(
                                                "assets/images/share.png"),
                                            size: 22,
                                          ),
                                          SizedBox(width: width * 0.02),
                                          Text(
                                            "Share",
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(color: Colors.white),
                      ),
                      SizedBox(height: height * 0.02),
                      Container(
                        height: height * 0.6,
                        width: width,
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  top: height * 0.02, left: width * 0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: height * 0.07,
                                    width: height * 0.07,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/passport.jpg"),
                                          fit: BoxFit.cover),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.02,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: width * 0.01),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Mr.Jay",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: "Bengaluru .",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: "Sep 9,10:14AM",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black
                                                          .withOpacity(0.6)))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Icon(Icons.more_vert),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: width * 0.03),
                              width: width,
                              child: Text(
                                "The Monster family embarks on a vacation on a luxury monster cruise ship so Drac can",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: width * 0.04),
                              ),
                            ),
                            SizedBox(height: height * 0.03),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/image_four.jpg"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Container(
                              padding: EdgeInsets.only(bottom: width * 0.02),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      children: <Widget>[
                                        ImageIcon(
                                          AssetImage("assets/images/like.png"),
                                          size: 22,
                                        ),
                                        SizedBox(width: width * 0.02),
                                        Text(
                                          "Like",
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      ImageIcon(
                                        AssetImage("assets/images/comment.png"),
                                        size: 22,
                                      ),
                                      SizedBox(width: width * 0.02),
                                      Text(
                                        "Comment",
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      ImageIcon(
                                        AssetImage("assets/images/share.png"),
                                        size: 22,
                                      ),
                                      SizedBox(width: width * 0.02),
                                      Text(
                                        "Share",
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(color: Colors.white),
                      ),
                      SizedBox(height: height * 0.02),
                      Container(
                        height: height * 0.6,
                        width: width,
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  top: height * 0.02, left: width * 0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: height * 0.07,
                                    width: height * 0.07,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/passport.jpg"),
                                          fit: BoxFit.cover),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.02,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: width * 0.01),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Mr.Singh",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: "Bengaluru .",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: "Sep 9,10:14AM",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black
                                                          .withOpacity(0.6)))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Icon(Icons.more_vert),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: width * 0.03),
                              width: width,
                              child: Text(
                                "The Monster family embarks on a vacation on a luxury monster cruise ship so Drac can",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: width * 0.04,
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.03),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/image_three.jpeg"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Container(
                              padding: EdgeInsets.only(bottom: width * 0.02),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      children: <Widget>[
                                        ImageIcon(
                                          AssetImage("assets/images/like.png"),
                                          size: 22,
                                        ),
                                        SizedBox(width: width * 0.02),
                                        Text(
                                          "Like",
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      ImageIcon(
                                        AssetImage("assets/images/comment.png"),
                                        size: 22,
                                      ),
                                      SizedBox(width: width * 0.02),
                                      Text(
                                        "Comment",
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      ImageIcon(
                                        AssetImage("assets/images/share.png"),
                                        size: 22,
                                      ),
                                      SizedBox(width: width * 0.02),
                                      Text("Share",
                                          style: TextStyle(fontSize: 12))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(color: Colors.white),
                      ),
                      SizedBox(height: height * 0.02),
                      Container(
                        height: height * 0.6,
                        width: width,
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  top: height * 0.02, left: width * 0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: height * 0.07,
                                    width: height * 0.07,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/passport.jpg"),
                                          fit: BoxFit.cover),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.02,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: width * 0.01),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Mr.Alex",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                        SizedBox(height: height * 0.01),
                                        RichText(
                                          text: TextSpan(
                                            text: "Bengaluru .",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: "Sep 9,10:14AM",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black
                                                          .withOpacity(0.6)))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Icon(Icons.more_vert),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: width * 0.03),
                              width: width,
                              child: Text(
                                "The Monster family embarks on a vacation on a luxury monster cruise ship so Drac can",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: width * 0.043,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(height: height * 0.03),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/image_two.jpg"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Container(
                              padding: EdgeInsets.only(bottom: width * 0.02),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      children: <Widget>[
                                        ImageIcon(
                                          AssetImage("assets/images/like.png"),
                                          size: 25,
                                        ),
                                        SizedBox(width: width * 0.02),
                                        Text("Like")
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      ImageIcon(
                                        AssetImage("assets/images/comment.png"),
                                        size: 25,
                                      ),
                                      SizedBox(width: width * 0.02),
                                      Text("Comment")
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      ImageIcon(
                                        AssetImage("assets/images/share.png"),
                                        size: 25,
                                      ),
                                      SizedBox(width: width * 0.02),
                                      Text("Share")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: !isvisible,
              child: Container(
                  height: height,
                  width: width,
                  color: Colors.black.withOpacity(0.3)),
            ),
            Observer(builder: (context) {
              return Align(
                alignment: counter.value,
                child: Container(
                  width: width,
                  height: height * 0.3,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment(0.0, -0.2),
                          child: Container(
                            //margin:EdgeInsets.only(top:height*0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    // Select Gif from Gallery
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        height: height * 0.07,
                                        width: height * 0.07,
                                        padding: EdgeInsets.all(10.0),
                                        child: ImageIcon(
                                          AssetImage(
                                              "assets/images/gifnew.png"),
                                          size: 20,
                                        ),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                      ),
                                      SizedBox(height: height * 0.01),
                                      Text("GIF",
                                          style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    //Open Photo SelectDialog
                                    selectImage();
                                    animationController.reverse().then((value) {
                                      setState(() {
                                        isvisible = true;
                                      });
                                    });
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        height: height * 0.07,
                                        width: height * 0.07,
                                        child: Icon(Icons.image, size: 30),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                      ),
                                      SizedBox(height: height * 0.01),
                                      Text(
                                        "Image",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    //Open Select Video Dialog from
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        height: height * 0.07,
                                        width: height * 0.07,
                                        child: Icon(Icons.videocam, size: 30),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                      ),
                                      SizedBox(height: height * 0.01),
                                      Text(
                                        "Video",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    //Open Write Text Content
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        height: height * 0.07,
                                        width: height * 0.07,
                                        child: Icon(Icons.assignment, size: 30),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                      ),
                                      SizedBox(height: height * 0.01),
                                      Text("Text",
                                          style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: IconButton(
                        icon: Icon(Icons.clear, color: Colors.white, size: 45),
                        onPressed: () {
                          animationController.reverse().then((value) {
                            setState(() {
                              isvisible = true;
                            });
                          });
                        },
                      ))
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF0f5e9e),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  selectImage() {
    showDialog(
      context: context,
      builder: (BuildContext ctxt) {
        return AlertDialog(
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    child: Text('Take Photo'),
                    onPressed: () async {
                      Navigator.pop(context);
                      await selectFromCamera();
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    child: Text(
                      'Choose From Gallery',
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                      await selectGallery();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  selectFromCamera() async {
    File image = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
    );
    try {
      // await _cropImage(image);
      Navigator.of(context).push(
        _createRoute(
          AddPost(
            fileData: image,
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<Null> _cropImage(File imageFile) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(ratioY: 2.0, ratioX: 2.0),
      maxHeight: 512,
      maxWidth: 512,
    );
    Navigator.of(context).push(
      _createRoute(
        AddPost(
          fileData: croppedFile,
        ),
      ),
    );
  }

  selectGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 512, maxWidth: 512);
    try {
      // await _cropImage(image);
      Navigator.of(context).push(
        _createRoute(
          AddPost(
            fileData: image,
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Widget get _fab {
    return AnimatedBuilder(
        animation: ModalRoute.of(context).animation,
        child: FloatingActionButton(
          key: _fabKey,
          child: SizedBox(width: 24, height: 24, child: Icon(Icons.edit)),
          backgroundColor: Colors.blue,
          onPressed: () => Navigator.of(context).push(
            ScaleRoute(page: AddPost()),
          ),
        ),
        builder: (BuildContext context, Widget fab) {
          final Animation<double> animation = ModalRoute.of(context).animation;
          return SizedBox(
            width: 54 * animation.value,
            height: 54 * animation.value,
            child: fab,
          );
        });
  }
}

Route _createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class ScaleRoute extends PageRouteBuilder {
  final Widget page;
  ScaleRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          ),
        );
}
