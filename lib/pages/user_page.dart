import 'package:flutter/material.dart';
import 'package:github_api_demo/api/github_api.dart';
import 'package:github_api_demo/models/user.dart';
import 'package:github_api_demo/pages/followers_page.dart';
import 'package:github_api_demo/pages/following_page.dart';
import 'package:github_api_demo/pages/repositories_page.dart';

class UserPage extends StatefulWidget {
  final User user;
  const UserPage(this.user);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _api = GithubApi();

  Future<int?> fetchFollowingCount() async {
    final following = await _api.listFollowing(widget.user.login);
    return following.length;
  }

  Future<int?> fetchFollowersCount() async {
    final followers = await _api.listFollowers(widget.user.login);
    return followers.length;
  }

  Future<int?> fetchRepositoriesCount() async {
    final repositories = await _api.listRepositories(widget.user.login);
    return repositories.length;
  }

  @override
  void initState() {
    fetchFollowingCount().then((count) {
      setState(() {
        count;
      });
    });
    fetchFollowersCount().then((count) {
      setState(() {
        count;
      });
    });
    fetchFollowersCount().then((count) {
      setState(() {
        count;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Seu perfil'),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.blue,
                      backgroundImage: NetworkImage(widget.user.avatarUrl),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.user.login,
                    style: const TextStyle(fontSize: 22),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TabBar(
              indicatorColor: Colors.black,
              tabs: [
                Tab(
                  icon: const Icon(
                    Icons.people,
                    color: Colors.black,
                  ),
                  child: FutureBuilder<int?>(
                    future: fetchFollowingCount(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text(
                          'Following',
                          style: TextStyle(color: Colors.black),
                        );
                      }
                      if (snapshot.hasData) {
                        return Text(
                          'Following (${snapshot.data})',
                          style: const TextStyle(color: Colors.black),
                        );
                      }
                      return const Text(
                        'Following',
                        style: TextStyle(color: Colors.black),
                      );
                    },
                  ),
                ),
                Tab(
                  icon: const Icon(
                    Icons.people_alt_outlined,
                    color: Colors.black,
                  ),
                  child: FutureBuilder<int?>(
                    future: fetchFollowersCount(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text(
                          'Followers',
                          style: TextStyle(color: Colors.black),
                        );
                      }
                      if (snapshot.hasData) {
                        return Text(
                          'Followers (${snapshot.data})',
                          style: const TextStyle(color: Colors.black),
                        );
                      }
                      return const Text(
                        'Followers',
                        style: TextStyle(color: Colors.black),
                      );
                    },
                  ),
                ),
                Tab(
                  icon: const Icon(
                    Icons.book,
                    color: Colors.black,
                  ),
                  child: FutureBuilder<int?>(
                    future: fetchRepositoriesCount(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text(
                          'Repositories',
                          style: TextStyle(color: Colors.black),
                        );
                      }
                      if (snapshot.hasData) {
                        return Text(
                          'Repositories (${snapshot.data})',
                          style: const TextStyle(color: Colors.black),
                        );
                      }
                      return const Text(
                        'Repositories',
                        style: TextStyle(color: Colors.black),
                      );
                    },
                  ),
                ),
                //Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  FollowingPage(widget.user),
                  FollowersPage(widget.user),
                  RepositoryPage(widget.user),
                  //Icon(Icons.directions_bike),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
