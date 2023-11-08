class Repository {
  final String name;
  final bool private;
  final String? language;
  final String? description;

  Repository(this.name, this.private, this.language, this.description );

  factory Repository.fromJson(Map json) {
    return Repository(
      json['name'],
      json['private'],
      json['language'],
      json['description']
    );
  }
}
