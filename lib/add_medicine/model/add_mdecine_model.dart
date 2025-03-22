class MedicineModel {
  String title;
  String description;
  String? imagePath;
  String capacity;
  int dosage;
  int stock;

  MedicineModel({
    required this.title,
    required this.description,
    this.imagePath,
    this.capacity = "500mg", // Default capacity
    this.dosage = 1, // Default dosage
    this.stock = 10, // Default stock
  });

  // Convert MedicineModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'imagePath': imagePath,
      'capacity': capacity,
      'dosage': dosage,
      'stock': stock,
    };
  }

  // Create MedicineModel from JSON
  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      title: json['title'],
      description: json['description'],
      imagePath: json['imagePath'],
      capacity: json['capacity'] ?? "500mg", // Default if not provided
      dosage: json['dosage'] ?? 1, // Default if not provided
      stock: json['stock'] ?? 10, // Default if not provided
    );
  }
}