import 'package:flutter/material.dart';

import '../api/github_api.dart';
import '../models/user.dart';
import 'user_page.dart';

class FollowersPage extends StatefulWidget {
  final User user;
  const FollowersPage(this.user);

  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  late Future<List<User>> _futureFollowers;
  late List<User> _followers = [];

  @override
  void initState() {
    _futureFollowers = GithubApi().listFollowers(widget.user.login);
    _carregarSeguidores();
    super.initState();
  }

  Future<void> _carregarSeguidores() async {
    final followers = await _futureFollowers;
    setState(() {
      _followers = followers;
    });
  }

  void _ordemAlfabetica() {
    setState(() {
      _futureFollowers =
          GithubApi().listFollowers(widget.user.login, order: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
              // Lista de usuários seguindo
              child: FutureBuilder<List<User>>(
            future: _futureFollowers,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Erro'),
                );
              }

              var followers = snapshot.data ?? [];
              return ListView.separated(
                itemCount: followers.length,
                itemBuilder: ((context, i) {
                  var follower = followers[i];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(follower.avatarUrl),
                    ),
                    title: Text(follower.login),
                    trailing: const Text(
                      'Follower',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UserPage(follower),
                        ),
                      );
                    },
                  );
                }),
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              );
            },
          )),
        ]),
      ),
    );
  }
}
