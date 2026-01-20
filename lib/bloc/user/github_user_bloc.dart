import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/github_user_repository.dart';
import 'github_user_event.dart';
import 'github_user_state.dart';

class GithubUserBloc extends Bloc<GithubUserEvent, GithubUserState> {
  final GithubApiService apiService;
  int _since = 0;
  bool _isFetching = false;

  GithubUserBloc(this.apiService) : super(GithubUserInitial()) {
    on<FetchGithubUsers>(_onFetchUsers);
    on<FetchMoreGithubUsers>(_onFetchMoreUsers);
  }

  Future<void> _onFetchUsers(
    FetchGithubUsers event,
    Emitter<GithubUserState> emit,
  ) async {
    emit(GithubUserLoading());

    try {
      _since = 0;

      await Future.delayed(const Duration(seconds: 1));

      final users = await apiService.fetchUsers(_since);

      final detailedUsers = await Future.wait(
        users.map((u) => apiService.fetchUserDetail(u.username)),
      );

      _since = users.last.id ?? _since;

      emit(GithubUserLoaded(
        users: detailedUsers,
        hasReachedMax: users.isEmpty,
        isLoadingMore: false,
      ));
    } catch (e) {
      emit(GithubUserError(e.toString()));
    }
  }

  Future<void> _onFetchMoreUsers(
    FetchMoreGithubUsers event,
    Emitter<GithubUserState> emit,
  ) async {
    if (_isFetching) return;
    if (state is! GithubUserLoaded) return;

    final currentState = state as GithubUserLoaded;
    if (currentState.hasReachedMax) return;

    _isFetching = true;

    emit(currentState.copyWith(isLoadingMore: true));

    await Future.delayed(const Duration(seconds: 1));

    final users = await apiService.fetchUsers(_since);

    final detailedUsers = await Future.wait(
      users.map((u) => apiService.fetchUserDetail(u.username)),
    );

    _since = users.last.id ?? _since;

    emit(GithubUserLoaded(
      users: [...currentState.users, ...detailedUsers],
      hasReachedMax: users.isEmpty,
      isLoadingMore: false,
    ));

    _isFetching = false;
  }
}
