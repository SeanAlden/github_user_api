import 'package:sean_tes_it_mobile_programmer/data/models/github_user.dart';

abstract class FavoriteStatusEvent {}

class CheckFavoriteStatus extends FavoriteStatusEvent {
  final int userId;
  CheckFavoriteStatus(this.userId);
}

class ToggleFavoriteStatus extends FavoriteStatusEvent {
  final GithubUser user;
  ToggleFavoriteStatus(this.user);
}
