import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/for_you_row/model/for_you_model_movies.dart';

class SeeAllButton extends StatelessWidget {
  final List<for_you_model_movies> movies;

  const SeeAllButton({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('data'),
      ),
    );
//     return Scaffold(
//       body: GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 55,
//           childAspectRatio: 1, // Adjusted aspect ratio for different size
//         ),
//         itemCount: movies.length,
//         itemBuilder: (BuildContext context, int index) {
//           final movie = movies[index];
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: CachedNetworkImage(
//               imageUrl: '${ApiConfig.imageBaseUrl}${movie.posterPath}',
//               progressIndicatorBuilder: (context, url, downloadProgress) =>
//                   Center(
//                 child: CircularProgressIndicator(
//                   value: downloadProgress.progress,
//                   valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
//                   backgroundColor: Colors.white,
//                 ),
//               ),
//               errorWidget: (context, url, error) => const Icon(Icons.error),
//               fit: BoxFit.cover, // Use fit to adjust the image size
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
  }
}
