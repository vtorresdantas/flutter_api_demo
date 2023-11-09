class User {
  final String login;
  final String avatarUrl;
  final String name;
  final String location;
  final String email;

  User({
    required this.login,
    required this.avatarUrl,
    required this.name,
    required this.location,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['login'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
