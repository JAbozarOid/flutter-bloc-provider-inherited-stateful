import 'package:bloc_pattern/blocs/contribution_bloc.dart';
import 'package:bloc_pattern/models/model.dart';
import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  final ContributionBloc bloc;
  final String pageName;

  ListPage(this.pageName, this.bloc);

  @override
  Widget build(BuildContext context) {
    bloc.pageName.add(pageName);

    return StreamBuilder(
      stream: bloc.results,
      builder: (context, AsyncSnapshot<List<Contribution>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) => ListTile(
                title: Text('${snapshot.data[index].title}'), 
              ),
        );
      },
    );
  }
}