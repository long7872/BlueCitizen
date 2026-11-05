import 'package:blue_citizen/app/app.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';


// Future<void> checkFontLoaded() async {
//   try {
//     final fontData = await rootBundle.load(
//       'assets/fonts/AfacadFlux/AfacadFlux-VariableFont_slnt,wght.ttf',
//     );
//     print('Font loaded successfully! Size: ${fontData.lengthInBytes} bytes');
//   } catch (e) {
//     print('Font load error: $e');
//   }
// }

// Future<void> printAllAssets() async {
//   final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
//   final assets = manifest.listAssets();

//   print('--- LOADED ASSETS ---');
//   for (final asset in assets) {
//     print(asset);
//   }
// }

void main() {
  runApp(const ProviderScope(child: BlueCitizenApp()));
  // checkFontLoaded();
  // printAllAssets();
}
