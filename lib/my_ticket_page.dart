import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTicketPage extends StatelessWidget {
  final List<Map<String, dynamic>> ticketEvents;
  final Function(Map<String, dynamic>)? onTicketTap;

  const MyTicketPage({super.key, required this.ticketEvents, this.onTicketTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'My Tickets',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: ticketEvents.isEmpty
          ? Center(
              child: Text(
                'You have no tickets yet.',
                style: GoogleFonts.poppins(color: Colors.white70, fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: ticketEvents.length,
              itemBuilder: (context, index) {
                final event = ticketEvents[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: GestureDetector(
                    onTap: () => onTicketTap?.call(event),
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF252525),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
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
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  event['date']!,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
