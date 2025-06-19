class catadd {
  final int? id;
  final String title;
  final String description;
  final bool completed;
  final String type; // ➕ Tambahkan properti type

  catadd({
    this.id,
    required this.title,
    required this.description,
    required this.completed,
    this.type = 'Other', // ➕ Default ke "Other" jika tidak ditentukan
  });

  factory catadd.fromMap(Map<String, dynamic> json) => catadd(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        completed: json['completed'] == 1,
        type: json['type'] ?? 'Other',
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'completed': completed ? 1 : 0,
        'type': type,
      };
}
