import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/debug/log/Log.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/src/connector/ISchoolConnector.dart';
import 'package:flutter_app/src/connector/NTUTConnector.dart';
import 'package:flutter_app/src/store/DataModel.dart';
import 'package:flutter_app/src/store/dataformat/UserData.dart';
import 'package:flutter_app/src/taskcontrol/TaskHandler.dart';
import 'package:flutter_app/src/taskcontrol/task/NTUTLoginTask.dart';
import 'package:flutter_app/ui/other/CustomRoute.dart';
import 'package:flutter_app/ui/other/MyAlertDialog.dart';
import 'package:flutter_app/ui/other/MyProgressDialog.dart';
import 'package:flutter_app/ui/pages/login/LoginPage.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import '../../../main.dart';
import 'pages/SettingScreen.dart';
import 'pages/NewAnnouncementScreen.dart';
import 'pages/home_screen.dart';
import 'pages/pages_screen.dart';

class BottomNavigationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomNavigationWidgetState();
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final _bottomNavigationColor = Colors.blue;
  int _currentIndex = 0;
  List<Widget> list = List();
  @override
  void initState() {
    list
      ..add(HomeScreen())
      ..add(NewAnnouncementScreen())
      ..add(PagesScreen())
      ..add(SettingScreen());
    super.initState();
    UserData user = DataModel.instance.user;
    user.load().then((value) {
      if (!value) {
        //尚未登入
        Navigator.of(context).push(CustomRoute(LoginPage()));
      } else {
        _login();
      }
    });
  }

 void _login() {
    TaskHandler.instance.addTask( NTUTLoginTask(context) );
    TaskHandler.instance.startTask();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: list[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.announcement,
                    color: _bottomNavigationColor,
                  ),
                  title: Text(
                    'New',
                    style: TextStyle(color: _bottomNavigationColor),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.email,
                    color: _bottomNavigationColor,
                  ),
                  title: Text(
                    'Email',
                    style: TextStyle(color: _bottomNavigationColor),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.pages,
                    color: _bottomNavigationColor,
                  ),
                  title: Text(
                    'PAGES',
                    style: TextStyle(color: _bottomNavigationColor),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    color: _bottomNavigationColor,
                  ),
                  title: Text(
                    'Setting',
                    style: TextStyle(color: _bottomNavigationColor),
                  )),
            ],
            currentIndex: _currentIndex,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.shifting,
          ),
        ));
  }
}
