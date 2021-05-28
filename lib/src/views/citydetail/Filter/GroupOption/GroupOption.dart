import 'package:den_lineicons/den_lineicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Golo/modules/setting/colors.dart';
import 'package:Golo/modules/setting/fonts.dart';

class Option {
  String title;
  bool isSelected;
  String key;
  Option({this.title, this.isSelected, this.key});
}

class GroupOption extends StatefulWidget {
  final List<Option> options;
  final String title;
  GroupOption({Key key, this.options, this.title}) : super(key: key);

  @override
  _GroupOptionState createState() {
    // TODO: implement createState
    return _GroupOptionState();
  }
}

class _GroupOptionState extends State<GroupOption> {
  bool expanded = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: Column(
        children: <Widget>[
          //Title
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.title ?? "",
                  style: TextStyle(
                      fontFamily: GoloFont,
                      color: GoloColors.secondary1,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25),
                  child: CupertinoButton(
                    padding: EdgeInsets.only(right: 0),
                    onPressed: () {
                      setState(() {
                        expanded = !expanded;
                      });
                    },
                    child: Icon(
                        expanded
                            ? DenLineIcons.angle_up
                            : DenLineIcons.angle_down,
                        size: 12,
                        color: Colors.black),
                  ),
                )
              ],
            ),
          ),
          //Expand view
          ExpanableContainer(
            collaseHeight: 0,
            expanded: expanded,
            expandHeight: 34.0 * widget.options.length,
            child: Column(
              children: _buildOptions(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 25),
            height: 1,
            color: Color(0xffeeeeee),
          )
        ],
      ),
    );
  }

  //
  List<Widget> _buildOptions() {
    return List.generate(widget.options.length, (index) {
      var option = widget.options[index];
      return GestureDetector(
        onTap: () {
          setState(() {
            option.isSelected = !option.isSelected;
          });
        },
        child: Container(
          height: 34,
          child: Row(
            children: <Widget>[
              ImageIcon(
                AssetImage(option.isSelected
                    ? 'assets/iconGolo/checkbox_checked-64.png'
                    : 'assets/iconGolo/checkbox_unchecked-64.png'),
                size: 24,
                color: Colors.black,
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  option.title ?? "",
                  style: TextStyle(
                    fontFamily: GoloFont,
                    fontSize: 16,
                    color: GoloColors.secondary2,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
    //Add line
  }
}

class ExpanableContainer extends StatelessWidget {
  final bool expanded;
  final double collaseHeight;
  final double expandHeight;
  final Widget child;

  ExpanableContainer(
      {Key key,
      this.expanded,
      this.collaseHeight,
      this.expandHeight,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 10),
      child: child,
      curve: Curves.easeInOut,
      height: expanded ? expandHeight : collaseHeight,
    );
  }
}

