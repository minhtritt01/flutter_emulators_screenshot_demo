import 'dart:io';

import 'package:emulators/emulators.dart';

Future<void> main() async {
  // Create the config instance
  final emu = await Emulators.build();

  // Shutdown all the running emulators
  await emu.shutdownAll();

  // Make sure the Nexus_5X android emulator exists.
  // We use the avdmanager CLI tool for this.
  // You might need to install some packages in Android Studio for this to work.
  // await emu.toolchain.avdmanager([
  //   'create',
  //   'avd',
  //   '-n',
  //   'Nexus_5X',
  //   '-k',
  //   'system-images;android-34;google_apis_playstore;x86_64',
  //   '-d',
  //   'Nexus 5X',
  //   '-f',
  // ]).string();

  final configs = [
    {'locale': 'en'},
    {'locale': 'fr'},
  ];

  // For each emulator in the list, we run `flutter drive`.
  await emu.forEach([
    'Pixel_7_Pro_API_34',
    'ip8plus',
    'ip11promax',
  ])((device) async {
    for (final c in configs) {
      final p = await emu.drive(
        device,
        'test_driver/main.dart',
        config: c,
      );
      stderr.addStream(p.stderr);
      await stdout.addStream(p.stdout);
    }
  });
}
