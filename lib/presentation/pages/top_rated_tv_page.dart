import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tv/top_rated/top_rated_tvs_bloc.dart';
import '../widgets/tv_list.dart';
import '../widgets/widgets.dart';

class TopRatedTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  @override
  _TopRatedTvsPageState createState() => _TopRatedTvsPageState();
}

class _TopRatedTvsPageState extends State<TopRatedTvsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tvs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvsBloc, TopRatedTvsState>(
          builder: (context, state) {
            if (state is TopRatedTvsLoading) {
              return MyProgressIndicator();
            } else if (state is TopRatedTvsSuccess) {
              return TvList(movies: state.source);
            } else if (state is TopRatedTvsError) {
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
