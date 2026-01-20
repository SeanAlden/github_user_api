abstract class FavoriteListEvent {}

class LoadFavoriteUsers extends FavoriteListEvent {}

class LoadMoreFavoriteUsers extends FavoriteListEvent {}

class RemoveFavoriteUser extends FavoriteListEvent {
  final int userId;
  RemoveFavoriteUser(this.userId);
}
