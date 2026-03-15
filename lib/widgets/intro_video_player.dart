import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class IntroVideoPlayer extends StatefulWidget {
  const IntroVideoPlayer({super.key});

  @override
  State<IntroVideoPlayer> createState() => _IntroVideoPlayerState();
}

class _IntroVideoPlayerState extends State<IntroVideoPlayer> {
  VideoPlayerController? _controller;
  bool _failed = false;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      final controller = VideoPlayerController.asset('assets/video/intro-tourism.mp4');
      await controller.initialize();
      controller
        ..setLooping(true)
        ..setVolume(1)
        ..play();
      if (mounted) {
        setState(() {
          _controller = controller;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _failed = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_failed) {
      return Container(
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.ondemand_video_rounded, size: 44),
            SizedBox(height: 8),
            Text('أضف الملف assets/video/intro-tourism.mp4'),
          ],
        ),
      );
    }

    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) {
      return const SizedBox(
        height: 220,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          SizedBox(
            height: 220,
            width: double.infinity,
            child: VideoPlayer(controller),
          ),
          Positioned(
            left: 10,
            bottom: 10,
            child: _ControlButton(
              icon: controller.value.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
              onTap: () {
                if (controller.value.isPlaying) {
                  controller.pause();
                } else {
                  controller.play();
                }
                setState(() {});
              },
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: _ControlButton(
              icon: _isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
              onTap: () {
                _isMuted = !_isMuted;
                controller.setVolume(_isMuted ? 0 : 1);
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
