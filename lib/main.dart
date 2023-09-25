import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linux_mounting_manager/screen/mount_list.dart';
import 'package:linux_mounting_manager/screen/setting.dart';
import 'package:linux_mounting_manager/service/mount_manager.dart';

void main() async {
  await MountManagerNotifier().initialize();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => const ManagerHome());
          case '/setting':
            return MaterialPageRoute(builder: (context) => const Setting());
          default:
            return null;
        }
      },
      themeAnimationDuration: const Duration(milliseconds: 700),
      home: const ManagerHome(),
    );
  }
}
