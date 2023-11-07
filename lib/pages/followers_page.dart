import 'package:flutter/material.dart';
import '../models/user.dart';
import '../api/github_api.dart';

class FollowersPage extends StatefulWidget {
  final User user;
  const FollowersPage({required this.user});

  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  final api = GitHubApi();
  late Future<List<User>> _futureFollowings; // Renomeado para _futureFollowings

  @override
  void initState() {
    _futureFollowings =
        api.getFollowing(widget.user.login); // Alterado para getFollowing
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Followers"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(widget.user.avatarUrl),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.user.login,
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<List<User>>(
                future: _futureFollowings,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text('Erro ao carregar os seguidores.'));
                  } else {
                    var followings = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: followings.length,
                      itemBuilder: ((context, index) {
                        var user = followings[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user.avatarUrl),
                          ),
                          title: Text(user.login),
                          trailing: const Text(
                            "Following",
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        );
                      }),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
