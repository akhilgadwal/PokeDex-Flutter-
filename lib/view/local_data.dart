
import 'package:flutter/material.dart';
import 'package:pokedex/provider/provider.dart';


class DataRetrievalScreen extends StatefulWidget {
  @override
  _DataRetrievalScreenState createState() => _DataRetrievalScreenState();
}

class _DataRetrievalScreenState extends State<DataRetrievalScreen> {
  List<Map<String, dynamic>> retrievedData = [];

  @override
  void initState() {
    super.initState();
    retrieveData();
  }

  void retrieveData() {
    final data = box.getValues();
    final savedData = box.read('favoritePokemons');
    if (savedData != null) {
      setState(() {
        retrievedData = List<Map<String, dynamic>>.from(savedData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retrieved Data Screen'),
      ),
      body: retrievedData.isEmpty
          ? const Center(
              child: Text('No data saved to local storage'),
            )
          : ListView.builder(
              itemCount: retrievedData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(retrievedData[index]['name']),
                  // You can add more properties based on the structure of your data.
                );
              },
            ),
    );
  }
}