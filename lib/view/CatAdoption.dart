import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:praktikum_1/widget/navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cat {
  final String id;
  final String imageUrl;

  Cat({required this.id, required this.imageUrl});

  factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      id: json['id'],
      imageUrl: json['url'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'adoptionDate': Timestamp.now(),
    };
  }
}

class CatAdoptionPage extends StatefulWidget {
  const CatAdoptionPage({super.key});

  @override
  State<CatAdoptionPage> createState() => _CatAdoptionPageState();
}

class _CatAdoptionPageState extends State<CatAdoptionPage> {
  List<Cat> cats = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchCats();
  }

  Future<void> fetchCats() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    try {
      final response = await http.get(
        Uri.parse('https://api.thecatapi.com/v1/images/search?limit=10'),
        headers: {
          'x-api-key': 'live_yYj6vnWdeqPooWxpbCEvWws0gNC5wAH2Cve5GjAkH92zJmB1ArQPw9zqOQdwlyWT'
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          cats = data.map((json) => Cat.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load cats: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load cats: $e';
      });
    }
  }

  Future<void> adoptCat(Cat cat) async {
    try {
      CollectionReference adoptedCats =
          FirebaseFirestore.instance.collection('adoptedCats');

      await adoptedCats.add(cat.toFirestore());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Cat ID: ${cat.id} adopted successfully!")),
      );
      setState(() {
        cats.removeWhere((c) => c.id == cat.id);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to adopt cat: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Adopt a Cat"),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchCats,
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                )
              : cats.isEmpty
                  ? const Center(child: Text("No cats available for adoption."))
                  : ListView.builder(
                      itemCount: cats.length,
                      itemBuilder: (context, index) {
                        final cat = cats[index];
                        return Card(
                          margin: const EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
                                child: Image.network(
                                  cat.imageUrl,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  headers: {
                                    'User-Agent': 'Mozilla/5.0',
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 200,
                                      width: double.infinity,
                                      color: Colors.grey[300],
                                      child: const Icon(
                                        Icons.image_not_supported,
                                        color: Colors.grey,
                                        size: 50,
                                      ),
                                    );
                                  },
                                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      height: 200,
                                      width: double.infinity,
                                      color: Colors.grey[300],
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                              : null,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              ListTile(
                                title: Text("Cat ID: ${cat.id}"),
                                subtitle: const Text("Click to adopt"),
                                trailing: ElevatedButton(
                                  onPressed: () => adoptCat(cat),
                                  child: const Text("Adopt"),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
      bottomNavigationBar: const CustomNavigationBar(selectedIndex: 1),
    );
  }
}
