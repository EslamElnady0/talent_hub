import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talent_hub/core/helpers/app_assets.dart';
import 'package:talent_hub/core/helpers/extensions.dart';
import 'package:talent_hub/core/helpers/show_toast.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import 'package:talent_hub/features/player/presentation/views/widgets/post/manger/post_cubit.dart';
import 'package:talent_hub/features/player/presentation/views/widgets/post/manger/post_states.dart';
import 'package:talent_hub/features/scout/presentation/manger/post_cubit/post_states.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../core/models/user_model.dart';
import '../../../../../scout/presentation/manger/post_cubit/post_cubit.dart';

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
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  Future<void> _pickVideo() async {
    final XFile? pickedVideo =
        await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      setState(
        () {
          _videoFile = pickedVideo;
          _videoPlayerController =
              VideoPlayerController.file(File(_videoFile!.path))
                ..initialize().then(
                  (_) {
                    setState(() {});
                    _videoPlayerController!.play();
                    _isVideoPlaying = true;
                  },
                );
        },
      );
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
    var userModel = ModalRoute.of(context)!.settings.arguments as UserModel;
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PostsCubit(),
          ),
          BlocProvider(
            create: (context) => PostCubit(),
          ),
        ],
        child: Builder(
          builder: (context) {
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
                  child: BlocListener<PostsCubit, PostsState>(
                      listener: (context, state) {
                    if (state is CreatePostSuccessState) {
                      context.read<PostCubit>().getPosts();
                      context.pop();
                      showToast(
                          toastMsg: "Post Created Successfully",
                          state: ToastStates.success);
                    }
                  }, child: BlocBuilder<PostCubit, PostStates>(
                    builder: (context, state) {
                      return SingleChildScrollView(
                        child: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ))
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage:
                                            userModel.imageUrl == null
                                                ? AssetImage(AppAssets.player)
                                                : CachedNetworkImageProvider(
                                                    userModel.imageUrl!),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        userModel.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),

                                  TextField(
                                    controller: descriptionController,
                                    decoration: const InputDecoration(
                                      hintText:
                                          "Write Description About Your Video",
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                    maxLines: 4,
                                  ),
                                  const SizedBox(height: 20),

                                  if (_videoFile != null &&
                                      _videoPlayerController!
                                          .value.isInitialized)
                                    GestureDetector(
                                      onTap: _playPauseVideo,
                                      child: SizedBox(
                                        height: 300,
                                        child: VideoPlayer(
                                            _videoPlayerController!),
                                      ),
                                    )
                                  else
                                    const Center(
                                        child: Text('No video selected.')),

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
                                      onPressed: () async {
                                        if (_videoFile != null) {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          if (_isVideoPlaying) {
                                            _videoPlayerController!.pause();
                                          }
                                          await context
                                              .read<PostsCubit>()
                                              .createPost(
                                                  context: context,
                                                  text: descriptionController
                                                      .text,
                                                  userModel: userModel,
                                                  videoFile:
                                                      File(_videoFile!.path));
                                          isLoading = false;
                                        } else {
                                          showToast(
                                              toastMsg: "Pick Video",
                                              state: ToastStates.error);
                                        }
                                      },
                                      child: const Text(
                                        'Post',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      );
                    },
                  )),
                ));
          },
        ));
  }
}
