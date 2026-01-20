import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sean_tes_it_mobile_programmer/bloc/user/github_user_bloc.dart';
import 'package:sean_tes_it_mobile_programmer/bloc/user/github_user_event.dart';
import 'package:sean_tes_it_mobile_programmer/bloc/user/github_user_state.dart';
import 'package:sean_tes_it_mobile_programmer/ui/pages/user_detail_page.dart';
import 'package:sean_tes_it_mobile_programmer/ui/widgets/user_list_widget.dart';

class HomeUserTab extends StatefulWidget {
  const HomeUserTab({super.key});

  @override
  State<HomeUserTab> createState() => _HomeUserTabState();
}

class _HomeUserTabState extends State<HomeUserTab> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<GithubUserBloc>().add(FetchMoreGithubUsers());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GithubUserBloc, GithubUserState>(
      builder: (context, state) {
        if (state is GithubUserLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GithubUserLoaded) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.users.length + (state.isLoadingMore ? 1 : 0),
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
                  );
                },
              );
            },
          );
        }

        if (state is GithubUserError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox();
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
