import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookmarkPage extends StatelessWidget {
  final List<Map<String, dynamic>> bookmarkedEvents;
  final Function(int) onToggleBookmark;
  final Function(Map<String, dynamic>) onEventTap;

  const BookmarkPage({
    super.key,
    required this.bookmarkedEvents,
    required this.onToggleBookmark,
    required this.onEventTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Bookmarks',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              if (bookmarkedEvents.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text(
                      'You haven\'t bookmarked any events yet.',
                      style: TextStyle(color: Colors.white54, fontSize: 16),
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: bookmarkedEvents.length,
                    itemBuilder: (context, index) {
                      final event = bookmarkedEvents[index];
                      return GestureDetector(
                        onTap: () => onEventTap(event),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  event['imagePath']!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      event['title']!,
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '${event['location'] ?? ''} • ${event['date'] ?? ''}',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white54,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.bookmark, color: Color(0xFF8A2BE2)),
                                onPressed: () => onToggleBookmark(event['id']!),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
