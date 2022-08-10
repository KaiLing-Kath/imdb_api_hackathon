import 'dart:math';

import 'package:flutter/material.dart';
import 'package:imdb_api_hackathon/models/movie_model.dart';
import 'package:imdb_api_hackathon/pages/movie_details_page.dart';
import 'package:imdb_api_hackathon/pages/homepage.dart';

class MovieList extends StatelessWidget {
  MovieList({Key? key, required this.searchModel}) : super(key: key);

  final MovieModel searchModel;
  

  @override
  Widget build(BuildContext context) {
    const double tileHeight=280;
    const double tileWidth=tileHeight/4.0*3;
    return Column(
      children: [
        Container(
          height: tileHeight+100,
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
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  elevation: 2,
                  child: Container(
                    height:tileHeight+45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                          Image.network(
                              searchModel.results.elementAt(index).image,
                              fit: BoxFit.fill,
                              height:tileHeight.toDouble(),
                              width:tileWidth
                            ),
                        SizedBox(width: 10),
                        Flexible(
                          child: ConstrainedBox(
                            constraints: BoxConstraints.tightFor(width:tileWidth),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${searchModel.results.elementAt(index).title} ${searchModel.results.elementAt(index).description}',
                                  style: TextStyle(
                                    //taking the 15px as reference font size when it is at 100px and increment the the font size by 1 every single 50 increment in tileheight
                                      fontWeight: FontWeight.bold, fontSize: (15+max(0,(tileHeight-100)/50).truncate()).toDouble()),
                                ),
                                Text(
                                    '${searchModel.results.elementAt(index).genres} • ${searchModel.results.elementAt(index).runtimeStr}'),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
