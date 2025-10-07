import 'package:flutter/material.dart';

void main() {
  runApp(GujaratTouristApp());
}

class GujaratTouristApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gujarat Tourist Guide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  List<Widget> screens = [
    DashboardScreen(),
    PlacesScreen(),
    TicketsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        selectedItemColor: Colors.orange,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.place), label: 'Places'),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number),
            label: 'Tickets',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gujarat Tourist Guide'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Gujarat!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Popular Places',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  PlaceCard('Statue of Unity', Icons.account_balance, '150'),
                  PlaceCard('Gir National Park', Icons.nature, '300'),
                  PlaceCard('Rann of Kutch', Icons.landscape, '200'),
                  PlaceCard('Somnath Temple', Icons.temple_hindu, 'Free'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlaceCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final String price;

  PlaceCard(this.name, this.icon, this.price);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.orange),
            SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
            Text(
              price == 'Free' ? 'Free' : '₹$price',
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlacesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> places = [
    {'name': 'Statue of Unity', 'location': 'Kevadia', 'price': '150'},
    {'name': 'Gir National Park', 'location': 'Junagadh', 'price': '300'},
    {'name': 'Rann of Kutch', 'location': 'Kutch', 'price': '200'},
    {'name': 'Somnath Temple', 'location': 'Somnath', 'price': 'Free'},
    {'name': 'Sabarmati Ashram', 'location': 'Ahmedabad', 'price': '10'},
    {'name': 'Dwarka', 'location': 'Dwarka', 'price': '25'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tourist Places'),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.orange[100],
                child: Icon(Icons.place, color: Colors.orange),
              ),
              title: Text(
                place['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(place['location']),
              trailing: Text(
                place['price'] == 'Free' ? 'Free' : '₹${place['price']}',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlaceDetailScreen(place: place),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class PlaceDetailScreen extends StatelessWidget {
  final Map<String, dynamic> place;

  PlaceDetailScreen({required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place['name']),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.place, size: 80, color: Colors.orange),
            ),
            SizedBox(height: 20),
            Text(
              place['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              place['location'],
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Text(
              'Price: ${place['price'] == 'Free' ? 'Free Entry' : '₹${place['price']} per person'}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookTicketScreen(place: place),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: Text('Book Ticket', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookTicketScreen extends StatefulWidget {
  final Map<String, dynamic> place;

  BookTicketScreen({required this.place});

  @override
  _BookTicketScreenState createState() => _BookTicketScreenState();
}

class _BookTicketScreenState extends State<BookTicketScreen> {
  int visitors = 1;
  DateTime selectedDate = DateTime.now().add(Duration(days: 1));

  @override
  Widget build(BuildContext context) {
    String priceText = widget.place['price'];
    int totalPrice = 0;
    if (priceText != 'Free') {
      totalPrice = int.parse(priceText) * visitors;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Book Ticket'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.place['name'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            Text(
              'Visit Date:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            InkWell(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime.now().add(Duration(days: 1)),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (picked != null && picked != selectedDate) {
                  setState(() {
                    selectedDate = picked;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.orange),
                    SizedBox(width: 12),
                    Text(
                      '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            Text(
              'Number of Visitors:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  onPressed:
                      visitors > 1
                          ? () {
                            setState(() {
                              visitors--;
                            });
                          }
                          : null,
                  icon: Icon(Icons.remove_circle, color: Colors.orange),
                ),
                Text(
                  '$visitors',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      visitors++;
                    });
                  },
                  icon: Icon(Icons.add_circle, color: Colors.orange),
                ),
              ],
            ),
            SizedBox(height: 20),

            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    totalPrice == 0 ? 'Free' : '₹$totalPrice',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),

            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  String ticketId =
                      'GT${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}';
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => TicketConfirmationScreen(
                            ticketId: ticketId,
                            placeName: widget.place['name'],
                            date: selectedDate,
                            visitors: visitors,
                            total: totalPrice,
                          ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: Text('Confirm Booking', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TicketConfirmationScreen extends StatelessWidget {
  final String ticketId;
  final String placeName;
  final DateTime date;
  final int visitors;
  final int total;

  TicketConfirmationScreen({
    required this.ticketId,
    required this.placeName,
    required this.date,
    required this.visitors,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Confirmed'),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 40),
            Icon(Icons.check_circle, size: 80, color: Colors.green),
            SizedBox(height: 20),
            Text(
              'Booking Successful!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 40),

            Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'E-Ticket',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    DetailRow('Ticket ID', ticketId),
                    DetailRow('Place', placeName),
                    DetailRow('Date', '${date.day}/${date.month}/${date.year}'),
                    DetailRow('Visitors', '$visitors'),
                    DetailRow('Total', total == 0 ? 'Free' : '₹$total'),
                  ],
                ),
              ),
            ),

            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: Text('Back to Home', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
          Text(value),
        ],
      ),
    );
  }
}

class TicketsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> sampleTickets = [
    {
      'id': 'GT123456',
      'place': 'Statue of Unity',
      'date': DateTime.now().add(Duration(days: 5)),
      'visitors': 2,
      'total': 300,
      'status': 'Active',
    },
    {
      'id': 'GT789012',
      'place': 'Gir National Park',
      'date': DateTime.now().subtract(Duration(days: 10)),
      'visitors': 1,
      'total': 300,
      'status': 'Used',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Tickets'), backgroundColor: Colors.orange),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: sampleTickets.length,
        itemBuilder: (context, index) {
          final ticket = sampleTickets[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ticket ${ticket['id']}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              ticket['status'] == 'Active'
                                  ? Colors.green
                                  : Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          ticket['status'],
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    ticket['place'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Date: ${ticket['date'].day}/${ticket['date'].month}/${ticket['date'].year}',
                  ),
                  Text('Visitors: ${ticket['visitors']}'),
                  Text(
                    'Amount: ₹${ticket['total']}',
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile'), backgroundColor: Colors.orange),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 40),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.orange[100],
              child: Icon(Icons.person, size: 60, color: Colors.orange),
            ),
            SizedBox(height: 20),
            Text(
              'Tourist User',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'user@gmail.com',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 40),

            Card(
              child: ListTile(
                leading: Icon(Icons.help, color: Colors.orange),
                title: Text('Help & Support'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: Text('Help & Support'),
                          content: Text(
                            'Contact us at support@gujarattourism.com',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                  );
                },
              ),
            ),

            Card(
              child: ListTile(
                leading: Icon(Icons.info, color: Colors.orange),
                title: Text('About App'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: Text('About'),
                          content: Text(
                            'Gujarat Tourist Guide v1.0\nExplore Gujarat with ease!',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
