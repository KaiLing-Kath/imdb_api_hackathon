import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_api_hackathon/states/action_cubit.dart';
import 'package:imdb_api_hackathon/states/comedy_cubit.dart';
import 'package:imdb_api_hackathon/states/crime_cubit.dart';
import 'package:imdb_api_hackathon/states/fantasy_cubit.dart';
import 'package:imdb_api_hackathon/states/homepage_cubit.dart';
import 'package:imdb_api_hackathon/states/horror_cubit.dart';
import 'package:imdb_api_hackathon/widgets/movie_category_list.dart';
import 'package:imdb_api_hackathon/states/movie_state.dart';
import 'package:imdb_api_hackathon/widgets/movie_lists.dart';
import 'package:imdb_api_hackathon/widgets/skeleton_categories_loading.dart';
import 'package:imdb_api_hackathon/widgets/skeleton_homepage_loading%20copy.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomepageCubit homepageCubit;
  late final ComedyCubit comedyCubit;
  late final ActionCubit actionCubit;
  late final FantasyCubit fantasyCubit;
  late final HorrorCubit horrorCubit;
  late final CrimeCubit crimeCubit;

  static const double MOVIE_HEIGHT = 280;
  static const double MOVIE_WIDTH = MOVIE_HEIGHT/4.0*3;
  static const double CATEGORIES_HEIGHT = 160;
  static const double CATEGORIES_WIDTH = CATEGORIES_HEIGHT/4.0*3;
  

  Widget getMovieInfo({required MoviesState state, required double height, required double width}) {
      if (state is MoviesLoading) {
        return HomepageSkeletonLoading(height: height, width: width);
      }
      if (state is MoviesLoaded &&
          state.movieModel.results.isNotEmpty) {
        return MovieList(searchModel: state.movieModel);
      }
      return Text(state is MoviesError ? state.errorMessage : "");
    }

    Widget getMovieCategoriesInfo({required MoviesState state, required double height, required double width}) {
      if (state is MoviesLoading) {
        return CategoriesSkeletonLoading(height: height, width: width);
      }
      if (state is MoviesLoaded &&
          state.movieModel.results.isNotEmpty) {
        return MovieCategoryList(searchModel: state.movieModel);
      }
      return Text(state is MoviesError ? state.errorMessage : "");
    }

  @override
  void initState() {
    super.initState();
    homepageCubit = BlocProvider.of<HomepageCubit>(context)..fetchHomepage(moviemeter: '1,10');
    comedyCubit = BlocProvider.of<ComedyCubit>(context)..fetchComedy(genres: 'Comedy', count: '10');
    actionCubit = BlocProvider.of<ActionCubit>(context)..fetchAction(genres: 'Action', count: '10');
    fantasyCubit = BlocProvider.of<FantasyCubit>(context)..fetchFantasy(genres: 'Fantasy', count: '10');
    horrorCubit = BlocProvider.of<HorrorCubit>(context)..fetchHorror(genres: 'Horror', count: '10');
    crimeCubit = BlocProvider.of<CrimeCubit>(context)..fetchCrime(genres: 'Crime', count: '10');
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies", style: Theme.of(context).textTheme.headline1),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/search");
            },
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
            color: Color(0xFFE53935),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        scrollDirection: Axis.vertical,
        // shrinkWrap: true,
        children: [
          SizedBox(height:10),
          Text('Top 10 Movies/Series',
              style: Theme.of(context).textTheme.headline3),
          BlocBuilder<HomepageCubit, MoviesState>(
            bloc: homepageCubit,
            builder: (context, state) {
              return getMovieInfo(state: state, height: MOVIE_HEIGHT, width: MOVIE_WIDTH);
              if (state is MoviesLoading) {
                return HomepageSkeletonLoading(height: 290, width: 220);
              }
              if (state is MoviesLoaded &&
                  state.movieModel.results.isNotEmpty) {
                return MovieList(searchModel: state.movieModel);
              }
              return Text(state is MoviesError ? state.errorMessage : "");
            },
          ),
          
          Text("Comedy", style: Theme.of(context).textTheme.headline3),
          BlocBuilder<ComedyCubit, MoviesState>(
            bloc: comedyCubit,
            builder: (context, state) {
              return getMovieCategoriesInfo(state: state, height: CATEGORIES_HEIGHT, width: CATEGORIES_WIDTH);
              if (state is MoviesLoading) {
                return CircularProgressIndicator();
              }
              if (state is MoviesLoaded &&
                  state.movieModel.results.isNotEmpty) {
                return MovieCategoryList(searchModel: state.movieModel);
              }
              return Text(state is MoviesError ? state.errorMessage : "");
            },
          ),
          Text("Action", style: Theme.of(context).textTheme.headline3),
          BlocBuilder<ActionCubit, MoviesState>(
            bloc: actionCubit,
            builder: (context, state) {
              return getMovieCategoriesInfo(state: state, height: CATEGORIES_HEIGHT, width: CATEGORIES_WIDTH);
              if (state is MoviesLoading) {
                return CircularProgressIndicator();
              }
              if (state is MoviesLoaded &&
                  state.movieModel.results.isNotEmpty) {
                return MovieCategoryList(searchModel: state.movieModel);
              }
              return Text(state is MoviesError ? state.errorMessage : "");
            },
          ),
          Text("Fantasy", style: Theme.of(context).textTheme.headline3),
          BlocBuilder<FantasyCubit, MoviesState>(
            bloc: fantasyCubit,
            builder: (context, state) {
              return getMovieCategoriesInfo(state: state, height: CATEGORIES_HEIGHT, width: CATEGORIES_WIDTH);
              if (state is MoviesLoading) {
                return CircularProgressIndicator();
              }
              if (state is MoviesLoaded &&
                  state.movieModel.results.isNotEmpty) {
                return MovieCategoryList(searchModel: state.movieModel);
              }
              return Text(state is MoviesError ? state.errorMessage : "");
            },
          ),
          Text("Horror", style: Theme.of(context).textTheme.headline3),
          BlocBuilder<HorrorCubit, MoviesState>(
            bloc: horrorCubit,
            builder: (context, state) {
              return getMovieCategoriesInfo(state: state, height: CATEGORIES_HEIGHT, width: CATEGORIES_WIDTH);
              if (state is MoviesLoading) {
                return CircularProgressIndicator();
              }
              if (state is MoviesLoaded &&
                  state.movieModel.results.isNotEmpty) {
                return MovieCategoryList(searchModel: state.movieModel);
              }
              return Text(state is MoviesError ? state.errorMessage : "");
            },
          ),
          Text("Crime", style: Theme.of(context).textTheme.headline3),
          BlocBuilder<CrimeCubit, MoviesState>(
            bloc: crimeCubit,
            builder: (context, state) {
              return getMovieCategoriesInfo(state: state, height: CATEGORIES_HEIGHT, width: CATEGORIES_WIDTH);
              if (state is MoviesLoading) {
                return CircularProgressIndicator();
              }
              if (state is MoviesLoaded &&
                  state.movieModel.results.isNotEmpty) {
                return MovieCategoryList(searchModel: state.movieModel);
              }
              return Text(state is MoviesError ? state.errorMessage : "");
            },
          ),
        ],
      ),
    );
  }
}
