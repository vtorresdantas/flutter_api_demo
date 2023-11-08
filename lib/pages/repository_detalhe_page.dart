import 'package:flutter/material.dart';
import 'package:github_api_demo/models/repository.dart';

class RepositoryDetalhePage extends StatelessWidget {
  const RepositoryDetalhePage({Key? key, required this.repository})
      : super(key: key);
  final Repository repository;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(repository.name),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          ListTile(
            title: const Text('Descrição: '),
            subtitle: repository.description == null
                ? const Text('Sem descrição.')
                : Text(repository.description!),
          ),
          ListTile(
            title: const Text('Linguagem utilizada: '),
            subtitle: repository.language == null
                ? const Text('Sem linguagem.')
                : Text(repository.language!),
          ),
        ])));
  }
}
