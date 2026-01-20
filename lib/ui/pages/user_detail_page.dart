import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sean_tes_it_mobile_programmer/bloc/favorite_status/favorite_status_bloc.dart';
import 'package:sean_tes_it_mobile_programmer/bloc/favorite_status/favorite_status_event.dart';
import 'package:sean_tes_it_mobile_programmer/bloc/favorite_status/favorite_status_state.dart';
import 'package:sean_tes_it_mobile_programmer/data/models/github_user.dart';

class UserDetailPage extends StatefulWidget {
  final GithubUser user;

  const UserDetailPage({required this.user});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<FavoriteStatusBloc>()
        .add(CheckFavoriteStatus(widget.user.id!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'User Detail',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: BlocBuilder<FavoriteStatusBloc, FavoriteStatusState>(
                builder: (context, state) {
                  if (state is FavoriteStatusLoaded) {
                    return IconButton(
                      icon: Icon(
                        state.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        context
                            .read<FavoriteStatusBloc>()
                            .add(ToggleFavoriteStatus(widget.user));
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.user.avatarUrl),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.user.username,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _infoItem('Name', widget.user.name ?? '-'),
            _infoItem('Location', widget.user.location ?? '-'),
            _infoItem('Followers', '${widget.user.followers ?? 0}'),
          ],
        ),
      ),
    );
  }

  Widget _infoItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
