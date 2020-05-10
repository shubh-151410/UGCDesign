import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  String profilepic;
  String postPic;
  CommentPage({Key key, this.profilepic, this.postPic}) : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  double height = 0;
  double width = 0;
  double opacityValue = 0.6;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: widgetbuildBody(),
    );
  }

  Widget widgetbuildBody() {
    return Container(
      height: height,
      child: Stack(
        // alignment: Alignment.bottomCenter,
        children: <Widget>[
          buildCommentPostWidget(),
          Positioned(
            bottom: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.08,
                child: buildcommentsendWidget(),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border:
                      Border(top: BorderSide(color: Colors.grey, width: 1.0)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCommentPostWidget() {
    return Container(
      height: height * 0.8,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: height * 0.02, left: width * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: height * 0.07,
                    width: height * 0.07,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/passport.jpg"),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Mr.Smith",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(height: height * 0.01),
                        RichText(
                          text: TextSpan(
                            text: "Bengaluru .",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Sep 9,10:14AM",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black.withOpacity(0.6)))
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
            Container(
              height: height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/image_one.jpg"),
                    fit: BoxFit.contain),
              ),
            ),
            SizedBox(height: height * 0.02),
            Container(
              padding: EdgeInsets.only(bottom: width * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  GestureDetector(
                    onTap: () {
                      // Navigator.pushAndRemoveUntil(
                      //     context,
                      //     CupertinoPageRoute(
                      //         builder: (context) =>
                      //             CommentPage(profilepic: "assets/images/passport.jpg",postPic: "assets/images/assets/images/image_one.jpg",)),
                      //     (route) => true);
                    },
                    child: Row(
                      children: <Widget>[
                        ImageIcon(
                          AssetImage("assets/images/comment.png"),
                          size: 25,
                        ),
                        SizedBox(width: width * 0.02),
                        Text("Comment")
                      ],
                    ),
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
            Container(
              margin: EdgeInsets.only(top: width * 0.03, left: width * 0.02),
              alignment: Alignment.centerLeft,
              child: Text(
                "Comments",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.only(left: width * 0.02, top: width * 0.02),
                    height: height * 0.05,
                    width: height * 0.05,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(widget.profilepic),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(width: width * 0.01),
                  Container(
                    width: width * 0.85,
                    margin: EdgeInsets.only(top: width * 0.02),
                    padding: EdgeInsets.all(width * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Shubhanshu",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Software Developer At Ijeeni",
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.7)),
                          ),
                        ),
                        Container(child: Text("2h")),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Container(
                            child: Text(
                                "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout."))
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey[300].withOpacity(0.7),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0))),
                  )
                ],
              ),
            ),
            SizedBox(height: height * 0.01),
            Container(
              margin: EdgeInsets.only(bottom: width * 0.02),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: height * 0.05 + width * 0.045,
                  ),
                  Container(
                    child: ImageIcon(
                      AssetImage("assets/images/like.png"),
                      size: 20,
                    ),
                  ),
                  SizedBox(width: width * 0.02),
                  Container(
                    height: width * 0.05,
                    width: width * 0.008,
                    color: Colors.grey,
                  ),
                  SizedBox(width: width * 0.02),
                  Container(
                    child: ImageIcon(
                      AssetImage("assets/images/comment.png"),
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.only(left: width * 0.02, top: width * 0.02),
                    height: height * 0.05,
                    width: height * 0.05,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(widget.profilepic),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(width: width * 0.01),
                  Container(
                    width: width * 0.85,
                    margin: EdgeInsets.only(top: width * 0.02),
                    padding: EdgeInsets.all(width * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Shivam Singh",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Software Developer Enginner At Amazon",
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.7)),
                          ),
                        ),
                        Container(child: Text("2d")),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Container(
                            child: Text(
                                "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout."))
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey[300].withOpacity(0.7),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0))),
                  )
                ],
              ),
            ),
            SizedBox(height: height * 0.01),
            Container(
              margin: EdgeInsets.only(bottom: width * 0.02),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: height * 0.05 + width * 0.045,
                  ),
                  Container(
                    child: ImageIcon(
                      AssetImage("assets/images/like.png"),
                      size: 20,
                    ),
                  ),
                  SizedBox(width: width * 0.02),
                  Container(
                    height: width * 0.05,
                    width: width * 0.008,
                    color: Colors.grey,
                  ),
                  SizedBox(width: width * 0.02),
                  Container(
                    child: ImageIcon(
                      AssetImage("assets/images/comment.png"),
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildcommentsendWidget() {
    return Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                top: width * 0.03, left: width * 0.02, bottom: width * 0.02),
            height: height * 0.05,
            width: height * 0.05,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(widget.profilepic), fit: BoxFit.cover)),
          ),
          SizedBox(width: width * 0.03),
          Container(
              alignment: Alignment.center,
              width: width * 0.7,
              margin: EdgeInsets.only(top: width * 0.01),
              child: TextField(
                  maxLines: 5,
                  onChanged: (value) {
                    if (value.length > 0) {
                      setState(() {
                        opacityValue = 1.0;
                      });
                    } else {
                      setState(() {
                        opacityValue = 0.6;
                      });
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Leave your thoughts here..."))),
          AnimatedOpacity(
            opacity: opacityValue,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
            child: Text(
              "POST",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
