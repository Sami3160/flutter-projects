import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:would_you_rather/app/services/local_storage.dart';
import 'package:would_you_rather/app/util/dependency.dart';
import 'package:would_you_rather/presentation/app.dart';

void main() async {
  DependencyCreator.init();
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(App());
}

Future<void> initServices() async {
  print('starting services ...');
  await Get.putAsync(() => LocalStorageService().init());
  print('All services started...');
}
