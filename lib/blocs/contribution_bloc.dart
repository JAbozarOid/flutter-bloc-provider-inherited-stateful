import 'dart:async';
import 'package:bloc_pattern/models/model.dart';
import 'package:bloc_pattern/models/rocks_api.dart';
import 'package:rxdart/rxdart.dart';

class ContributionBloc {
  final RocksApi rocksApi;

  Stream<List<Contribution>> _result = Stream.empty();
  var _pageName = BehaviorSubject<String>();

  Stream<List<Contribution>> get results => _result;
  Sink<String> get pageName => _pageName;

  ContributionBloc(this.rocksApi){
    _pageName.add('unreviewed');
    _result = _pageName
    .asyncMap((page) => rocksApi.getContribution(pageName: page))
    .asBroadcastStream();
  }

  void dispose() {
    _pageName.close();
  }
 }
