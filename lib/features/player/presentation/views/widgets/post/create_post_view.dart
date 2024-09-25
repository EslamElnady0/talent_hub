import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../core/helpers/app_assets.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  CreatePostViewState createState() => CreatePostViewState();
}

class CreatePostViewState extends State<CreatePostView> {
  final ImagePicker _picker = ImagePicker();
  XFile? _videoFile;
  VideoPlayerController? _videoPlayerController;
  bool _isVideoPlaying = false;

  // Function to pick video from the gallery
  Future<void> _pickVideo() async {
    final XFile? pickedVideo =
        await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      setState(() {
        _videoFile = pickedVideo;
        _videoPlayerController =
            VideoPlayerController.file(File(_videoFile!.path))
              ..initialize().then((_) {
                setState(() {});
                _videoPlayerController!.play();
                _isVideoPlaying = true;
              });
      });
    }
  }

  // Play or pause video function
  void _playPauseVideo() {
    if (_videoPlayerController != null) {
      setState(() {
        if (_isVideoPlaying) {
          _videoPlayerController!.pause();
        } else {
          _videoPlayerController!.play();
        }
        _isVideoPlaying = !_isVideoPlaying;
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Create Post',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(AppAssets.player),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Abdelrahman',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              const TextField(
                decoration: InputDecoration(
                  hintText: "Write Description About Your Video",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 20),

              if (_videoFile != null &&
                  _videoPlayerController!.value.isInitialized)
                GestureDetector(
                  onTap: _playPauseVideo,
                  child: SizedBox(
                    height: 300,
                    child: VideoPlayer(_videoPlayerController!),
                  ),
                )
              else
                const Text('No video selected.'),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: _pickVideo,
                icon: const Icon(Icons.video_library),
                label: const Text('Pick Video'),
              ),

              const SizedBox(height: 20),

              // Post button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Post',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
