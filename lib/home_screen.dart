import 'dart:math';

import 'package:flutter/material.dart';
import 'package:workspaces_ui/core/utils/layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.listItem,
  });

  final List<String> listItem;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _filteredItems = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.listItem;
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = widget.listItem
          .where((item) => item.toLowerCase().contains(query))
          .toList();
    });
  }

  Color _lighten(Color color, [double amount = .1]) {
    final hsl = HSLColor.fromColor(color);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }

  Color _generateRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    final windowWidth = MediaQuery.sizeOf(context).width;
    final hexagonColor = Theme.of(context).colorScheme.inverseSurface;
    final backgroundColor = Theme.of(context).colorScheme.surface;
    final textColor = Theme.of(context).colorScheme.inverseSurface;
    final searchFieldColor = _lighten(backgroundColor, 0.1);
    final borderColor = _lighten(searchFieldColor, 0.2);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Padding(
          padding: HorizontalSpacing.centered(windowWidth),
          child: AppBar(
            centerTitle: true,
            leading: IconButton(
              onPressed: () {},
              icon: CustomPaint(
                size: const Size(24, 24),
                painter: HexagonPainter(
                  color: hexagonColor,
                ),
              ),
            ),
            title: const Text('Рабочие пространства'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.add,
                  size: 36,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Padding(
              padding: HorizontalSpacing.centered(windowWidth),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: searchFieldColor,
                  labelText: 'Поиск',
                  labelStyle: TextStyle(
                    color: borderColor,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: borderColor,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: borderColor,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: borderColor,
                      width: 2.0,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: borderColor,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final windowSize = constraints.materialBreakpoint;
                return CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: HorizontalSpacing.centered(windowWidth),
                      sliver: SliverGrid.builder(
                        itemCount: _filteredItems.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 3 / 2,
                          crossAxisCount: switch (windowSize) {
                            WindowSize.compact => 2,
                            <= WindowSize.expanded => 3,
                            _ => 4,
                          },
                        ),
                        itemBuilder: (context, index) => _CustomCard(
                          label: _filteredItems[index],
                          textColor: textColor,
                          // cardColor: _generateRandomColor(),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HexagonPainter extends CustomPainter {
  final Color color;

  HexagonPainter({super.repaint, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final path = Path();
    final double sideLength = size.width / 2.0;
    final double centerX = size.width / 2.0;
    final double centerY = size.height / 2.0;

    path.moveTo(centerX + sideLength * cos(0), centerY + sideLength * sin(0));
    for (int i = 1; i <= 6; i++) {
      path.lineTo(centerX + sideLength * cos(pi / 3 * i),
          centerY + sideLength * sin(pi / 3 * i));
    }
    path.close();

    canvas.drawPath(path, paint);

    final circlePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5),
        size.width * 0.2, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _CustomCard extends StatelessWidget {
  const _CustomCard({
    required this.label,
    required this.textColor,
    this.cardColor,
  });
  final String label;
  final Color textColor;
  final Color? cardColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: ColoredBox(
        color: cardColor ?? _getColor(label),
        child: Stack(
          children: [
            Positioned(
              bottom: 10,
              left: 10,
              child: Text(
                label,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: textColor,
                    ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColor(String label) {
    switch (label) {
      case 'Savva':
        return const Color(0xFFFE406C);

      case 'Olluco':
        return const Color(0xFFFE4BA6);

      case 'Loona':
        return const Color(0xFF6A58FA);

      case 'Folk':
        return const Color(0xFF1CB2F1);

      case 'White Rabbit':
        return const Color(0xFF1CC5CF);

      case 'Sage':
        return const Color(0xFF17CE58);

      case 'Maya':
        return const Color(0xFFF5BA20);

      case 'Jun':
        return const Color(0xFFFF7616);

      case 'Onest':
        return const Color(0xFFA65EFE);

      case 'Probka на Цветном':
        return const Color(0xFF18BBFF);
      default:
        return const Color(0xFF18BBFF);
    }
  }
}
