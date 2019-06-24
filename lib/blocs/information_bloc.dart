import 'package:bloc_pattern/models/github_api.dart';
import 'package:bloc_pattern/models/model.dart';
import 'package:package_info/package_info.dart';
import 'package:rxdart/rxdart.dart';

class InformationBloc {
  final Future<PackageInfo> packageInfo;
  final GithubApi api;

  Stream<PackageInfo> _infoStream = Stream.empty();
  Stream<GithubModel> _releases = Stream.empty();

  Stream<PackageInfo> get infoStream => _infoStream;
  Stream<GithubModel> get releases => _releases;

  InformationBloc(this.packageInfo, this.api) {
    _releases = Observable.defer(
        () => Observable.fromFuture(api.getReleases()).asBroadcastStream(),
        reusable: true);
    // reuseable means that this stream can be use multiple times, they can be open as many as they want

    _infoStream = Observable.defer(
        () => Observable.fromFuture(packageInfo).asBroadcastStream(),
        reusable: true);

    /*
        * The Defer operator waits until an observer subscribes to it,
        * and then it generates an Observable,
        * typically with an Observable factory function.
        * It does this afresh for each subscriber,
        * so although each subscriber may think it is subscribing to the same Observable,
        * in fact each subscriber gets its own individual sequence.
        */
  }

  void dispose() {
    print("Dispose of Information Bloc");
  }
}
