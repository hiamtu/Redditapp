import 'package:flutter/material.dart';
import 'basic_overlay_widget.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  const VideoPlayerWidget({Key? key, required this.controller})
      : super(key: key);
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) => controller.value.isInitialized
      ? Container(
          alignment: Alignment.topCenter,
          child: buildVideo(context),
        )
      : const SizedBox(
          height: 200,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
  Widget buildVideo(BuildContext context) => Stack(children: [
        buildVideoPlayer(context),
        Positioned.fill(child: BasicOverlayWidget(controller: controller))
      ]);
  Widget buildVideoPlayer(BuildContext context) => SizedBox(
      // aspectRatio: controller.value.aspectRatio / 2,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3,
      child: VideoPlayer(controller));
}
