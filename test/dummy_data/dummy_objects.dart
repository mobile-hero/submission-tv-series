import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/domain/entities/creator.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/season.dart';

final testMovie = Movie(
  backdropPath: '/pdfCr8W0wBCpdjbZXSxnKhZtosP.jpg',
  firstAirDate: '2022-09-01',
  genreIds: [10765, 10759, 18],
  id: 84773,
  name: 'The Lord of the Rings: The Rings of Power',
  originCountry: ['US'],
  originalName: 'The Lord of the Rings: The Rings of Power',
  originalLanguage: 'en',
  overview:
      'Beginning in a time of relative peace, we follow an ensemble cast of characters as they confront the re-emergence of evil to Middle-earth. From the darkest depths of the Misty Mountains, to the majestic forests of Lindon, to the breathtaking island kingdom of Númenor, to the furthest reaches of the map, these kingdoms and characters will carve out legacies that live on long after they are gone.',
  popularity: 6073.331,
  posterPath: '/suyNxglk17Cpk8rCM2kZgqKdftk.jpg',
  voteAverage: 7.6,
  voteCount: 619,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  createdBy: [
    Creator(
        id: 1,
        creditId: 'creditId',
        name: 'name',
        profilePath: 'profilePath')
  ],
  episodeRunTime: [1],
  genres: [Genre(id: 1, name: 'Action')],
  firstAirDate: 'firstAirDate',
  homepage: "https://google.com",
  id: 1,
  inProduction: true,
  languages: ['en'],
  lastAirDate: 'lastAirDate',
  lastEpisodeToAir: Episode(
      airDate: 'airDate',
      episodeNumber: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      runtime: 1,
      seasonNumber: 1,
      showId: 1,
      stillPath: 'stillPath',
      voteAverage: 1.0,
      voteCount: 1),
  name: 'name',
  nextEpisodeToAir: Episode(
      airDate: 'airDate',
      episodeNumber: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      runtime: 1,
      seasonNumber: 1,
      showId: 1,
      stillPath: 'stillPath',
      voteAverage: 1.0,
      voteCount: 1),
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originCountry: ['originCountry'],
  originalLanguage: 'en',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  seasons: [
    Season(
        airDate: 'airDate',
        episodeCount: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 1)
  ],
  status: 'Status',
  tagline: 'Tagline',
  type: 'type',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'name': 'name',
  'overview': 'overview',
  'posterPath': 'posterPath',
};
