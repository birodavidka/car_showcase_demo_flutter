import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/cars_data.dart';
import '../../models/car_model.dart';
import '../details/product_detail_screen.dart';

class ProductsScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const ProductsScreen({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Car> _filterCars(String query) {
    if (query.trim().isEmpty) {
      return cars;
    }
    final needle = query.toLowerCase();
    return cars.where((car) {
      final haystack = [
        car.title,
        car.brand,
        car.engine,
        car.fuel,
        car.transmission,
        car.year,
        car.mileage,
        car.pro,
        car.cons,
        ...car.extras,
      ].join(' ').toLowerCase();
      return haystack.contains(needle);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final gridAspect = size.width < 380 ? 0.64 : 0.7;
    final background = widget.isDark
        ? const [Color(0xFF0F0F12), Color(0xFF1A1B22)]
        : const [Color(0xFFF7F6FB), Color(0xFFEDEDF4)];
    final cardColor = widget.isDark ? const Color(0xFF1D1E26) : Colors.white;
    final surface = widget.isDark ? const Color(0xFF242531) : Colors.white;
    final textPrimary =
        widget.isDark ? const Color(0xFFF2F2F2) : const Color(0xFF141414);
    final textSecondary =
        widget.isDark ? const Color(0xFFB0B1BC) : const Color(0xFF7B7B85);
    final accent =
        widget.isDark ? const Color(0xFF5B6BFF) : const Color(0xFF1B1B1F);
    final badgeColor =
        widget.isDark ? const Color(0xFF5B6BFF) : const Color(0xFF1B1B1F);
    final filteredCars = _filterCars(_query);

    return Scaffold(
      backgroundColor: background.last,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: background,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _TopBar(
                          isDark: widget.isDark,
                          onToggleTheme: widget.onToggleTheme,
                        ),
                        const SizedBox(height: 18),
                _SearchField(
                  controller: _searchController,
                  surface: surface,
                  textPrimary: textPrimary,
                  textSecondary: textSecondary,
                  badgeColor: badgeColor,
                  onChanged: (value) => setState(() => _query = value),
                  onClear: () {
                    _searchController.clear();
                    setState(() => _query = '');
                  },
                        ),
                        const SizedBox(height: 24),
                        if (filteredCars.isEmpty)
                          _EmptyState(textSecondary: textSecondary)
                        else
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredCars.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 18,
                              crossAxisSpacing: 18,
                              childAspectRatio: gridAspect,
                            ),
                            itemBuilder: (context, index) {
                              final car = filteredCars[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => ProductDetailScreen(car: car),
                                    ),
                                  );
                                },
                                child: _CarCard(
                                  car: car,
                                  cardColor: cardColor,
                                  textPrimary: textPrimary,
                                  textSecondary: textSecondary,
                                  surface: surface,
                                  accent: accent,
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const _TopBar({
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        _ToggleButton(
          isDark: isDark,
          onTap: onToggleTheme,
        ),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final Color surface;
  final Color textPrimary;
  final Color textSecondary;
  final Color badgeColor;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const _SearchField({
    required this.controller,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.badgeColor,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final hasText = controller.text.isNotEmpty;
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, color: Color(0xFF6C6C72)),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: GoogleFonts.manrope(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: textPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'Keresés',
                hintStyle: GoogleFonts.manrope(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: textSecondary,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'BÉTA',
              style: GoogleFonts.manrope(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
                color: Colors.white,
              ),
            ),
          ),
          if (hasText)
            GestureDetector(
              onTap: onClear,
              child: const Icon(Icons.close_rounded, color: Color(0xFF6C6C72)),
            )
          else
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Color(0xFF6C6C72),
            ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final Color textSecondary;

  const _EmptyState({required this.textSecondary});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: Text(
          'Nincs találat',
          style: GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textSecondary,
          ),
        ),
      ),
    );
  }
}

class _CarCard extends StatelessWidget {
  final Car car;
  final Color cardColor;
  final Color textPrimary;
  final Color textSecondary;
  final Color surface;
  final Color accent;

  const _CarCard({
    required this.car,
    required this.cardColor,
    required this.textPrimary,
    required this.textSecondary,
    required this.surface,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Spacer(),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: surface,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE1E1E8)),
                ),
                child: Icon(
                  car.isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  size: 16,
                  color: car.isFavorite
                      ? const Color(0xFFE04B4B)
                      : const Color(0xFF8A8A93),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Center(
              child: Hero(
                tag: 'car-${car.id}',
                child: Image.asset(car.imageUrls.first, fit: BoxFit.contain),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            car.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                car.brand,
                style: GoogleFonts.manrope(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: textSecondary,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${car.price.toStringAsFixed(0)}',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: textPrimary,
                ),
              ),
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ToggleButton extends StatelessWidget {
  final bool isDark;
  final VoidCallback onTap;

  const _ToggleButton({
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 36,
        width: 64,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1D1E26) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark ? const Color(0xFF2C2D3A) : const Color(0xFFE1E1E8),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            height: 26,
            width: 26,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF5B6BFF) : const Color(0xFF1B1B1F),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isDark ? Icons.nights_stay_rounded : Icons.wb_sunny_rounded,
              size: 14,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
