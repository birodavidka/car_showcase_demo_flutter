import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import '../../models/car_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final Car car;

  const ProductDetailScreen({super.key, required this.car});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedThumb = 0;

  @override
  Widget build(BuildContext context) {
    final car = widget.car;
    final gallery = car.imageUrls;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark ? const Color(0xFF0F0F12) : const Color(0xFFF7F6FB);
    final surface = isDark ? const Color(0xFF1D1E26) : Colors.white;
    final surfaceSoft = isDark ? const Color(0xFF242531) : const Color(0xFFF3F3F7);
    final textPrimary = isDark ? const Color(0xFFF2F2F2) : const Color(0xFF1B1B1F);
    final textSecondary =
        isDark ? const Color(0xFFB0B1BC) : const Color(0xFF5A5A63);
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _IconButton(
                          icon: Icons.arrow_back_ios_new_rounded,
                          onTap: () => Navigator.of(context).pop(),
                        ),
                        const Spacer(),
                        _IconButton(
                          icon: car.isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Hero(
                        tag: 'car-${car.id}',
                        child: Image.asset(
                          gallery[_selectedThumb],
                          height: 240,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 70,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: gallery.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final isSelected = index == _selectedThumb;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedThumb = index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: surface,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFF5B6BFF)
                                      : const Color(0xFFE7E7EF),
                                  width: 2,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x0C000000),
                                    blurRadius: 10,
                                    offset: Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                gallery[index],
                                width: 46,
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
                      decoration: BoxDecoration(
                        color: surface,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x10000000),
                            blurRadius: 16,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '\$${car.price.toStringAsFixed(0)}',
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: textPrimary,
                                  ),
                                ),
                                const Spacer(),
                                _IconButton(
                                  icon: Icons.share_outlined,
                                  onTap: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      barrierColor: Colors.black54,
                                      builder: (_) => _ShareSheet(car: car),
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          Text(
                            car.title,
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Text(
                                car.brand,
                                style: GoogleFonts.manrope(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: textSecondary,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                height: 6,
                                width: 6,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4C6FFF),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              _SpecChip(
                                icon: Icons.speed_rounded,
                                label: car.engine,
                                surface: surfaceSoft,
                                textColor: textSecondary,
                              ),
                              _SpecChip(
                                icon: Icons.local_gas_station_rounded,
                                label: car.fuel,
                                surface: surfaceSoft,
                                textColor: textSecondary,
                              ),
                              _SpecChip(
                                icon: Icons.settings,
                                label: car.transmission,
                                surface: surfaceSoft,
                                textColor: textSecondary,
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          Text(
                            'Pros / Cons',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: textPrimary,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _InfoRow(
                            icon: Icons.check_circle_rounded,
                            color: const Color(0xFF34C759),
                            text: car.pro,
                            textColor: textSecondary,
                          ),
                          const SizedBox(height: 8),
                          _InfoRow(
                            icon: Icons.cancel_rounded,
                            color: const Color(0xFFE04B4B),
                            text: car.cons,
                            textColor: textSecondary,
                          ),
                          const SizedBox(height: 18),
                          Text(
                            'Extras',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: textPrimary,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: car.extras
                                .map((extra) => _Pill(
                                      text: extra,
                                      surface: surfaceSoft,
                                      textColor: textSecondary,
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _SpecChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color surface;
  final Color textColor;

  const _SpecChip({
    required this.icon,
    required this.label,
    required this.surface,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: textColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final Color textColor;

  const _InfoRow({
    required this.icon,
    required this.color,
    required this.text,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.manrope(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: textColor,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  final Color surface;
  final Color textColor;

  const _Pill({
    required this.text,
    required this.surface,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: GoogleFonts.manrope(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}

class _ShareSheet extends StatelessWidget {
  final Car car;

  const _ShareSheet({required this.car});

  String _buildShareText() {
    return [
      car.title,
      car.brand,
      'Év: ${car.year}',
      'Motor: ${car.engine}',
      'Váltó: ${car.transmission}',
      'Ár: \$${car.price.toStringAsFixed(0)}',
      '',
      'Extrák: ${car.extras.join(', ')}',
    ].join('\n');
  }

  Future<void> _shareText(BuildContext context, String text) async {
    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();
    try {
      await Share.share(text);
    } catch (error) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Megosztás nem sikerült')),
      );
    }
  }

  String _guessMimeType(String path) {
    final lower = path.toLowerCase();
    if (lower.endsWith('.png')) {
      return 'image/png';
    }
    if (lower.endsWith('.webp')) {
      return 'image/webp';
    }
    return 'image/jpeg';
  }

  Future<List<XFile>> _loadImageFiles() async {
    final files = <XFile>[];
    for (var i = 0; i < car.imageUrls.length; i++) {
      final path = car.imageUrls[i];
      final data = await rootBundle.load(path);
      final bytes = data.buffer.asUint8List();
      final ext = path.split('.').last;
      files.add(
        XFile.fromData(
          bytes,
          mimeType: _guessMimeType(path),
          name: '${car.id}_${i + 1}.$ext',
        ),
      );
    }
    return files;
  }

  Future<void> _shareImages(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();
    try {
      final files = await _loadImageFiles();
      await Share.shareXFiles(
        files,
        text: car.title,
      );
    } catch (error) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Képek megosztása nem sikerült')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? const Color(0xFF1D1E26) : Colors.white;
    final surfaceSoft = isDark ? const Color(0xFF262836) : const Color(0xFFF3F3F7);
    final textPrimary =
        isDark ? const Color(0xFFF2F2F2) : const Color(0xFF1B1B1F);
    final textSecondary =
        isDark ? const Color(0xFFB0B1BC) : const Color(0xFF6C6C72);

    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Container(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 24,
                  offset: Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 4,
                    width: 42,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF3A3C4A)
                          : const Color(0xFFE1E1E8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Text(
                      'Megosztás',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: textPrimary,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: surfaceSoft,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close_rounded,
                          size: 18,
                          color: textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  car.title,
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                _ShareAction(
                  icon: Icons.link_rounded,
                  label: 'Link megosztása',
                  surface: surfaceSoft,
                  textColor: textPrimary,
                  onTap: () => _shareText(
                    context,
                    'https://example.com/cars/${car.id}',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ShareAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color textColor;
  final Color surface;

  const _ShareAction({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.textColor,
    required this.surface,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: textColor, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.manrope(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _IconButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark ? const Color(0xFF1D1E26) : Colors.white;
    final iconColor = isDark ? const Color(0xFFF2F2F2) : const Color(0xFF1B1B1F);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, size: 18, color: iconColor),
      ),
    );
  }
}
