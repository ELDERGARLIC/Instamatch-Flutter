import 'package:flutter/material.dart';
import 'package:instamatch/ui/constants.dart';
import 'package:instamatch/ui/pages/matches.dart';
import 'package:instamatch/ui/pages/settings.dart';
import 'package:instamatch/ui/pages/explore.dart';

class Tabs extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Search(),
      Matches(),
      Messages(),
    ];

    return Theme(
      data: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.grey,
      ),
      child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                  'InstaMatch',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.exit_to_app, color: Colors.black,),
                    onPressed: () {

                    },
                ),
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(48),
                child: Container(
                  height: 48.0,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TabBar(
                          tabs: <Widget>[
                            Tab(icon: Icon(Icons.explore, color: Colors.black,),),
                            Tab(icon: Icon(Icons.people, color: Colors.black,),),
                            Tab(icon: Icon(Icons.settings, color: Colors.black,),),
                          ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: TabBarView(
              children: pages,
            ),
          ),
      ),
    );
  }
}
