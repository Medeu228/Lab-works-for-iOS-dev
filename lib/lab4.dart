import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const ProfileCardScreen(),
    );
  }
}

class ProfileCardScreen extends StatefulWidget {
  const ProfileCardScreen({super.key});

  @override
  State<ProfileCardScreen> createState() => _ProfileCardScreenState();
}

class _ProfileCardScreenState extends State<ProfileCardScreen> {
  // ----- default values, used by the Reset button -----
  static const bool _defaultIsFollowing = false;
  static const bool _defaultIsLiked = false;
  static const int _defaultLikeCount = 0;
  static const int _defaultFollowersCount = 0;

  // ----- state: plain booleans, each press just flips true <-> false -----
  bool isFollowing = _defaultIsFollowing;
  bool isLiked = _defaultIsLiked;
  int likeCount = _defaultLikeCount;
  int followersCount = _defaultFollowersCount;

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked; // boolean flip — can't "like" twice in a row
      likeCount += isLiked ? 1 : -1; // +1 when liking, -1 when un-liking
    });
  }

  void _toggleFollow() {
    setState(() {
      isFollowing =
          !isFollowing; // boolean flip — can't "follow" twice in a row
      followersCount += isFollowing ? 1 : -1;
    });
  }

  void _reset() {
    setState(() {
      isFollowing = _defaultIsFollowing;
      isLiked = _defaultIsLiked;
      likeCount = _defaultLikeCount;
      followersCount = _defaultFollowersCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile Card'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ----- avatar -----
            ClipOval(
              child: Image.asset(
                'assets/avatar.png',
                width: 140,
                height: 140,
                fit: BoxFit.cover,
                // shown until you add your own assets/avatar.png
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 140,
                  height: 140,
                  color: Colors.grey[300],
                  child: Icon(Icons.person, size: 70, color: Colors.grey[600]),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // ----- like (left) and follow (right), below the avatar -----
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LEFT: heart / like
                Column(
                  children: [
                    IconButton(
                      iconSize: 40,
                      onPressed: _toggleLike,
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.grey[500],
                      ),
                    ),
                    Text(
                      '$likeCount likes',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 60),

                // RIGHT: blue follow rectangle
                Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: _toggleFollow,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isFollowing
                              ? Colors.blue[100]
                              : Colors.blue,
                          foregroundColor: isFollowing
                              ? Colors.blue[800]
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          elevation: 0,
                        ),
                        child: Text(isFollowing ? 'Following' : 'Follow'),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$followersCount followers',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 32),
            TextButton(onPressed: _reset, child: const Text('Reset')),
          ],
        ),
      ),
    );
  }
}
