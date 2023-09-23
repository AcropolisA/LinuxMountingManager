import 'package:flutter/material.dart';

Future<void> addMountPathPopup(BuildContext context) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Center(
          child: Text('Add Mount Path'),
        ),
        content: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [],
        ),
        actionsAlignment: MainAxisAlignment.end,
        actionsOverflowAlignment: OverflowBarAlignment.end,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Confirm'),
          ),
        ],
      );
    },
  );
}

Future<void> addMountPathPopupDialog(BuildContext context) async {
  final width = MediaQuery.of(context).size.width * .05 / 2;
  final height = MediaQuery.of(context).size.height * .05 / 2;
  const titleSize = 28.0;
  const buttonSize = 20.0;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                  left: width,
                  right: width,
                  top: height,
                  bottom: height,
                ),
                child: const Text(
                  'Add Mount Path',
                  style: TextStyle(fontSize: titleSize),
                ),
              ),
            ),
            const Divider(),
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [],
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(
                left: width,
                right: width,
                top: height,
                bottom: height,
              ),
              child: Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Close',
                      style: TextStyle(fontSize: buttonSize),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Confirm',
                      style: TextStyle(fontSize: buttonSize),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
