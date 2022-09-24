import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/popular_tvs_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';


class PopularTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  @override
  _PopularTvsPageState createState() => _PopularTvsPageState();
}

class _PopularTvsPageState extends State<PopularTvsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PopularTvsNotifier>(context, listen: false)
            .fetchPopularTvs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tvs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PopularTvsNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return MyProgressIndicator();
            } else if (data.state == RequestState.Loaded) {
              return TvList(movies: data.movies);
            } else {
              return ErrorMessageContainer(message: data.message);
            }
          },
        ),
      ),
    );
  }
}
