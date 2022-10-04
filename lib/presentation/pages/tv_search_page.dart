import 'package:ditonton/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection.dart';
import '../bloc/tv/search/search_tvs_bloc.dart';
import '../widgets/my_progress_indicator.dart';
import '../widgets/tv_card_list.dart';

class TvSearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-tv';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator.get<SearchTvsBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Builder(builder: (context) {
                return TextField(
                  onSubmitted: (query) {
                    context.read<SearchTvsBloc>().add(SearchTvsNow(query));
                  },
                  decoration: InputDecoration(
                    hintText: 'Search title',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.search,
                );
              }),
              SizedBox(height: 16),
              Text(
                'Search Result',
                style: kHeading6,
              ),
              BlocBuilder<SearchTvsBloc, SearchTvsState>(
                builder: (context, state) {
                  if (state is SearchTvsLoading) {
                    return const MyProgressIndicator();
                  } else if (state is SearchTvsSuccess) {
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final movie = state.source[index];
                          return TvCard(movie);
                        },
                        itemCount: state.source.length,
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Container(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
