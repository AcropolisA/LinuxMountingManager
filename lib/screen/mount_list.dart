import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:linux_mounting_manager/popup/dialog.dart';
import 'package:linux_mounting_manager/popup/mount_manager_drawer.dart';
import 'package:linux_mounting_manager/service/mount_manager.dart';

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

final fstabEntryListProvider =
    ChangeNotifierProvider<MountManagerNotifier>((ref) {
  return MountManagerNotifier(); // MountManager._instance;
});

// ignore: must_be_immutable
class ManagerHome extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final ManagerHomeController con = Get.put(ManagerHomeController());
    final manager = ref.watch(fstabEntryListProvider);
    final fstabEntries = manager.getList;

    RouteController().setRoute = ModalRoute.of(context)?.settings.name ?? '/';
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
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: fstabEntries.length,
                itemBuilder: (context, index) {
                  final entry = fstabEntries[index];
                  return FutureBuilder<bool>(
                    future: MountManagerNotifier().isMounted(entry),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // 비동기 작업이 아직 완료되지 않았을 때 보여줄 위젯 (예: 로딩 인디케이터)
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        // 오류가 발생했을 때의 처리 (예: 오류 메시지 표시)
                        return ListTile(
                            title: Text('Error: ${snapshot.error}'));
                      }
                      // 데이터가 준비되었을 때의 ListTile
                      bool isMounted = snapshot.data ?? false;
                      return ListTile(
                        title: Text(entry.mountPoint),
                        subtitle: Text(entry.options),
                        trailing: Switch(
                          value: isMounted, // 비동기적으로 가져온 데이터를 여기서 사용
                          onChanged: (check) {},
                        ),
                        onTap: () {},
                        onLongPress: () {},
                        // onFocusChange에 대해서는 ListTile에 해당 속성이 없기 때문에 다른 방법을 고려해야 합니다.
                      );
                    },
                  );
                },
                //     Column(
                //   children: [
                //     Expanded(
                //       flex: 0,
                //       child: Obx(
                //         () => Text(con.addMode.value ? 'ADD' : 'LIST'),
                //       ),
                //     ),
                //   ],
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



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