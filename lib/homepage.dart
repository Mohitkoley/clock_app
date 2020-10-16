import 'package:clock_app/menu_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'clock_view.dart';
import 'data.dart';
import 'enums.dart';
import 'menu_info.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEE,d MMM').format(now);
    var timezoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';
    if(!timezoneString.startsWith('-'))
      offsetSign = '+';
    print(timezoneString);
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems.map((currentMenuInfo) => buildMenuButton(currentMenuInfo)).toList(),

          ),
          VerticalDivider(color: Colors.white54, width: 1,),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32,vertical: 64),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex:1,
                    fit: FlexFit.tight,
                    child: Text(
                      'clock',
                      style: TextStyle(
                          fontFamily: 'avenir',
                          color: Colors.white,
                          fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattedTime,style: TextStyle(fontFamily: 'avenir',color: Colors.white,fontSize: 60),
                        ),
                        Text(
                          formattedDate,
                          style: TextStyle(
                              fontFamily: 'avenir',
                              color: Colors.white,
                              fontSize: 22,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),


                  Flexible(
                      flex: 5,
                      fit: FlexFit.tight,
                      child: Align(
                          alignment: Alignment.center,
                          child: ClockView(size: MediaQuery.of(context).size.height / 3,)
                      )
                  ),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Timezone',
                          style: TextStyle(
                              fontFamily: 'avenir',
                              color: Colors.white,
                              fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      Icon(
                        Icons.language_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8,),
                      Text(
                        'UTC' + offsetSign + timezoneString,
                        style: TextStyle(
                            fontFamily: 'avenir',
                            color: Colors.white,
                            fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(height: 12,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo,) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget child){
      return FlatButton(
              padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 0),
              color: currentMenuInfo.menuType == value.menuType
                  ? Color(0xFF5A575C)
                  : Colors.transparent,
              onPressed: () {
                var menuInfo = Provider.of<MenuInfo>(context,listen: false);
                menuInfo.updateMenu(currentMenuInfo);
              },
              child: Column(
                children: [
                  Image.asset(
                    currentMenuInfo.imageSource,
                    scale: 1.5,
                  ),
                  SizedBox(height: 16,),
                  Text(
                    currentMenuInfo.title ?? '',
                    style: TextStyle(fontFamily: 'avenir', color: Colors.white,fontSize: 14),),
                ],
              ),
            );
  },);
  }
}


