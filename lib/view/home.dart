import 'package:flutter/material.dart';
import 'package:praktikum_1/service/cat/cat_model.dart';
import 'package:praktikum_1/view/CatAdoption.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Example list – replace with your API call
  List<catadd> catList = [
    catadd(id: 1, title: 'Foxy', type: 'Labrador retriever', description: '', completed: false),
    // Add more sample or real cats
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cat List"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: catList.length,
        itemBuilder: (context, index) {
          final cat = catList[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      'https://placekitten.com/100/100', // Replace with real image if available
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cat.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          cat.type.isEmpty ? 'Unknown Type' : cat.type,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Optional: add follow functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Follow"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CatAdoptionPage()),
          ).then((value) {
            if (value == true) {
              // Optionally reload cat list
              setState(() {});
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
