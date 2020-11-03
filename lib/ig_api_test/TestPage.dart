import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import './constants.dart';
import 'package:simple_auth/simple_auth.dart' as simpleAuth;
import 'package:simple_auth_flutter/simple_auth_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _errorMsg;
  Map _userData;

  final simpleAuth.InstagramApi _igApi = simpleAuth.InstagramApi(
    "instagram",
    Constants.igClientId,
    Constants.igClientSecret,
    Constants.igRedirectURL,
    scopes: [
      'user_profile',
      'user_media',
    ],
  );

  @override
  void initState() {
    super.initState();
    SimpleAuthFlutter.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'InstaMatch\'s Instagrm Basic Display API Test',
          style: TextStyle(
              color: Colors.grey
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Visibility(
              visible: _userData != null,
              child: Text(
                "We'll display values here",
                textAlign: TextAlign.center,
              ),
              // TODO pass values string here
              replacement:
              Text("Click the button below to get Instagram Login."),
            ),
            FlatButton.icon(
              icon: Icon(Icons.camera_alt),
              label: Text(
                "Get Profile Data",
              ),
              onPressed: _loginAndGetData,
              color: Colors.grey,
            ),
            if (_errorMsg != null) Text("Error occured: $_errorMsg"),
          ],
        ),
      ),
    );
  }

  Future<void> _loginAndGetData() async {
    _igApi.authenticate().then(
          (simpleAuth.Account _user) async {
        simpleAuth.OAuthAccount user = _user;

        var igUserResponse =
        await Dio(BaseOptions(baseUrl: 'https://graph.instagram.com')).get(
          '/me',
          queryParameters: {
            "fields": "username,id,account_type,media_count",
            "access_token": user.token,
          },
        );

        setState(() {
          _userData = igUserResponse.data;
          _errorMsg = null;
        });
      },
    ).catchError(
          (Object e) {
        setState(() => _errorMsg = e.toString());
      },
    );
  }
}
