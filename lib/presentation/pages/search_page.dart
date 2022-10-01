import 'package:ditonton/common/constants.dart';
import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/movie/search/search_movies_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/my_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator.get<SearchMoviesBloc>(),
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
                    context
                        .read<SearchMoviesBloc>()
                        .add(SearchMoviesNow(query));
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
              BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
                builder: (context, state) {
                  if (state is SearchMoviesLoading) {
                    return const MyProgressIndicator();
                  } else if (state is SearchMoviesSuccess) {
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final movie = state.source[index];
                          return MovieCard(movie);
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
