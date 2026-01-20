import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sean_tes_it_mobile_programmer/bloc/favorite_list/favorite_list_bloc.dart';
import 'package:sean_tes_it_mobile_programmer/bloc/favorite_status/favorite_status_bloc.dart';
import 'package:sean_tes_it_mobile_programmer/bloc/user/github_user_bloc.dart';
import 'package:sean_tes_it_mobile_programmer/bloc/user/github_user_event.dart';
import 'package:sean_tes_it_mobile_programmer/data/repositories/github_user_repository.dart';
import 'package:sean_tes_it_mobile_programmer/data/database/favorite_user_database.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sean_tes_it_mobile_programmer/ui/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              GithubUserBloc(GithubApiService())..add(FetchGithubUsers()),
        ),
        BlocProvider(
          create: (_) => FavoriteListBloc(FavoriteUserDatabase()),
        ),
        BlocProvider(
          create: (_) => FavoriteStatusBloc(FavoriteUserDatabase()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
