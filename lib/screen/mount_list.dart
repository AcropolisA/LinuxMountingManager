import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:linux_mounting_manager/popup/dialog.dart';
import 'package:linux_mounting_manager/popup/mount_manager_drawer.dart';

class ManagerHomeController extends GetxController {
  RxBool addMode = false.obs;
  changeMode() => addMode.value = !addMode.value;
}

class MountingListState extends StateNotifier<List<Map<String, Object>>> {
  MountingListState() : super(const []);

  static final provider =
      StateNotifierProvider<MountingListState, List<Map<String, Object>>>(
          (_) => MountingListState());
}

// ignore: must_be_immutable
class ManagerHome extends StatelessWidget {
  const ManagerHome({super.key});

  // List<Map<String, String>> mountingList = [
  //   {'Path': '\\smb\\1\\data'},
  //   {'Path': '\\smb\\2\\data'},
  //   {'Path': '\\smb\\3\\data'},
  //   {'Path': '\\smb\\4\\data'},
  //   {'Path': '\\smb\\5\\data'},
  //   {'Path': '\\smb\\6\\data'},
  //   {'Path': '\\smb\\7\\data'},
  //   {'Path': '\\smb\\8\\data'},
  //   {'Path': '\\smb\\9\\data'},
  //   {'Path': '\\smb\\10\\data'},
  //   {'Path': '\\smb\\11\\data'},
  //   {'Path': '\\smb\\12\\data'},
  //   {'Path': '\\smb\\13\\data'},
  //   {'Path': '\\smb\\14\\data'},
  // ];

  @override
  Widget build(BuildContext context) {
    final ManagerHomeController con = Get.put(ManagerHomeController());

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
        title: const Text('Mount List'),
        actions: [
          IconButton(
            iconSize: 40.0,
            // onPressed: con.changeMode,
            onPressed: () => addMountPathPopupDialog(context),
            icon: const Icon(CupertinoIcons.add),
            // icon: con.addMode.value
            //     ? const Icon(CupertinoIcons.arrow_left)
            //     : const Icon(CupertinoIcons.add),
          ),
        ],
      ),
      drawer: const MountManagerDrawer(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SingleChildScrollView(
                  child: Column(
                children: [
                  Expanded(
                    flex: 0,
                    child: Obx(
                      () => Text(con.addMode.value ? 'ADD' : 'LIST'),
                    ),
                  ),
                ],
              )),
              // Obx(
              //   () => Visibility(
              //     visible: con.addMode.value,
              //     child: Expanded(
              //       flex: 0,
              //       child: TextFormField(
              //         autofocus: true,
              //       ),
              //     ),
              //   ),
              // ),
              // Expanded(
              //   flex: 1,
              //   child: HookConsumer(
              //     builder: (context, ref, _) {
              //       final mountingList = ref.watch(MountingListState.provider);

              //       return ListView.separated(
              //           scrollDirection: Axis.vertical,
              //           itemBuilder: (context, index) {
              //             return Text(mountingList[index].toString());
              //           },
              //           separatorBuilder: (context, index) => const Divider(),
              //           itemCount: mountingList.length);
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
