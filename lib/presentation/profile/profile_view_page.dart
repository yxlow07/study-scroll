import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_scroll/presentation/profile/bloc/profile_cubit.dart';
import 'package:study_scroll/presentation/profile/bloc/profile_state.dart';

class ProfileViewPage extends StatefulWidget {
  final String uid;

  const ProfileViewPage({super.key, required this.uid});

  @override
  State<ProfileViewPage> createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  late final profileCubit = context.read<ProfileCubit>();

  @override
  void initState() {
    super.initState();
    profileCubit.loadProfile(widget.uid);
  }

  Widget _buildStatColumn(String count, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(count, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileLoaded) {
          final profile = state.profile;
          List<Widget> subjectChips =
              profile.subjects.map((subject) {
                String shortLabel = subject.length >= 4 ? subject.substring(subject.length - 4) : subject;
                return Chip(label: Text(shortLabel));
              }).toList();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top section: Profile Picture and Stats
                  Row(
                    children: [
                      // Circular avatar for the profile picture.
                      CircleAvatar(
                        radius: 45, // Smaller radius to fit stats beside it
                        backgroundImage:
                            profile.profilePictureUrl.isNotEmpty ? NetworkImage(profile.profilePictureUrl) : null,
                        backgroundColor: profile.profilePictureUrl.isEmpty ? Colors.grey[400] : null,
                        child: profile.profilePictureUrl.isEmpty ? const Icon(Icons.person, size: 45) : null,
                      ),
                      const SizedBox(width: 20),
                      // Posts, Followers, Following Stats
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatColumn('0', 'Posts'),
                            _buildStatColumn('0', 'Followers'),
                            _buildStatColumn('0', 'Following'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Name and Bio
                  Text(
                    profile.name.isNotEmpty ? profile.name : '-',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(profile.bio.isNotEmpty ? profile.bio : '', style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children:
                        subjectChips.isEmpty
                            ? [Text('No subjects selected.', style: TextStyle(color: Colors.grey[600]))]
                            : subjectChips,
                  ),
                  const SizedBox(height: 10),
                  // Follow and Message Buttons (For other users)
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Expanded(
                  //       child: OutlinedButton(
                  //         onPressed: () {
                  //           // TODO: Implement follow logic
                  //         },
                  //         style: OutlinedButton.styleFrom(
                  //           side: BorderSide(color: Colors.grey[700]!),
                  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  //           padding: const EdgeInsets.symmetric(vertical: 8),
                  //         ),
                  //         child: const Text('Following', style: TextStyle(color: Colors.black)),
                  //       ),
                  //     ),
                  //     const SizedBox(width: 8),
                  //     Expanded(
                  //       child: OutlinedButton(
                  //         onPressed: () {
                  //           // TODO: Implement message logic
                  //         },
                  //         style: OutlinedButton.styleFrom(
                  //           side: BorderSide(color: Colors.grey[700]!),
                  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  //           padding: const EdgeInsets.symmetric(vertical: 8),
                  //         ),
                  //         child: const Text('Message', style: TextStyle(color: Colors.black)),
                  //       ),
                  //     ),
                  //     const SizedBox(width: 8),
                  //     // Dummy add person button
                  //     SizedBox(
                  //       width: 40,
                  //       height: 40,
                  //       child: OutlinedButton(
                  //         onPressed: () {
                  //           // TODO: Implement add person logic
                  //         },
                  //         style: OutlinedButton.styleFrom(
                  //           side: BorderSide(color: Colors.grey[700]!),
                  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  //           padding: EdgeInsets.zero,
                  //         ),
                  //         child: const Icon(Icons.person_add_alt_1, size: 20, color: Colors.black),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const Divider(height: 30), // Separator
                  const SizedBox(height: 4),
                  // Grid view for dummy posts (you'll replace this with actual posts)
                  // GridView.builder(
                  //   shrinkWrap: true, // Important for nested scroll views
                  //   physics: const NeverScrollableScrollPhysics(), // Disable grid scrolling
                  //   itemCount: 14, // Dummy post count
                  //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 3,
                  //     crossAxisSpacing: 2,
                  //     mainAxisSpacing: 2,
                  //   ),
                  //   itemBuilder: (context, index) {
                  //     return Container(
                  //       color: Colors.grey[300], // Placeholder color for post image
                  //       child: Center(child: Text('Post ${index + 1}', style: const TextStyle(color: Colors.black54))),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
          );
        } else if (state is ProfileError) {
          return Center(child: Text('Error loading profile: ${state.message}'));
        } else {
          return const Center(child: Text('Unexpected error occurred'));
        }
      },
    );
  }
}
