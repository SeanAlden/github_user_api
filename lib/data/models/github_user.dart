class GithubUser {
  final String username;
  final String avatarUrl;
  final String? name;
  final int? id;
  final String? location;
  final int? followers;

  GithubUser({
    required this.username,
    required this.avatarUrl,
    this.name,
    this.id,
    this.location,
    this.followers,
  });

  factory GithubUser.fromJson(Map<String, dynamic> json) {
    return GithubUser(
      username: json['login'],
      avatarUrl: json['avatar_url'],
      name: json['name'],
      id: json['id'],
      location: json['location'],
      followers: json['followers'],
    );
  }

  factory GithubUser.fromDb(Map<String, dynamic> map) {
    return GithubUser(
      id: map['id'] as int,
      username: map['username'] as String,
      avatarUrl: map['avatarUrl'] as String,
      name: map['name'] as String?,
      location: map['location'] as String?,
      followers: map['followers'] as int?,
    );
  }
}
