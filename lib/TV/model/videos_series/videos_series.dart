// import 'package:cinema_x/Movies/model/Videos_model.dart'; // Ensure correct import

// class Result {
//   num? id;
//   List<Video_Movies_model>? results;

//   Result({this.id, this.results});

//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//         id: json['id'] != null ? num.tryParse(json['id'].toString()) : null,
//         results: (json['results'] as List<dynamic>?)
//             ?.map((e) =>
//                 Video_Movies_model.fromJson(Map<String, dynamic>.from(e)))
//             .toList(),
//       );

//   Map<String, dynamic> toJson() => {
//         if (id != null) 'id': id,
//         if (results != null)
//           'results': results?.map((e) => e.toJson()).toList(),
//       };
// }
