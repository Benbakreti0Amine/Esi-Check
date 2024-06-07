
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/utils/prefrences.dart';


import 'app/main_app.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  Prefrences.checkLoginStatus().then(
    (value) => runApp(
      MainApp(
        isLoggedIn: value,
      ),
    ),
  );
}
