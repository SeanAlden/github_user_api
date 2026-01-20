import '../../data/models/github_user.dart';

abstract class GithubUserState {}

class GithubUserInitial extends GithubUserState {}

class GithubUserLoading extends GithubUserState {}

class GithubUserLoaded extends GithubUserState {
  final List<GithubUser> users;
  final bool hasReachedMax;
  final bool isLoadingMore;

  GithubUserLoaded({
    required this.users,
    required this.hasReachedMax,
    required this.isLoadingMore,
  });

  GithubUserLoaded copyWith({
    List<GithubUser>? users,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return GithubUserLoaded(
      users: users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class GithubUserError extends GithubUserState {
  final String message;
  GithubUserError(this.message);
}
