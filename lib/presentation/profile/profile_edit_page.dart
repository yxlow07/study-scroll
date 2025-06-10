import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:study_scroll/core/theme/AppStyles.dart';
import 'package:study_scroll/data/datasource/a_level_subjects.dart';
import 'package:study_scroll/domain/entities/profile.dart';
import 'package:study_scroll/presentation/profile/bloc/profile_cubit.dart';
import 'package:study_scroll/presentation/profile/bloc/profile_state.dart';

class ProfileEditPage extends StatefulWidget {
  final String uid;
  const ProfileEditPage({super.key, required this.uid});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  late final profileCubit = context.read<ProfileCubit>();
  late TextEditingController _nameController;
  late TextEditingController _bioController;

  List<String> availableSubjects = cambridge_official_subject_list;
  List<String> selectedSubjects = [];

  @override
  void initState() {
    super.initState();
    profileCubit.loadProfile(widget.uid);
  }

  void _showSubjectSelectionDialog(BuildContext context) {
    final items =
        availableSubjects
            .where((s) => !selectedSubjects.contains(s))
            .map((s) => SelectedListItem<String>(data: s))
            .toList();

    DropDownState<String>(
      dropDown: DropDown<String>(
        data: items,
        enableMultipleSelection: false,
        bottomSheetTitle: const Text('Choose a subject'),
        onSelected: (List<dynamic> selectedList) {
          if (selectedList.isNotEmpty && selectedList.first is SelectedListItem<String>) {
            final selected = (selectedList.first as SelectedListItem<String>).data;
            setState(() {
              selectedSubjects.add(selected);
            });
          }
        },
      ),
    ).showModal(context);
  }

  void _removeSubject(String subject) {
    setState(() {
      selectedSubjects.remove(subject);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: ${state.message}'), duration: const Duration(seconds: 2)));
        }
        if (state is ProfileUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully!'), duration: Duration(seconds: 2)),
          );
          profileCubit.loadProfile(widget.uid);
        }
      },
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          Profile profile;
          if (state is ProfileLoaded) {
            profile = state.profile;
          } else if (state is ProfileUpdateSuccess) {
            profile = state.profile;
          } else {
            profile = Profile('', '', [], uid: '', name: '', email: '');
          }

          if (state is ProfileLoaded || state is ProfileUpdateSuccess) {
            if (selectedSubjects.isEmpty && profile.subjects.isNotEmpty) {
              selectedSubjects = List<String>.from(profile.subjects);
            }

            _nameController = TextEditingController(text: profile.name);
            _bioController = TextEditingController(text: profile.bio);

            List<Widget> subjectChips =
                selectedSubjects.map((subject) {
                  return Chip(
                    label: Text(subject),
                    deleteIcon: const Icon(Icons.close),
                    onDeleted: () => _removeSubject(subject),
                  );
                }).toList();

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            profile.profilePictureUrl.isNotEmpty ? NetworkImage(profile.profilePictureUrl) : null,
                        child: profile.profilePictureUrl.isEmpty ? const Icon(Icons.person, size: 60) : null,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: const Icon(Icons.person_outline),
                      ),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text('Email:', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                    SizedBox(height: 5),
                    Text(profile.email, style: const TextStyle(fontSize: 16, color: Colors.black87)),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _bioController,
                      decoration: InputDecoration(
                        labelText: 'Bio',
                        hintText: 'Tell us a little about yourself...',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: const Icon(Icons.info_outline),
                      ),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Subjects:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[800]),
                    ),
                    const SizedBox(height: 10),
                    // Subject Pills
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ...subjectChips,
                        OutlinedButton.icon(
                          onPressed: () => _showSubjectSelectionDialog(context),
                          icon: const Icon(Icons.add),
                          label: const Text('Add Subject'),
                          style: AppStyles.outlinedButtonStyle,
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: AppStyles.outlinedButtonStyle,
                            onPressed: () async {
                              await profileCubit.updateProfile(
                                widget.uid,
                                _nameController.text,
                                profile.email,
                                _bioController.text,
                                profile.profilePictureUrl,
                                selectedSubjects,
                              );
                            },
                            child: const Text("Update Profile"),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => context.pop(),
                            style: AppStyles.outlinedButtonStyle,
                            child: const Text("Go Back"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
