import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageContent extends StatelessWidget {
  final List<Map<String, dynamic>> events;
  final Function(int) onToggleBookmark;
  final Function(Map<String, dynamic>) onEventTap;
  final String? userName;
  final TextEditingController searchController;

  const HomePageContent({
    super.key,
    required this.events,
    required this.onToggleBookmark,
    required this.onEventTap,
    this.userName,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    final mainEvent = events.firstWhere((e) => e['isMainEvent'] == true, orElse: () => {});
    final upcomingEvents = events.where((e) => e['isMainEvent'] == false).toList();

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Halo, ${userName ?? 'Pengguna'}',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Ayo temukan event terbaikmu',
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/images/logoprofile.png'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
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
                hintText: 'Cari acara atau artis...',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        if (mainEvent.isNotEmpty)
        const SizedBox(height: 30),
        if (mainEvent.isNotEmpty)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: GestureDetector(
            onTap: () => onEventTap(mainEvent),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(mainEvent['imagePath']!),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mainEvent['title']!,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${mainEvent['location']!} • ${mainEvent['date']!}',
                        style: GoogleFonts.poppins(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Akan Datang',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Lihat Semua',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF8A2BE2),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: upcomingEvents.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final event = upcomingEvents[index];
              return GestureDetector(
                onTap: () => onEventTap(event),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage(event['imagePath']!),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 10,
                              right: 10,
                              child: GestureDetector(
                                onTap: () => onToggleBookmark(event['id']!),
                                child: CircleAvatar(
                                  backgroundColor: Colors.black.withOpacity(0.5),
                                  child: Icon(
                                    event['isBookmarked']! ? Icons.bookmark : Icons.bookmark_border,
                                    color: event['isBookmarked']! ? const Color(0xFF8A2BE2) : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      event['title']!,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${event['location']!} • ${event['date']!}',
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20), // Add some padding at the bottom
      ],
    );
  }
}
