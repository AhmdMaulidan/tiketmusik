import 'package:flutter/material.dart';
import 'package:tiketmusik/bookmark_page.dart';
import 'package:tiketmusik/discovery_page.dart';
import 'package:tiketmusik/event_detail_page.dart';
import 'package:tiketmusik/event_ticket_page.dart';
import 'package:tiketmusik/home_page.dart';
import 'package:tiketmusik/my_ticket_page.dart';

class MainPage extends StatefulWidget {
  final String? userName;

  const MainPage({super.key, this.userName});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _boughtTickets = [];
  late List<Map<String, dynamic>> _filteredEvents;
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _events = [
    {
      'id': 0,
      'title': 'Pesta Dansa',
      'imagePath': 'assets/images/play1.png',
      'detailImagePath': 'assets/images/aboutevent1.png',
      'date': '08 OKT 2024',
      'location': 'Jakarta, ID',
      'price': 750000,
      'description':
          '"Pesta Dansa" adalah festival musik dan seni tahunan yang merayakan semangat musim panas dan kekuatan musik untuk menyatukan orang.',
      'isBookmarked': false,
      'isMainEvent': true,
    },
    {
      'id': 1,
      'title': 'Harmoni Nusantara: Fusion Genre',
      'imagePath': 'assets/images/upcoming1.png',
      'date': '12 NOV 2024',
      'location': 'Bandung, ID',
      'price': 450000,
      'description':
          'Sebuah perayaan musik yang menampilkan berbagai genre, dari pop hingga tradisional, yang dibawakan oleh musisi-musisi berbakat dari seluruh Indonesia.',
      'isBookmarked': false,
      'isMainEvent': false,
    },
    {
      'id': 2,
      'title': 'Odisei Sonic: Perjalanan Waktu dan Ruang',
      'imagePath': 'assets/images/upcoming2.png',
      'date': '25 DES 2024',
      'location': 'Yogyakarta, ID',
      'price': 550000,
      'description':
          'Sebuah pertunjukan musik elektronik yang imersif, membawa penonton dalam perjalanan audiovisual yang tak terlupakan.',
      'isBookmarked': false,
      'isMainEvent': false,
    },
    {
      'id': 3,
      'title': 'Festival Senja',
      'imagePath': 'assets/images/upcoming3.png',
      'date': '15 JAN 2025',
      'location': 'Surabaya, ID',
      'price': 350000,
      'description':
          'Nikmati suasana senja yang magis dengan iringan musik akustik dan indie dari band-band lokal ternama.',
      'isBookmarked': false,
      'isMainEvent': false,
    },
    {
      'id': 4,
      'title': 'Panggung Gembira',
      'imagePath': 'assets/images/upcoming4.png',
      'date': '28 FEB 2025',
      'location': 'Semarang, ID',
      'price': 400000,
      'description':
          'Sebuah konser musik yang meriah dengan penampilan dari berbagai artis pop dan dangdut populer.',
      'isBookmarked': false,
      'isMainEvent': false,
    },
    {
      'id': 5,
      'title': 'Legenda Rock Indonesia',
      'imagePath': 'assets/images/upcoming5.png',
      'date': '10 MAR 2025',
      'location': 'Bali, ID',
      'price': 850000,
      'description':
          'Saksikan penampilan para legenda rock Indonesia dalam satu panggung spektakuler di Pulau Dewata.',
      'isBookmarked': false,
      'isMainEvent': false,
    },
    {
      'id': 6,
      'title': 'Malam Jazz Istimewa',
      'imagePath': 'assets/images/upcoming6.png',
      'date': '22 APR 2025',
      'location': 'Makassar, ID',
      'price': 300000,
      'description':
          'Alunan musik jazz yang menenangkan akan menemani malam Anda di kota Makassar.',
      'isBookmarked': false,
      'isMainEvent': false,
    },
    {
      'id': 7,
      'title': 'Sore Akustik',
      'imagePath': 'assets/images/upcoming7.png',
      'date': '05 MEI 2025',
      'location': 'Medan, ID',
      'price': 250000,
      'description':
          'Habiskan sore Anda dengan lagu-lagu akustik yang dibawakan oleh penyanyi-penyanyi solo berbakat.',
      'isBookmarked': false,
      'isMainEvent': false,
    },
    {
      'id': 8,
      'title': 'Festival EDM',
      'imagePath': 'assets/images/upcoming8.png',
      'date': '18 JUN 2025',
      'location': 'Palembang, ID',
      'price': 950000,
      'description':
          'Rasakan energi musik dansa elektronik di festival terbesar di Sumatera.',
      'isBookmarked': false,
      'isMainEvent': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _filteredEvents = _events;
    _searchController.addListener(_filterEvents);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterEvents() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredEvents = _events.where((event) {
        final title = event['title']!.toLowerCase();
        final location = event['location']!.toLowerCase();
        return title.contains(query) || location.contains(query);
      }).toList();
    });
  }

  void _toggleBookmark(int id) {
    setState(() {
      final event = _events.firstWhere((e) => e['id'] == id);
      event['isBookmarked'] = !event['isBookmarked'];
      _filterEvents(); // Re-apply filter to keep the list consistent
    });
  }

  void _buyTicket(Map<String, dynamic> event) {
    setState(() {
      if (!_boughtTickets.any((e) => e['id'] == event['id'])) {
        _boughtTickets.add(event);
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _handleEventTap(Map<String, dynamic> event) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventDetailPage(
          event: event,
          onToggleBookmark: _toggleBookmark,
        ),
      ),
    );
    if (result == true) {
      _buyTicket(event);
      _onItemTapped(3); // Switch to My Ticket page
    }
  }

  void _navigateToTicketPage(Map<String, dynamic> event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventTicketPage(event: event),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomePageContent(
        events: _filteredEvents,
        onToggleBookmark: _toggleBookmark,
        onEventTap: _handleEventTap,
        userName: widget.userName,
        searchController: _searchController,
      ),
      DiscoveryPage(
        events: _filteredEvents,
        onEventTap: _handleEventTap,
        searchController: _searchController,
      ),
      BookmarkPage(
        bookmarkedEvents: _events.where((e) => e['isBookmarked']!).toList(),
        onToggleBookmark: _toggleBookmark,
        onEventTap: _handleEventTap,
      ),
      MyTicketPage(
        ticketEvents: _boughtTickets,
        onTicketTap: _navigateToTicketPage,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        elevation: 0,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFF252525).withOpacity(0.9),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavItem(Icons.home_outlined, 0),
              _buildNavItem(Icons.explore_outlined, 1),
              _buildNavItem(Icons.bookmark_border_outlined, 2),
              _buildNavItem(Icons.local_activity_outlined, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: _selectedIndex == index
              ? const Color(0xFF8A2BE2)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
