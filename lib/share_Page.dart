import 'package:flutter/material.dart';

class SharePage extends StatefulWidget {
  SharePage({Key key}) : super(key: key);

  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  double height = 0;
  double width = 0;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Share Post"),
        actions: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.only(right: 10),
              child: GestureDetector(
                  child: Text(
                "Post",
                style: TextStyle(fontSize: 18),
              )),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(child: buildSharePostBody()),
    );
  }

  Widget buildSharePostBody() {
    return Container(
      padding: EdgeInsets.only(top: height * 0.02, left: width * 0.03),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                SizedBox(width: width * 0.02),
                Container(
                  child: Text(
                    "Mr.Smith",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: TextField(
                decoration: InputDecoration(
              hintText: "Write something or Add a hashtag",
              hintStyle: TextStyle(fontSize: 18),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            )),
          ),
          SizedBox(
            height:height*0.04
          ),
          Container(
            child: buildSharedDataPost(),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.grey[300], width: 1.0)),
          ),
        ],
      ),
    );
  }

  Widget buildSharedDataPost() {
    return Column(
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
            ],
          ),
        ),
        SizedBox(
          height: height * 0.02,
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
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: height * 0.03),
        Container(
          height: height * 0.4,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/image_one.jpg"),
                fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }
}
