// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// class SeeAllButton extends StatelessWidget {
//   const SeeAllButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Movies'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//             horizontal: MediaQuery.of(context).size.height * .02,
//             vertical: MediaQuery.of(context).size.height * .01),
//         child: Row(
//           children: [
//             Expanded(
//               child: CachedNetworkImage(
//                 imageUrl: "https://via.placeholder.com/150",
//                 placeholder: (context, url) => const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//                 errorWidget: (context, url, error) => const Icon(Icons.error),
//                 height: MediaQuery.of(context).size.height * .4,
//                 width: MediaQuery.of(context).size.width * .4,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(
//               width: 10,
//             ),
//             Expanded(
//               child: CachedNetworkImage(
//                 imageUrl: "https://via.placeholder.com/150",
//                 placeholder: (context, url) => const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//                 errorWidget: (context, url, error) => const Icon(Icons.error),
//                 height: MediaQuery.of(context).size.height * .4,
//                 width: MediaQuery.of(context).size.width * .5,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_x/for_you_row/model/for_you_model_movies.dart';

class SeeAllButton extends StatelessWidget {
  final List<for_you_model_movies> movies;

  const SeeAllButton({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.height * .02,
          vertical: MediaQuery.of(context).size.height * .01,
        ),
        child: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    height: MediaQuery.of(context).size.height * .4,
                    width: MediaQuery.of(context).size.width * .4,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * .05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(movie.overview),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
