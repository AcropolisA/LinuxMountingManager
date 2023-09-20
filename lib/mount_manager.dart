import 'dart:io';

class MountMaanage {
  Future<void> mountExample() async {
    final remoteAddress = '//nas.xxx.com/backup';
    final mountPoint = '/mnt/nas_server';
    final username = 'kei';
    final password = 'smbnas';

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
        print('Successfully mounted $remoteAddress to $mountPoint.');

        final fstabLine =
            '$remoteAddress $mountPoint cifs username=$username,password=$password 0 0\n';

        await File('temp_fstab')
            .writeAsString(fstabLine, mode: FileMode.append);

        final cpResult =
            await Process.run('sudo', ['cp', 'temp_fstab', '/etc/fstab']);

        if (cpResult.exitCode == 0) {
          print('Successfully updated /etc/fstab.');
        } else {
          print('Failed to update /etc/fstab.');
          print('Error: ${cpResult.stderr}');
        }
      } else {
        print('Failed to mount the device.');
        print('Error: ${mountResult.stderr}');
      }
    } else {
      print('Mount operation cancelled.');
    }
  }
}
