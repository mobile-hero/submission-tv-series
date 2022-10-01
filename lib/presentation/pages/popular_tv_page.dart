import 'package:ditonton/presentation/bloc/tv/popular/popular_tvs_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/tv_list.dart';
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
    // Future.microtask(() =>
    //     Provider.of<PopularTvsNotifier>(context, listen: false)
    //         .fetchPopularTvs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tvs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvsBloc, PopularTvsState>(
          builder: (context, state) {
            if (state is PopularTvsLoading) {
              return MyProgressIndicator();
            } else if (state is PopularTvsSuccess) {
              return TvList(movies: state.source);
            } else if (state is PopularTvsError) {
              return ErrorMessageContainer(message: state.message);
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
