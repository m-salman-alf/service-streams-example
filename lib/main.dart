import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:service_streams_example/api/api.dart';
import 'package:service_streams_example/screens/home/home_controller.dart';
import 'package:service_streams_example/screens/home/home_view.dart';
import 'package:service_streams_example/screens/settings/settings_controller.dart';
import 'package:service_streams_example/screens/settings/settings_view.dart';
import 'package:service_streams_example/services/authentication_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Service Streams Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      initialBinding: BindingsBuilder(() {
        final api = Api();

        final authenticationService = Get.put(AuthenticationService(api));

        Get.lazyPut(() => HomeController(authenticationService));

        Get.lazyPut(() => SettingsController(authenticationService, api));
      }),
    );
  }
}

/// Using [StatefulWidget] because I'm lazy.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;

  void _onIndexTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Service Streams Example'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _index,
        onTap: _onIndexTapped,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_index),
      ),
    );
  }
}
