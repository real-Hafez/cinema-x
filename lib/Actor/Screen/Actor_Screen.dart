import 'package:flutter/material.dart';
import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/Popular_peoble_movies_series/models/Person_Model.dart';
import 'package:cinema_x/Popular_peoble_movies_series/service/Person_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart'; // Import for date formatting

class ActorScreen extends StatelessWidget {
  const ActorScreen({super.key, required this.personId});
  final int personId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff090E17),
      appBar: AppBar(
        title: FutureBuilder<Person_Model>(
          future: PersonDetailService().getPersonDetail(personId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Actor Details'); // Default title while loading
            } else if (snapshot.hasError) {
              return const Text('Error');
            } else if (!snapshot.hasData) {
              return const Text('No Data');
            } else {
              final personModel = snapshot.data!;
              return Text(personModel.name ?? 'Actor Details'); // Actor's name
            }
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<Person_Model>(
        future: PersonDetailService()
            .getPersonDetail(personId), // Fetch person details
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          }

          final personModel = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Actor's profile image
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl:
                            '${ApiConfig.imageBaseUrl}${personModel.profilePath}',
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error, color: Colors.red),
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.6,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Also Known As
                  const Text(
                    'Also Known As:',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    personModel.alsoKnownAs?.join(', ') ?? 'N/A',
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 16),

                  // Actor's department
                  Text(
                    'Department: ${personModel.knownForDepartment ?? 'N/A'}',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 8),

                  // Actor's gender
                  Text(
                    'Gender: ${personModel.gender == 1 ? 'Female' : 'Male'}',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 8),

                  // Actor's birthday and age
                  _buildBirthdayAndAge(personModel.birthday),
                  const SizedBox(height: 8),

                  // Actor's place of birth
                  if (personModel.placeOfBirth != null)
                    Text(
                      'Place of Birth: ${personModel.placeOfBirth}',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  const SizedBox(height: 16),

                  // Actor's biography
                  const Text(
                    'Biography',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    personModel.biography ?? 'Biography not available',
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 16),

                  // Known For section
                  const Text(
                    'Known For:',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  // Known for items list
                  personModel.knownFor != null &&
                          personModel.knownFor!.isNotEmpty
                      ? Column(
                          children: personModel.knownFor!.map((item) {
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              color: Colors.black54,
                              child: ListTile(
                                leading: CachedNetworkImage(
                                  imageUrl:
                                      '${ApiConfig.imageBaseUrl}${item.posterPath}',
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error,
                                          color: Colors.red),
                                  height: 80,
                                  width: 60,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                  item.title ?? 'Title not available',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  item.overview ?? 'Overview not available',
                                  style: const TextStyle(color: Colors.white70),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 8.0),
                              ),
                            );
                          }).toList(),
                        )
                      : const Center(child: Text('No known for items')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Method to build birthday and age text
  Widget _buildBirthdayAndAge(String? birthday) {
    if (birthday == null || birthday.isEmpty) {
      return const Text(
        'Birthday: N/A',
        style: TextStyle(color: Colors.white, fontSize: 18),
      );
    }

    DateTime birthDate;
    try {
      birthDate = DateFormat('yyyy-MM-dd').parse(birthday);
    } catch (e) {
      return const Text(
        'Birthday: N/A',
        style: TextStyle(color: Colors.white, fontSize: 18),
      );
    }

    final today = DateTime.now();
    final age = today.year -
        birthDate.year -
        (today.month < birthDate.month ||
                (today.month == birthDate.month && today.day < birthDate.day)
            ? 1
            : 0);

    return Text(
      'Birthday: ${DateFormat('MMMM d, yyyy').format(birthDate)} ($age years old)',
      style: const TextStyle(color: Colors.white, fontSize: 18),
    );
  }
}
