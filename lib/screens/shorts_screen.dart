import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_shorts/models/video.dart';
import 'package:youtube_shorts/repositories/video_repository.dart';
import 'package:youtube_shorts/services/video_client.dart';
import 'package:youtube_shorts/widgets/app_nav_bar.dart';

class ShortScreen extends StatefulWidget {
  const ShortScreen({super.key});

  @override
  State<ShortScreen> createState() => _ShortScreenState();
}

class _ShortScreenState extends State<ShortScreen> {
  late PageController
      _pageController; //page controller to manage the different swipeable  screen
  final List<Video> _videos = [];
  final List<VideoPlayerController> _controllers = [];
  final List<ValueNotifier<double>> _progressIndicator = [];
  bool loading = true;
  @override
  void initState() {
    _pageController = PageController();
    _loadVideos();
    // for (var videoPath in [
    //   'assets/videos/video_1.mp4',
    //   'assets/videos/video_2.mp4',
    //   'assets/videos/video_3.mp4',
    //   'assets/videos/video_4.mp4',
    //   'assets/videos/video_5.mp4',
    //   'assets/videos/video_6.mp4',
    // ]) {
    //   VideoPlayerController videoPlayerController =
    //       VideoPlayerController.asset(videoPath)
    //         ..initialize().then((_) {
    //           // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //           setState(() {});
    //         });
    //   _controllers.add(
    //       videoPlayerController); //add the videos in list of videoplaycontrollers
    //   _progressIndicator.add(ValueNotifier<double>(
    //       0.0)); //initailize the valuenotifier <double> with 0.0 value
    //   videoPlayerController.addListener(() {
    //     updateProgress(videoPlayerController);
    //   });
    // }

    super.initState();
  }

  _loadVideos() async {
    setState(() {
      loading = true;
    });
    final videos =
        await VideoRepository(videoClient: VideoClient()).getVideos();
    _videos.addAll(videos);
    for (var video in videos) {
      final muxAsset = video.muxAsset;
      final url = Uri.parse(
          '${VideoClient.muxStreamBaseUrl}/${muxAsset?.playbackId}.m3u8');
      VideoPlayerController videoPlayerController =
          VideoPlayerController.networkUrl(url)
            ..initialize().then((_) {
              // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
              setState(() {});
            });
          
      _controllers.add(
          videoPlayerController); //add the videos in list of videoplaycontrollers
      _progressIndicator.add(ValueNotifier<double>(0.0));
      videoPlayerController.addListener(() {
        updateProgress(videoPlayerController);
      });
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.removeListener(() {});
      controller.dispose();
    }
    for (var progressIndicator in _progressIndicator) {
      progressIndicator.dispose();
    }
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [],
      ),
      extendBodyBehindAppBar: true,
      body: PageView.builder(
          controller: _pageController,
          itemCount: _controllers.length,
          scrollDirection: Axis.vertical,
          pageSnapping: true,
          onPageChanged: (value) {
            for (var i = 0; i < _controllers.length; i++) {
              if (i != value) {
                _controllers[i].pause();
              } else {
                _controllers[i].play();
              }
            }
            if (value == _controllers.length - 1) {
              _loadVideos();
            }
          },
          itemBuilder: ((context, index) {
            final controller = _controllers[index];
            controller
              ..play()
              ..setLooping(true);
            return controller.value.isInitialized
                ? Stack(fit: StackFit.expand, children: [
                    AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: VideoPlayer(controller)),
                    Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: ValueListenableBuilder<double>(
                            valueListenable: _progressIndicator[index],
                            builder: (context, value, child) {
                              return LinearProgressIndicator(
                                value: value,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).colorScheme.primary),
                                //color: Theme.of(context).colorScheme.secondaryContainer,
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                              );
                            })),
                  ])
                : Container(
                    color: Theme.of(context).colorScheme.secondary,
                    child: const CircularProgressIndicator());
          })),
      bottomNavigationBar: const AppNavBar(),
    );
  }

  // void _loadmoreVideos() {
  //   for (var videoPath in [
  //     'assets/videos/video_1.mp4',
  //     'assets/videos/video_2.mp4',
  //     'assets/videos/video_3.mp4',
  //     'assets/videos/video_4.mp4',
  //     'assets/videos/video_5.mp4',
  //     'assets/videos/video_6.mp4',
  //   ]) {
  //     VideoPlayerController videoPlayerController =
  //         VideoPlayerController.asset(videoPath)
  //           ..initialize().then((_) {
  //             // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
  //             setState(() {});
  //           });
  //     _controllers.add(videoPlayerController);
  //     _progressIndicator.add(ValueNotifier<double>(0.0));
  //   }
  // }

  void updateProgress(VideoPlayerController controller) {
    int controllerIndex = _controllers.indexOf(controller);
    if (controllerIndex == -1) {
      return;
    }
    final progress = controller.value.position.inMilliseconds /
        controller.value.duration.inMilliseconds;
    _progressIndicator[controllerIndex].value = progress;
  }
}
