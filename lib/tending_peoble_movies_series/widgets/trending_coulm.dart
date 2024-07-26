import 'package:cinema_x/tending_peoble_movies_series/models/Person_Model.dart';
import 'package:cinema_x/tending_peoble_movies_series/service/Person_service.dart';
import 'package:cinema_x/tending_peoble_movies_series/widgets/Popular_Actors.dart';
import 'package:cinema_x/tending_peoble_movies_series/widgets/for_you_popular.dart';
import 'package:flutter/material.dart';

class TrendingCoulm extends StatefulWidget {
  const TrendingCoulm({super.key});

  @override
  State<TrendingCoulm> createState() => _TrendingCoulmState();
}

class _TrendingCoulmState extends State<TrendingCoulm> {
  late Future<List<Person_Model>> _personModelFuture;

  @override
  void initState() {
    super.initState();
    _personModelFuture = PersonService().getPerson();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Person_Model>>(
      future: _personModelFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final personModelList = snapshot.data!;
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * .015),
                child: const ForYouPopular(
                  textForRowOrMovie: 'Top Trending Actors',
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              PopularActors(
                personModel: personModelList,
              ),
            ],
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
