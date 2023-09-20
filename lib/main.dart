import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
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
      home: const ManagerHome(),
    );
  }
}

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
class ManagerHome extends HookConsumerWidget {
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
    final mountingList = useState(MountingListState.provider);
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
          Obx(
            () => IconButton(
              iconSize: 40.0,
              onPressed: con.changeMode,
              icon: con.addMode.value
                  ? const Icon(CupertinoIcons.arrow_left)
                  : const Icon(CupertinoIcons.add),
            ),
          )
        ],
      ),
      drawer: const Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Text('Drawer'),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: Expanded(
                  flex: 0,
                  child: Obx(
                    () => Text(con.addMode.value ? 'ADD' : 'LIST'),
                  ),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: con.addMode.value,
                  child: Expanded(
                    flex: 0,
                    child: TextFormField(
                      autofocus: true,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: HookConsumer(
                  builder: (context, ref, _) {
                    final mountingList = ref.watch(MountingListState.provider);

                    return ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Text(mountingList[index].toString());
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: mountingList.length);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
