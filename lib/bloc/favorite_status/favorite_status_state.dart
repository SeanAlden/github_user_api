abstract class FavoriteStatusState {}

class FavoriteStatusInitial extends FavoriteStatusState {}

class FavoriteStatusLoading extends FavoriteStatusState {}

class FavoriteStatusLoaded extends FavoriteStatusState {
  final bool isFavorite;
  FavoriteStatusLoaded(this.isFavorite);
}
