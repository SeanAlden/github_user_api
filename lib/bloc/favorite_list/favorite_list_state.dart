import 'package:sean_tes_it_mobile_programmer/data/models/github_user.dart';

abstract class FavoriteListState {}

class FavoriteListInitial extends FavoriteListState {}

class FavoriteListLoading extends FavoriteListState {}

class FavoriteListLoaded extends FavoriteListState {
  final List<GithubUser> users;
  final bool hasReachedMax;

  FavoriteListLoaded({
    required this.users, 
    required this.hasReachedMax
  });
}

class FavoriteListError extends FavoriteListState {
  final String message;
  FavoriteListError(this.message);
}
