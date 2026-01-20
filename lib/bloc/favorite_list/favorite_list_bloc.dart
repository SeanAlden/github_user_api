import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sean_tes_it_mobile_programmer/bloc/favorite_list/favorite_list_event.dart';
import 'package:sean_tes_it_mobile_programmer/bloc/favorite_list/favorite_list_state.dart';
import 'package:sean_tes_it_mobile_programmer/data/database/favorite_user_database.dart';

class FavoriteListBloc extends Bloc<FavoriteListEvent, FavoriteListState> {
  final FavoriteUserDatabase database;

  static const int _limit = 20;
  static const Duration _fakeDelay = Duration(seconds: 1);
  int _offset = 0;
  bool _isFetching = false;

  FavoriteListBloc(this.database) : super(FavoriteListInitial()) {
    on<LoadFavoriteUsers>(_onLoadInitial);
    on<LoadMoreFavoriteUsers>(_onLoadMore);
    on<RemoveFavoriteUser>(_onRemoveFavorite);
  }

  Future<void> _onLoadInitial(
    LoadFavoriteUsers event,
    Emitter<FavoriteListState> emit,
  ) async {
    if (state is FavoriteListLoading) return;

    emit(FavoriteListLoading());
    _offset = 0;

    await Future.delayed(_fakeDelay);

    final users = await database.getFavoritesPaged(
      limit: _limit,
      offset: _offset,
    );

    emit(FavoriteListLoaded(
      users: users,
      hasReachedMax: users.length < _limit,
    ));
  }

  Future<void> _onLoadMore(
    LoadMoreFavoriteUsers event,
    Emitter<FavoriteListState> emit,
  ) async {
    if (_isFetching) return;
    if (state is! FavoriteListLoaded) return;

    final currentState = state as FavoriteListLoaded;
    if (currentState.hasReachedMax) return;

    _isFetching = true;
    _offset += _limit;

    await Future.delayed(const Duration(seconds: 2));

    final users = await database.getFavoritesPaged(
      limit: _limit,
      offset: _offset,
    );

    emit(FavoriteListLoaded(
      users: [...currentState.users, ...users],
      hasReachedMax: users.length < _limit,
    ));

    _isFetching = false;
  }

  Future<void> _onRemoveFavorite(
    RemoveFavoriteUser event,
    Emitter<FavoriteListState> emit,
  ) async {
    if (state is! FavoriteListLoaded) return;

    final currentState = state as FavoriteListLoaded;

    await database.deleteUser(event.userId);

    final updatedUsers =
        currentState.users.where((u) => u.id != event.userId).toList();

    emit(FavoriteListLoaded(
      users: updatedUsers,
      hasReachedMax: currentState.hasReachedMax,
    ));
  }
}
