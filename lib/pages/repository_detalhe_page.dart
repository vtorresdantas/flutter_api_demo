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
          ListTile(
            title: const Text('Data de criação: '),
            subtitle: repository.created == null
                ? const Text('Sem data de criação.')
                : Text(repository.created!),
          ),
          ListTile(
            title: const Text('Data de atualização: '),
            subtitle: repository.updated == null
                ? const Text('Sem data de atualização.')
                : Text(repository.updated!),
          ),
          ListTile(
            title: const Text('Data de envio: '),
            subtitle: repository.pushed == null
                ? const Text('Sem data de envio.')
                : Text(repository.pushed!),
          ),
        ])));
  }
}
