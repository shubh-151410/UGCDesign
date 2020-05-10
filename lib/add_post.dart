// import 'package:flutter/material.dart';

// class AddPost extends StatefulWidget {

//   //  const AddPost({Key key, @required this.sourceRect})
//   //     : assert(sourceRect != null),
//   //       super(key: key);

//   // static Route<dynamic> route(BuildContext context, GlobalKey key) {
//   //   final RenderBox box = key.currentContext.findRenderObject();
//   //   final Rect sourceRect = box.localToGlobal(Offset.zero) & box.size;

//   //   return PageRouteBuilder<void>(
//   //     pageBuilder: (BuildContext context, _, __) => AddPost(sourceRect: sourceRect),
//   //     transitionDuration: const Duration(milliseconds: 350),
//   //   );
//   // }

//   // final Rect sourceRect;
//   @override
//   _AddPostState createState() => _AddPostState();
// }

// class _AddPostState extends State<AddPost> {
//   @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       backgroundColor: Colors.blue,
//     ),
//   );
// }
// }

import 'dart:io';

import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  File fileData;
  AddPost({this.fileData});
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  double height = 0;
  double width = 0;
  @override
  Widget build(BuildContext context) {
    print(widget.fileData);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Add post"),
          actions: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.only(right: 10),
                child: GestureDetector(
                    child: Text(
                  "Submit",
                  style: TextStyle(fontSize: 18),
                )),
              ),
            )
          ],
        ),
        body: _buildAddPostWidget());
  }

  Widget _buildAddPostWidget() {
    return Container(
      height: height,
      child: Stack(
        children: <Widget>[
          addPostWidget(),
        ],
      ),
    );
  }

  Widget addPostWidget() {
    return Container(
      margin: EdgeInsets.only(
          left: width * 0.04, right: width * 0.04, top: height * 0.03),
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
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: TextField(
                decoration: InputDecoration(
              hintText: "Write something or Add a hashtag",
              hintStyle: TextStyle(fontSize: 13),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            )),
          ),
          SizedBox(height: height * 0.04),
          Container(
            child: Image.file(
              widget.fileData,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
