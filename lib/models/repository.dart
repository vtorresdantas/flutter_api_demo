class Repository {
  final String name;
  final bool private;
  final String? language;
  final String? description;
  final String? created;
  final String? updated;
  final String? pushed;

  Repository(this.name, this.private, this.language, this.description,
      this.created, this.updated, this.pushed);

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
        json['name'],
        json['private'],
        json['language'],
        json['description'],
        json['created_at'],
        json['updated_at'],
        json['pushed_at']);
  }
}
