import 'package:bloc_pattern/blocs/contribution_bloc.dart';
import 'package:bloc_pattern/models/rocks_api.dart';
import 'package:flutter/widgets.dart';

class ContributionProvider extends InheritedWidget {
  final ContributionBloc contributionBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ContributionBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(ContributionProvider)
              as ContributionProvider)
          .contributionBloc;

  ContributionProvider(
      {Key key, ContributionBloc contributionBloc, Widget child})
      : this.contributionBloc = contributionBloc ??
            ContributionBloc(
              RocksApi(),
            ),
        super(child: child, key: key);
}
