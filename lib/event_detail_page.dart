import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventDetailPage extends StatefulWidget {
  final Map<String, dynamic> event;
  final Function(int) onToggleBookmark;

  const EventDetailPage(
      {super.key, required this.event, required this.onToggleBookmark});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  late bool isBookmarked;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    isBookmarked = widget.event['isBookmarked']!;
  }

  void _handleBookmarkTap() {
    // Perbarui state lokal untuk mengubah ikon secara langsung
    setState(() {
      isBookmarked = !isBookmarked;
    });
    // Panggil callback untuk memperbarui state utama di MainPage
    widget.onToggleBookmark(widget.event['id']!);
  }

  void _handleBuyTicket() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate a network request or processing time
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Pembelian Sukses',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF8A2BE2),
          duration: const Duration(seconds: 2),
        ),
      );

      // Wait for snackbar to be visible
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        // Pop this page and return 'true' to signal a successful purchase
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              widget.event['detailImagePath'] ?? widget.event['imagePath']!,
              fit: BoxFit.cover,
            ),
          ),
          // Top Buttons
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  ),
                ),
                GestureDetector(
                  onTap: _handleBookmarkTap,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: isBookmarked
                          ? const Color(0xFF8A2BE2)
                          : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Event Details Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.45,
            minChildSize: 0.45,
            maxChildSize: 0.8,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                padding: const EdgeInsets.all(25.0),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
                    Text(
                      widget.event['title']!,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            color: Colors.white70, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          widget.event['location'] ?? 'Lokasi tidak ditentukan',
                          style: GoogleFonts.poppins(
                              color: Colors.white70, fontSize: 16),
                        ),
                        const SizedBox(width: 20),
                        const Icon(Icons.calendar_today,
                            color: Colors.white70, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          widget.event['date'] ?? 'Tanggal tidak ditentukan',
                          style: GoogleFonts.poppins(
                              color: Colors.white70, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.event['description'] ?? 'Tidak ada deskripsi tersedia.',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // Buy Ticket Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black, // Match the sheet color
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 30),
              child: GestureDetector(
                onTap: _isLoading ? null : _handleBuyTicket,
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8A2BE2),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Rp${widget.event['price'] ?? '--'}',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Beli Tiket Sekarang',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
