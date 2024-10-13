import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talent_hub/core/helpers/extensions.dart';
import 'package:talent_hub/core/helpers/show_toast.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import 'package:talent_hub/core/widgets/user_image_circle_avatar.dart';
import 'package:talent_hub/features/post/presentation/manger/create_post-cubit/create_post_cubit.dart';
import 'package:talent_hub/features/post/presentation/manger/create_post-cubit/create_post_states.dart';
import 'package:talent_hub/features/post/presentation/manger/post_cubit/post_cubit.dart';
import 'package:talent_hub/features/post/presentation/manger/post_cubit/post_states.dart';
import 'package:video_player/video_player.dart';
import '../../../../../core/models/user_model.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  CreatePostViewState createState() => CreatePostViewState();
}

class CreatePostViewState extends State<CreatePostView> {
  final ImagePicker picker = ImagePicker();
  XFile? videoFile;

  VideoPlayerController? videoPlayerController;
  bool isVideoPlaying = false;

  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;

  Future<void> pickVideo() async {
    final XFile? pickedVideo =
        await picker.pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      setState(
        () {
          videoFile = pickedVideo;
          videoPlayerController =
              VideoPlayerController.file(File(videoFile!.path))
                ..initialize().then(
                  (_) {
                    setState(() {});
                    videoPlayerController!.play();
                    isVideoPlaying = true;
                  },
                );
        },
      );
    }
  }

  void playPauseVideo() {
    if (videoPlayerController != null) {
      setState(() {
        if (isVideoPlaying) {
          videoPlayerController!.pause();
        } else {
          videoPlayerController!.play();
        }
        isVideoPlaying = !isVideoPlaying;
      });
    }
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userModel = ModalRoute.of(context)!.settings.arguments as UserModel;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CreatePostsCubit()),
        BlocProvider(create: (context) => PostCubit()),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: AppColors.white,
              title: const Text(
                'Create Post',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: BlocListener<CreatePostsCubit, CreatePostsState>(
                listener: (context, state) {
                  if (state is CreatePostSuccessState) {
                    context.read<PostCubit>().getPosts();
                    context.pop();
                    showToast(
                      toastMsg: "Post Created Successfully",
                      state: ToastStates.success,
                    );
                  }
                  if (state is CreatePostLoadingState) {
                    showToast(
                      toastMsg: "Your post is being prepared.",
                      state: ToastStates.loading,
                    );
                  }
                },
                child: BlocBuilder<PostCubit, PostStates>(
                  builder: (context, state) {
                    return SingleChildScrollView(
                      child: isLoading
                          ? Column(
                              children: [
                                vGap(300),
                                const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    UserImageCircleAvatar(
                                      image: userModel.imageUrl,
                                      radius: 30,
                                    ),
                                    hGap(10),
                                    Column(
                                      children: [
                                        vGap(10),
                                        Text(
                                          userModel.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                vGap(10),
                                TextField(
                                  controller: descriptionController,
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(color: Colors.grey),
                                    hintText:
                                        "Write Description About Your Video..",
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.all(10),
                                  ),
                                  maxLines: 4,
                                ),
                                vGap(20),
                                if (videoFile != null &&
                                    videoPlayerController!.value.isInitialized)
                                  GestureDetector(
                                    onTap: playPauseVideo,
                                    child: SizedBox(
                                      height: 300,
                                      child: VideoPlayer(
                                        videoPlayerController!,
                                      ),
                                    ),
                                  )
                                else
                                  const Center(
                                    child: Text('No video selected.'),
                                  ),
                                vGap(20),
                                Center(
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.white,
                                      elevation: 8.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: const BorderSide(
                                            color: Colors.blueGrey),
                                      ),
                                    ),
                                    onPressed: pickVideo,
                                    icon: const Icon(Icons.video_library,
                                        color: AppColors.primaryColor),
                                    label: const Text(
                                      'Pick Video',
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                vGap(30),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.white,
                                      elevation: 8.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: const BorderSide(
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (videoFile != null) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        if (isVideoPlaying) {
                                          videoPlayerController!.pause();
                                        }
                                        await context
                                            .read<CreatePostsCubit>()
                                            .createPost(
                                                context: context,
                                                text:
                                                    descriptionController.text,
                                                userModel: userModel,
                                                videoFile:
                                                    File(videoFile!.path));
                                        isLoading = false;
                                      } else {
                                        showToast(
                                            toastMsg: "Pick Video",
                                            state: ToastStates.error);
                                      }
                                    },
                                    label: const Text(
                                      'Post',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
