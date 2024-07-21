import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

Future<Map<String, dynamic>?> getDocument() async {
  try {
    // Retrieve the email from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    String? userEmail =
        prefs.getString('user_email'); // Use the key you saved the email with

    if (userEmail == null) {
      print('User email not found in SharedPreferences');
      return null;
    }

    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('genra')
        .doc(userEmail)
        .get();

    if (documentSnapshot.exists) {
      return documentSnapshot.data() as Map<String, dynamic>;
    } else {
      print('Document does not exist');
      return null;
    }
  } catch (e) {
    print('Error getting document: $e');
    return null;
  }
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Genres'),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: getDocument(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data available'));
          }

          Map<String, dynamic> data = snapshot.data!;
          // Assuming data contains a list of genres
          List<dynamic> genres = data['favorites'] ?? [];

          if (genres.isEmpty) {
            return const Center(child: Text('No favorite genres found'));
          }

          return ListView.builder(
            itemCount: genres.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(genres[index]
                    .toString()), // Adjust based on the structure of your data
              );
            },
          );
        },
      ),
    );
  }
}
