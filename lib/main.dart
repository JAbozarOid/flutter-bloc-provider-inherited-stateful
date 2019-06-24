import 'package:bloc_pattern/blocs/base_provider.dart';
import 'package:bloc_pattern/blocs/contribution_bloc.dart';
import 'package:bloc_pattern/blocs/information_bloc.dart';
import 'package:bloc_pattern/components/information_drawer.dart';
import 'package:bloc_pattern/components/list_page.dart';
import 'package:bloc_pattern/models/github_api.dart';
import 'package:bloc_pattern/models/rocks_api.dart';
// import 'package:bloc_pattern/providers/contribution_provider.dart';
// import 'package:bloc_pattern/providers/information_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContributionBloc>(
      builder: (_, bloc) => bloc ?? ContributionBloc(RocksApi()),
      onDispose: (_, bloc) => bloc.dispose(),
      child: RootApp(),
    );
  }
}

class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contributionBloc = Provider.of<ContributionBloc>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Utopian Rocks Mobile',
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Utopian Rocks Mobile'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.rate_review),
                  text: 'waiting for review',
                ),
                Tab(
                  icon: Icon(Icons.hourglass_empty),
                  text: 'waiting on Upvote',
                )
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ListPage('unreviewed', contributionBloc),
              ListPage('pending', contributionBloc),
            ],
          ),
          endDrawer: BlocProvider<InformationBloc>(
            builder: (_, bloc) =>
                bloc ??
                InformationBloc(PackageInfo.fromPlatform(), GithubApi()),
            onDispose: (_, bloc) => bloc.dispose(),
            child: InformationDrawer(),
          ),
        ),
      ),
    );
  }
}
