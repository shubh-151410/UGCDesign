library blueShot_bottom_bar;

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:ugcdesign/notched_shapes.dart';

class BlueShotBottomBar extends StatefulWidget {
  Color backgroundColor = Colors.blue;
  double elevation = 10.0;
  final NotchedShape shape;
  List<BlueShotTab> listIcons = new List<BlueShotTab>();
  int initSelected = 0;
  var onBottomSelected;
  double notchMargin;
  Animation<Offset> valueOffset;

  BlueShotBottomBar({
    @required this.listIcons,
    @required this.backgroundColor,
    @required this.onBottomSelected,
    this.elevation = 10.0,
    this.initSelected = 0,
    this.shape,
    this.notchMargin,
    this.valueOffset,
  });

  @override
  _BlueShotBottomBarState createState() => _BlueShotBottomBarState();
}

typedef Widget BlueShotBottomBarBuilder(BuildContext context, int index);

// widget.listIcons[i]

class _BlueShotBottomBarState extends State<BlueShotBottomBar> {
 ValueListenable<ScaffoldGeometry> geometryListenable;
  @override
  void initState() {
    super.initState();
  }
   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    geometryListenable = Scaffold.geometryOf(context);
  }

  @override
  Widget build(BuildContext context) {
    final NotchedShape notchedShap = widget.shape;
     final CustomClipper<Path> clipper = widget.shape != null
      ? _BottomAppBarClipper(
        geometry: geometryListenable,
        shape: notchedShap,
        notchMargin: widget.notchMargin,
      )
      : const ShapeBorderClipper(shape: RoundedRectangleBorder());
    return PhysicalShape(
      clipper: clipper,
      color:widget.backgroundColor ,
          child: Material(
            type: MaterialType.transparency,
        elevation: widget.elevation,
        color: widget.backgroundColor,
        
        child: Container(
          // decoration: BoxDecoration(
          //   shape:BoxShape.rectangle,
          //   border: Border(top:BorderSide(color: Colors.red,width:2.0))
          // ),
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            bottom: Platform.isIOS ? 10.0 : 0.0,
          ),
          height: MediaQuery.of(context).size.height * 0.085,
          child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (int i = 0; i < widget.listIcons.length; i++)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.onBottomSelected(i);
                      widget.initSelected = i;
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.085,
                    width:(i == 1 || i ==2)? MediaQuery.of(context).size.width /
                        widget.listIcons.length:40,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: widget.initSelected == i
                              ? SlideTransition(
                                
                                                              child: BlueShotDelayed(
                                    delay: 20,
                                    child: Text(widget.listIcons[i].title,
                                        style: TextStyle(
                                          color: widget.listIcons[i].iconColor,
                                        )),
                                  ), position: widget.valueOffset,
                              )
                              : widget.listIcons[i],
                        ),
                        if (widget.initSelected == i)
                          SlideTransition(
                            position: widget.valueOffset,
                                                      child: BlueShotDelayed(
                              delay: 20,
                              child: Container(
                                margin: EdgeInsets.only(
                                  // left: MediaQuery.of(context).size.width * 0.003,
                                  top: 5.0,
                                  // bottom: 5.0,
                                ),
                                width: MediaQuery.of(context).size.width * 0.015,
                                height: MediaQuery.of(context).size.width * 0.015,
                                decoration: BoxDecoration(
                                  color: widget.listIcons[i].iconColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      50.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        else
                          Container()
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class BlueShotTab extends StatelessWidget {
  var icon;
  Color iconColor;
  double iconSize;
  String title;
  Animation<Offset> valueSlide;

  BlueShotTab({
    @required this.icon,
    @required this.iconColor,
    @required this.iconSize,
    @required this.title,
    @required this.valueSlide
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: valueSlide,
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: ImageIcon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
          ),
        ],
      ),
    );
  }
}

class BlueShotDelayed extends StatefulWidget {
  final Widget child;
  final int delay;

  BlueShotDelayed({@required this.child, this.delay});

  @override
  _BlueShotDelayedState createState() => _BlueShotDelayedState();
}

class _BlueShotDelayedState extends State<BlueShotDelayed>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    final curve =
        CurvedAnimation(curve: Curves.bounceIn, parent: _controller);
    _animOffset = Tween<Offset>(begin: const Offset(0.0, 0.2), end: Offset.zero)
        .animate(curve);

    if (widget.delay == null) {
      _controller.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _controller,
    );
  }
}
class _BottomAppBarClipper extends CustomClipper<Path> {
  const _BottomAppBarClipper({
    @required this.geometry,
    @required this.shape,
    @required this.notchMargin,
  }) : assert(geometry != null),
       assert(shape != null),
       assert(notchMargin != null),
       super(reclip: geometry);

  final ValueListenable<ScaffoldGeometry> geometry;
  final NotchedShape shape;
  final double notchMargin;

  @override
  Path getClip(Size size) {
    // button is the floating action button's bounding rectangle in the
    // coordinate system whose origin is at the appBar's top left corner,
    // or null if there is no floating action button.
    final Rect button = geometry.value.floatingActionButtonArea?.translate(
      0.0,
      geometry.value.bottomNavigationBarTop * -1.0,
    );
    return shape.getOuterPath(Offset.zero & size, button?.inflate(notchMargin));
  }

  @override
  bool shouldReclip(_BottomAppBarClipper oldClipper) {
    return oldClipper.geometry != geometry
        || oldClipper.shape != shape
        || oldClipper.notchMargin != notchMargin;
  }
}

