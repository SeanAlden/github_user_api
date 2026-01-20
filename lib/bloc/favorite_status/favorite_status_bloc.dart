import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sean_tes_it_mobile_programmer/data/database/favorite_user_database.dart';
import 'favorite_status_event.dart';
import 'favorite_status_state.dart';

class FavoriteStatusBloc
    extends Bloc<FavoriteStatusEvent, FavoriteStatusState> {
  final FavoriteUserDatabase database;

  FavoriteStatusBloc(this.database) : super(FavoriteStatusInitial()) {
    on<CheckFavoriteStatus>(_onCheckStatus);
    on<ToggleFavoriteStatus>(_onToggleStatus);
  }

  Future<void> _onCheckStatus(
    CheckFavoriteStatus event,
    Emitter<FavoriteStatusState> emit,
  ) async {
    emit(FavoriteStatusLoading());
    final isFav = await database.isFavorite(event.userId);
    emit(FavoriteStatusLoaded(isFav));
  }

  Future<void> _onToggleStatus(
    ToggleFavoriteStatus event,
    Emitter<FavoriteStatusState> emit,
  ) async {
    final isFav = await database.isFavorite(event.user.id!);

    if (isFav) {
      await database.deleteUser(event.user.id!);
    } else {
      await database.insertUser(event.user);
    }

    emit(FavoriteStatusLoaded(!isFav));
  }
}
