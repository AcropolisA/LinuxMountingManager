import 'package:flutter/material.dart';

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
          SingleChildScrollView(
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
                    print(ModalRoute.of(context)?.settings.name);
                    if (ModalRoute.of(context)?.settings.name ==
                        selected['route']) {
                      // 현재 화면이 선택된 메뉴와 동일하다면 Drawer만 닫기
                      Navigator.of(context).pop();
                    } else {
                      // 선택된 메뉴의 화면으로 이동
                      Navigator.pushReplacementNamed(
                          context, selected['route'].toString());
                    }
                  },
                );
              },
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
