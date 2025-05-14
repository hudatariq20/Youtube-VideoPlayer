import 'package:flutter/material.dart';
import 'package:youtube_shorts/screens/search_screen.dart';
import 'package:youtube_shorts/screens/shorts_screen.dart';
import 'package:youtube_shorts/services/video_client.dart';
import 'package:youtube_shorts/shared/theme.dart';

void main() async {
  // final videoClient = VideoClient();
  // final muxAssets = await videoClient.getMuxAssets();
  // print(muxAssets);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: const AppTheme().themeData,
      initialRoute: '/shorts',
      debugShowCheckedModeBanner: false,
      routes: {
        '/shorts': (context) => const ShortScreen(),
        '/search': (context) => const SearchScreen()
      },
    );
  }
}
