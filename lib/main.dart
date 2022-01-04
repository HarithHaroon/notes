import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/remotes/helpers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  BlocOverrides.runZoned(
    () async {
      await CacheHelper.init();

      String? gridOrList = CacheHelper.getData(key: 'gridOrList');

      if (gridOrList == null) {
        CacheHelper.putString(key: 'gridOrList', value: 'grid');
      }

      runApp(const App());
    },
  );
}
