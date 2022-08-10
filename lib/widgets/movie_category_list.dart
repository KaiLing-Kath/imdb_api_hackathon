import 'package:flutter/material.dart';
import 'package:imdb_api_hackathon/models/movie_model.dart';
import 'package:imdb_api_hackathon/pages/movie_details_page.dart';


class MovieCategoryList extends StatelessWidget {
  const MovieCategoryList({Key? key, required this.searchModel})
      : super(key: key);

  final MovieModel searchModel;

  @override
  Widget build(BuildContext context) {
    return 
        Container(
          height: 200,
          child: ListView.builder(
        
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: searchModel.results.length,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/details-page",
                      arguments: DetailsPage(movieDetails: {
                        'title': searchModel.results.elementAt(index).title,
                        'image': searchModel.results.elementAt(index).image,
                        'plot': searchModel.results.elementAt(index).plot,
                        'description':
                            searchModel.results.elementAt(index).description,
                        'contentRating':
                            searchModel.results.elementAt(index).contentRating,
                        'runtimeStr':
                            searchModel.results.elementAt(index).runtimeStr,
                        'imDbRating':
                            searchModel.results.elementAt(index).imDbRating,
                        'imDbRatingVotes': searchModel.results
                            .elementAt(index)
                            .imDbRatingVotes,
                        'stars': searchModel.results.elementAt(index).stars,
                        'genres': searchModel.results.elementAt(index).genres,
                        // 'genreList': searchModel.results.elementAt(index).genreList,
                        // 'starList': searchModel.results.elementAt(index).starList,
                      }));
                },
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network(
                          searchModel.results.elementAt(index).image,
                          fit: BoxFit.fill,
                          height: 160,
                          width: 120,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 20.0,
                            ),
                            Text(searchModel.results
                                .elementAt(index)
                                .imDbRating),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ));
  }
}
