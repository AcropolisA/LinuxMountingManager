import 'dart:io';

import 'package:flutter/foundation.dart';

class FstabEntry {
  final String fileSystem;
  final String mountPoint;
  final String type;
  final String options;
  final int dump;
  final int pass;

  FstabEntry(this.fileSystem, this.mountPoint, this.type, this.options,
      this.dump, this.pass);

  @override
  String toString() {
    return '$fileSystem $mountPoint $type $options $dump $pass';
  }
}

class MountManager {
  Future<void> readfstab() async {
    List<FstabEntry> parseFstab(String content) {
      var entries = <FstabEntry>[];

      for (var line in content.split('\n')) {
        line = line.trim();
        if (line.isEmpty || line.startsWith('#')) continue; // 주석 또는 빈 라인 제외

        var parts = line.split(RegExp(r'\s+'));
        if (parts.length != 6) continue; // 유효하지 않은 엔트리 제외

        // # This code parses all path
        // entries.add(FstabEntry(parts[0], parts[1], parts[2], parts[3],
        //     int.parse(parts[4]), int.parse(parts[5])));

        // # parse only /mnt/~~
        var mountPoint = parts[1];
        if (!mountPoint.startsWith('/mnt/')) {
          continue; // '/mnt/{PATH}' 형식이 아닌 마운트 포인트 제외
        }

        entries.add(FstabEntry(parts[0], mountPoint, parts[2], parts[3],
            int.parse(parts[4]), int.parse(parts[5])));
      }

      return entries;
    }

    try {
      var fstabContent = File('/etc/fstab').readAsStringSync();
      var entries = parseFstab(fstabContent);

      for (var entry in entries) {
        if (kDebugMode) {
          print(entry);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error reading or parsing fstab: $e');
      }
    }
  }

  Future<void> mountExample() async {
    const remoteAddress = '//nas.xxx.com/backup';
    const mountPoint = '/mnt/nas_server';
    const username = 'kei';
    const password = 'smbnas';

    stdout.write(
        'Do you really want to mount $remoteAddress to $mountPoint with the given username and password? (yes/no): ');
    final permission = stdin.readLineSync();

    if (permission?.toLowerCase() == 'yes') {
      final mountResult = await Process.run('sudo', [
        'mount',
        '-t',
        'cifs',
        remoteAddress,
        mountPoint,
        '-o',
        'username=$username,password=$password'
      ]);

      if (mountResult.exitCode == 0) {
        if (kDebugMode) {
          print('Successfully mounted $remoteAddress to $mountPoint.');
        }

        const fstabLine =
            '$remoteAddress $mountPoint cifs username=$username,password=$password 0 0\n';

        await File('temp_fstab')
            .writeAsString(fstabLine, mode: FileMode.append);

        final cpResult =
            await Process.run('sudo', ['cp', 'temp_fstab', '/etc/fstab']);

        if (cpResult.exitCode == 0) {
          if (kDebugMode) {
            print('Successfully updated /etc/fstab.');
          }
        } else {
          if (kDebugMode) {
            print('Failed to update /etc/fstab.');
          }
          if (kDebugMode) {
            print('Error: ${cpResult.stderr}');
          }
        }
      } else {
        if (kDebugMode) {
          print('Failed to mount the device.');
          print('Error: ${mountResult.stderr}');
        }
      }
    } else {
      if (kDebugMode) {
        print('Mount operation cancelled.');
      }
    }
  }
}
