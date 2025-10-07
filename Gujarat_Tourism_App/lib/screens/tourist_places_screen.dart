import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/tourist_place.dart';
import '../services/database_helper.dart';
import 'place_detail_screen.dart';

class TouristPlacesScreen extends StatefulWidget {
  const TouristPlacesScreen({super.key});

  @override
  State<TouristPlacesScreen> createState() => _TouristPlacesScreenState();
}

class _TouristPlacesScreenState extends State<TouristPlacesScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<TouristPlace> _places = [];
  List<TouristPlace> _filteredPlaces = [];
  bool _isLoading = true;
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    'All',
    'Monument',
    'Wildlife',
    'Desert',
    'Temple',
    'Historical',
  ];

  @override
  void initState() {
    super.initState();
    _loadPlaces();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadPlaces() async {
    try {
      // Try to load from database, fallback to dummy data
      List<TouristPlace> places;
      try {
        places = await _databaseHelper.getAllTouristPlaces();
        if (places.isEmpty) {
          places = _createDummyPlaces();
        }
      } catch (e) {
        places = _createDummyPlaces();
      }

      if (mounted) {
        setState(() {
          _places = places;
          _filteredPlaces = places;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _places = _createDummyPlaces();
          _filteredPlaces = _createDummyPlaces();
          _isLoading = false;
        });
      }
    }
  }

  List<TouristPlace> _createDummyPlaces() {
    return [
      TouristPlace(
        id: 1,
        name: 'Statue of Unity',
        description:
            'World\'s tallest statue dedicated to Sardar Vallabhbhai Patel',
        location: 'Kevadia, Narmada District',
        category: 'Monument',
        ticketPrice: 150.0,
        imageUrl: 'https://example.com/statue_of_unity.jpg',
        rating: 4.8,
        openingHours: '8:00 AM - 6:00 PM',
        bestTimeToVisit: 'October to March',
      ),
      TouristPlace(
        id: 2,
        name: 'Gir National Park',
        description: 'Last refuge of Asiatic lions in the world',
        location: 'Junagadh District',
        category: 'Wildlife',
        ticketPrice: 300.0,
        imageUrl: 'https://example.com/gir_national_park.jpg',
        rating: 4.6,
        openingHours: '6:00 AM - 6:00 PM',
        bestTimeToVisit: 'December to March',
      ),
      TouristPlace(
        id: 3,
        name: 'Rann of Kutch',
        description: 'White salt desert famous for Rann Utsav festival',
        location: 'Kutch District',
        category: 'Desert',
        ticketPrice: 200.0,
        imageUrl: 'https://example.com/rann_of_kutch.jpg',
        rating: 4.7,
        openingHours: '24 Hours',
        bestTimeToVisit: 'November to February',
      ),
      TouristPlace(
        id: 4,
        name: 'Somnath Temple',
        description: 'One of the twelve Jyotirlinga shrines of Shiva',
        location: 'Somnath, Gir Somnath District',
        category: 'Temple',
        ticketPrice: 0.0,
        imageUrl: 'https://example.com/somnath_temple.jpg',
        rating: 4.5,
        openingHours: '6:00 AM - 9:00 PM',
        bestTimeToVisit: 'October to March',
      ),
      TouristPlace(
        id: 5,
        name: 'Sabarmati Ashram',
        description: 'Mahatma Gandhi\'s home for over a decade',
        location: 'Ahmedabad',
        category: 'Historical',
        ticketPrice: 10.0,
        imageUrl: 'https://example.com/sabarmati_ashram.jpg',
        rating: 4.4,
        openingHours: '8:30 AM - 6:30 PM',
        bestTimeToVisit: 'October to March',
      ),
      TouristPlace(
        id: 6,
        name: 'Dwarka',
        description: 'Ancient city and one of the Char Dham pilgrimage sites',
        location: 'Dwarka District',
        category: 'Temple',
        ticketPrice: 25.0,
        imageUrl: 'https://example.com/dwarka.jpg',
        rating: 4.3,
        openingHours: '5:00 AM - 9:00 PM',
        bestTimeToVisit: 'October to March',
      ),
    ];
  }

  void _filterPlaces() {
    setState(() {
      _filteredPlaces =
          _places.where((place) {
            final matchesCategory =
                _selectedCategory == 'All' ||
                place.category == _selectedCategory;
            final matchesSearch =
                place.name.toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                ) ||
                place.location.toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                );
            return matchesCategory && matchesSearch;
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.orange[600],
        title: Text(
          'Tourist Places',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        elevation: 0,
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  // Search and Filter Section
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Search Bar
                        TextField(
                          controller: _searchController,
                          onChanged: (_) => _filterPlaces(),
                          decoration: InputDecoration(
                            hintText: 'Search places or locations...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Category Filter
                        SizedBox(
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _categories.length,
                            itemBuilder: (context, index) {
                              final category = _categories[index];
                              final isSelected = category == _selectedCategory;
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: FilterChip(
                                  selected: isSelected,
                                  label: Text(
                                    category,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : Colors.grey[700],
                                    ),
                                  ),
                                  backgroundColor: Colors.grey[200],
                                  selectedColor: Colors.orange[600],
                                  onSelected: (selected) {
                                    setState(() {
                                      _selectedCategory = category;
                                    });
                                    _filterPlaces();
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Places List
                  Expanded(
                    child:
                        _filteredPlaces.isEmpty
                            ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.place_outlined,
                                    size: 64,
                                    color: Colors.grey[400],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No places found',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    'Try adjusting your search or filters',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            )
                            : ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: _filteredPlaces.length,
                              itemBuilder: (context, index) {
                                final place = _filteredPlaces[index];
                                return _buildPlaceCard(place);
                              },
                            ),
                  ),
                ],
              ),
    );
  }

  Widget _buildPlaceCard(TouristPlace place) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => PlaceDetailScreen(place: place)),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                gradient: LinearGradient(
                  colors: [Colors.orange[400]!, Colors.orange[600]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      _getCategoryIcon(place.category),
                      size: 80,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            place.rating.toString(),
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        place.category,
                        style: GoogleFonts.poppins(
                          color: Colors.orange[800],
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          place.location,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    place.description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        place.ticketPrice == 0
                            ? 'Free Entry'
                            : '₹${place.ticketPrice.toInt()}',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[600],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'View Details',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.orange[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.orange[600],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Monument':
        return Icons.account_balance;
      case 'Wildlife':
        return Icons.nature;
      case 'Desert':
        return Icons.landscape;
      case 'Temple':
        return Icons.temple_hindu;
      case 'Historical':
        return Icons.history_edu;
      default:
        return Icons.place;
    }
  }
}
