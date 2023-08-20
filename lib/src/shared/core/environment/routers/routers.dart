import 'package:flutter_application_1/src/modules/home/presentation/pages/home_page.dart';
import 'package:flutter_application_1/src/modules/secondPage/presentation/pages/second_page.dart';

final routers = {
  '/home': (context) => const HomePage(),
  '/secondPage': (context) => const SecondPage()
};
