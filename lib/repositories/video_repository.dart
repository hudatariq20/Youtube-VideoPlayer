import 'dart:async';
import 'dart:math';

import 'package:youtube_shorts/models/mux_asset.dart';
import 'package:youtube_shorts/models/video.dart';
import 'package:youtube_shorts/services/video_client.dart';

class VideoRepository {
  final VideoClient _client;
  //Repository is made to take client service and
  VideoRepository({required VideoClient videoClient}) : _client = videoClient;

  Future<List<Video>> getVideos() async {
  try {
    // Simulate initial delay and parse sample videos
    final videos = await Future.delayed(
      const Duration(seconds: 1),
      () => Video.sampleVideos
          .map((videoJson) => Video.fromJson(videoJson))
          .toList(),
    );

    final updatedVideos = <Video>[];

    for (var video in videos) {
      try {
        final muxAssetJson = await _client.getMuxAsset(video.muxId);

        if (muxAssetJson == null || muxAssetJson['data'] == null) {
          throw Exception('No data returned for Mux ID: ${video.muxId}');
        }

        final muxAsset = MuxAsset.fromJson(muxAssetJson['data']);
        updatedVideos.add(video.copyWith(muxAsset: muxAsset));
      } catch (e, st) {
        print('[Mux Fetch Error] Video ID: ${video.muxId} → $e\n$st');
        // Optionally skip this video and continue
      }
    }

    return updatedVideos;
  } on TimeoutException catch (e) {
    print('[Timeout] $e');
    throw Exception('Timeout while loading videos');
  } on FormatException catch (e) {
    print('[Format Error] $e');
    throw Exception('Invalid video format received');
  } catch (err, st) {
    print('[Unhandled Error] $err\n$st');
    throw Exception('Unexpected error: $err');
  }
}


  // Future<List<Video>> getVideos() async {
  //   try {
  //     //videos will display after a delay of 1 second
  //     final videos = await Future.delayed(
  //         const Duration(seconds: 1),
  //         () => Video.sampleVideos
  //             .map((videoJson) => Video.fromJson(videoJson))
  //             .toList());
  //     final updatedVideos = <Video>[];
  //     for (var video in videos) {
  //       final muxAssetJson = await _client.getMuxAsset(video.muxId);
  //       final muxAsset = MuxAsset.fromJson(muxAssetJson['data']);
  //       updatedVideos.add(video.copyWith(muxAsset: muxAsset));
  //     }
  //     return updatedVideos;
  //   } catch (err) {
  //     throw Exception(' ${err} Failed to load videos');
  //   }
  // }
}
