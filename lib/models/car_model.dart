class Car {
  final String id;
  final String title;
  final String brand;
  final List<String> imageUrls;
  final double price;
  final bool isFavorite;
  final String description;
  final String fuel;
  final String engine;
  final String mileage;
  final String transmission;
  final String year;
  final String pro;
  final String cons;
  final List<String> extras;

  const Car({
    required this.id,
    required this.title,
    required this.brand,
    required this.imageUrls,
    required this.price,
    this.isFavorite = false,
    required this.description,
    required this.fuel,
    required this.engine,
    required this.mileage,
    required this.transmission,
    required this.year,
    required this.pro,
    required this.cons,
    required this.extras,
  });
}
