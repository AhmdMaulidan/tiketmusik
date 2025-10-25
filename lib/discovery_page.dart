import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiscoveryPage extends StatelessWidget {
  final List<Map<String, dynamic>> events;
  final Function(Map<String, dynamic>) onEventTap;
  final TextEditingController searchController;

  const DiscoveryPage({
    super.key,
    required this.events,
    required this.onEventTap,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    final featuredEvents = events.where((e) => e['isMainEvent'] == false).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Text(
                'Temukan',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search, color: Colors.white70),
                    hintText: 'Cari acara, artis, atau lokasi',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _buildSectionTitle('Kategori'),
              const SizedBox(height: 15),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryCard('Konser', 'assets/images/upcoming1.png'),
                    _buildCategoryCard('Festival', 'assets/images/upcoming2.png'),
                    _buildCategoryCard('Teater', 'assets/images/upcoming3.png'),
                    _buildCategoryCard('Olahraga', 'assets/images/upcoming4.png'),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              _buildSectionTitle('Acara Unggulan'),
              const SizedBox(height: 15),
              Column(
                children: featuredEvents.map((event) {
                  return _buildEventTile(
                    event,
                    event['title']!,
                    event['location']!,
                    event['date']!,
                    event['imagePath']!,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCategoryCard(String title, String imagePath) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildEventTile(Map<String, dynamic> event,
      String title, String location, String date, String imagePath) {
    return GestureDetector(
      onTap: () => onEventTap(event),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    location,
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF8A2BE2).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                date,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF8A2BE2),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
