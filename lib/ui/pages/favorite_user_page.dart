import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sean_tes_it_mobile_programmer/bloc/favorite_list/favorite_list_bloc.dart';
import 'package:sean_tes_it_mobile_programmer/bloc/favorite_list/favorite_list_event.dart';
import 'package:sean_tes_it_mobile_programmer/bloc/favorite_list/favorite_list_state.dart';
import 'package:sean_tes_it_mobile_programmer/ui/widgets/user_list_widget.dart';
import 'user_detail_page.dart';

class FavoriteUserPage extends StatefulWidget {
  const FavoriteUserPage({super.key});

  @override
  State<FavoriteUserPage> createState() => _FavoriteUserPageState();
}

class _FavoriteUserPageState extends State<FavoriteUserPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavoriteListBloc>().add(LoadFavoriteUsers());
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final bloc = context.read<FavoriteListBloc>();
    final state = bloc.state;

    if (state is! FavoriteListLoaded) return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      bloc.add(LoadMoreFavoriteUsers());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteListBloc, FavoriteListState>(
      builder: (context, state) {
        if (state is FavoriteListLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is FavoriteListLoaded) {
          if (state.users.isEmpty) {
            return const Center(child: Text('No favorite users'));
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount: state.hasReachedMax
                ? state.users.length
                : state.users.length + 1,
            itemBuilder: (context, index) {
              if (index >= state.users.length) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final user = state.users[index];
              return UserListWidget(
                user: user,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UserDetailPage(user: user),
                    ),
                  ).then((_) {
                    context.read<FavoriteListBloc>().add(LoadFavoriteUsers());
                  });
                },
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
