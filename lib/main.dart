import 'package:flutter/material.dart';

import 'core/services/services_locator.dart';
import 'my_app/my_app.dart';

void main() {
  ServicesLocator().init();
  runApp(MovieApp());
}
