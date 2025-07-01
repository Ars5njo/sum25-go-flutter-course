import 'package:flutter/material.dart';
import 'package:lab02_chat/user_service.dart';

class UserProfile extends StatefulWidget {
  final UserService userService;
  const UserProfile({Key? key, required this.userService}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late Future<Map<String, String>> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = widget.userService.fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final user = snapshot.data!;
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(user['name'] ?? ''),
                Text(user['email'] ?? ''),
              ],
            ),
          );
        }
        return const Center(child: Text('No user data'));
      },
    );
  }
}
