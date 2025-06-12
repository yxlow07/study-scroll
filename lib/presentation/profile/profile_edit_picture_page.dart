import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:study_scroll/data/datasource/backblaze_api.dart';
import 'package:study_scroll/presentation/profile/bloc/profile_cubit.dart';
import 'package:study_scroll/presentation/profile/bloc/profile_pic_cubit.dart';
import 'package:study_scroll/presentation/profile/bloc/profile_pic_state.dart';

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
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is ProfilePicUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('File uploaded successfully')),
            );
          }
        },
        child: BlocBuilder<ProfilePicCubit, ProfilePicState>(
          builder: (context, state) {
            if (state is ProfilePicLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return Center(
              child: ElevatedButton(
                onPressed:
                    () => context.read<ProfilePicCubit>().pickAndUploadFile(
                      widget.bucketId,
                      widget.uid,
                    ),
                child: Text('Pick and Upload File'),
              ),
            );
          },
        ),
      ),
    );
  }
}
