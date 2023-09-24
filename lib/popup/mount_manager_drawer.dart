import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RouteController {
  static final RouteController _instance = RouteController._internal();

  RouteController._internal();

  factory RouteController() {
    return _instance;
  }

  String _route = "";

  get getRoute => _route;
  set setRoute(String route) => _route = route;
}

class MountManagerDrawer extends StatelessWidget {
  const MountManagerDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final drawerMenuList = [
      {
        'name': 'Mount List',
        'route': '/',
      },
      {
        'name': 'Setting',
        'route': '/setting',
      },
    ];

    RouteController routeController = RouteController();

    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10, left: 20),
                child: Text(
                  "Linux Mount Manager",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: SingleChildScrollView(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                separatorBuilder: (context, index) => Container(),
                itemCount: drawerMenuList.length,
                itemBuilder: (context, index) {
                  var selected = drawerMenuList[index];
                  return ListTile(
                    title: Text(
                      selected['name'].toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      if (kDebugMode) {
                        print(routeController.getRoute);
                      }
                      if (routeController.getRoute == selected['route']) {
                        Navigator.of(context).pop();
                      } else {
                        routeController.setRoute = selected['route'].toString();
                        Navigator.pushReplacementNamed(
                            context, selected['route'].toString());
                      }
                    },
                  );
                },
              ),
            ),
          ),
          // const Spacer(),
          // ElevatedButton(
          //   onPressed: () {
          //     SystemNavigator.pop();
          //   },
          //   style: ButtonStyle(
          //     minimumSize: MaterialStateProperty.all<Size>(
          //         const Size(double.infinity, 60)), // 버튼의 최소 크기 설정
          //   ),
          //   child: const Text(
          //     'Program Shutdown',
          //     style: TextStyle(fontSize: 18),
          //   ),
          // ),
        ],
      ),
    );
  }
}
