import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:study_scroll/presentation/profile/bloc/profile_pic_cubit.dart';
import 'package:study_scroll/presentation/profile/bloc/profile_pic_state.dart';
import 'package:study_scroll/presentation/widgets/alert.dart';
import 'package:study_scroll/presentation/widgets/form_button.dart';

class ProfileEditPicturePage extends StatefulWidget {
  final String bucketId = dotenv.env['BUCKET_ID'] ?? '';
  final String uid;

  ProfileEditPicturePage({super.key, required this.uid});

  @override
  State<ProfileEditPicturePage> createState() => _ProfileEditPicturePageState();
}

class _ProfileEditPicturePageState extends State<ProfileEditPicturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload File')),
      body: BlocListener<ProfilePicCubit, ProfilePicState>(
        listener: (context, state) async {
          if (state is ProfilePicError) {
            Alert.alert(context, state.message);
          }
          if (state is ProfilePicUpdateSuccess) {
            Alert.alert(context, "Profile picture updated successfully! Wait a few minutes for it to reflect.");
            context.pop();
          }
        },
        child: BlocBuilder<ProfilePicCubit, ProfilePicState>(
          builder: (context, state) {
            Widget imagePreviewWidget;
            bool canUpload = false;

            if (state is ProfilePicFilePicked) {
              imagePreviewWidget = CircleAvatar(radius: 80, backgroundImage: FileImage(state.file));
              canUpload = true;
            } else {
              imagePreviewWidget = CircleAvatar(radius: 80, child: Icon(Icons.person, size: 80));
            }

            if (state is ProfilePicLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(onTap: () => context.read<ProfilePicCubit>().pickFile(), child: imagePreviewWidget),
                  SizedBox(height: 20),
                  Text(state is ProfilePicFilePicked ? "Tap image to change" : "Tap icon to select an image"),
                  SizedBox(height: 30),
                  if (canUpload) // Only show upload button if an image is picked
                    FormButton(
                      text: "Confirm and Upload",
                      onPressed: () {
                        context.read<ProfilePicCubit>().uploadFile(widget.bucketId, widget.uid);
                      },
                    ),
                  if (state is ProfilePicLoading) // Show loading specifically for upload
                    Padding(padding: const EdgeInsets.only(top: 20.0), child: CircularProgressIndicator()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
