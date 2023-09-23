import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linux_mounting_manager/popup/mount_manager_drawer.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingController con = Get.put(SettingController());
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        centerTitle: true,
        elevation: 5,
        title: const Text('Setting'),
      ),
      drawer: const MountManagerDrawer(),
    );
  }
}

class SettingController extends GetxController {
  @override
  void onClose() {
    super.onClose();
    print('SettingController has been closed');
  }
}
