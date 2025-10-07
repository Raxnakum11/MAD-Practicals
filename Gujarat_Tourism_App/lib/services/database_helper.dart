import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user.dart';
import '../models/tourist_place.dart';
import '../models/ticket.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'gujarat_tourism.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create users table
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        full_name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        phone_number TEXT NOT NULL,
        created_at INTEGER NOT NULL
      )
    ''');

    // Create tourist_places table
    await db.execute('''
      CREATE TABLE tourist_places(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        location TEXT NOT NULL,
        category TEXT NOT NULL,
        ticket_price REAL NOT NULL,
        image_url TEXT NOT NULL,
        rating REAL NOT NULL,
        opening_hours TEXT NOT NULL,
        best_time_to_visit TEXT NOT NULL
      )
    ''');

    // Create tickets table
    await db.execute('''
      CREATE TABLE tickets(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        ticket_id TEXT UNIQUE NOT NULL,
        user_id INTEGER NOT NULL,
        tourist_place_id INTEGER NOT NULL,
        tourist_place_name TEXT NOT NULL,
        visit_date INTEGER NOT NULL,
        number_of_visitors INTEGER NOT NULL,
        total_price REAL NOT NULL,
        booked_at INTEGER NOT NULL,
        status TEXT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id),
        FOREIGN KEY (tourist_place_id) REFERENCES tourist_places (id)
      )
    ''');

    // Insert sample tourist places
    await _insertSampleData(db);
  }

  Future<void> _insertSampleData(Database db) async {
    List<Map<String, dynamic>> samplePlaces = [
      {
        'name': 'Statue of Unity',
        'description':
            'World\'s tallest statue dedicated to Sardar Vallabhbhai Patel',
        'location': 'Kevadia, Narmada District',
        'category': 'Monument',
        'ticket_price': 150.0,
        'image_url': 'https://example.com/statue_of_unity.jpg',
        'rating': 4.8,
        'opening_hours': '8:00 AM - 6:00 PM',
        'best_time_to_visit': 'October to March',
      },
      {
        'name': 'Gir National Park',
        'description': 'Last refuge of Asiatic lions in the world',
        'location': 'Junagadh District',
        'category': 'Wildlife',
        'ticket_price': 300.0,
        'image_url': 'https://example.com/gir_national_park.jpg',
        'rating': 4.6,
        'opening_hours': '6:00 AM - 6:00 PM',
        'best_time_to_visit': 'December to March',
      },
      {
        'name': 'Rann of Kutch',
        'description': 'White salt desert famous for Rann Utsav festival',
        'location': 'Kutch District',
        'category': 'Desert',
        'ticket_price': 200.0,
        'image_url': 'https://example.com/rann_of_kutch.jpg',
        'rating': 4.7,
        'opening_hours': '24 Hours',
        'best_time_to_visit': 'November to February',
      },
      {
        'name': 'Somnath Temple',
        'description': 'One of the twelve Jyotirlinga shrines of Shiva',
        'location': 'Somnath, Gir Somnath District',
        'category': 'Temple',
        'ticket_price': 0.0,
        'image_url': 'https://example.com/somnath_temple.jpg',
        'rating': 4.5,
        'opening_hours': '6:00 AM - 9:00 PM',
        'best_time_to_visit': 'October to March',
      },
      {
        'name': 'Sabarmati Ashram',
        'description': 'Mahatma Gandhi\'s home for over a decade',
        'location': 'Ahmedabad',
        'category': 'Historical',
        'ticket_price': 10.0,
        'image_url': 'https://example.com/sabarmati_ashram.jpg',
        'rating': 4.4,
        'opening_hours': '8:30 AM - 6:30 PM',
        'best_time_to_visit': 'October to March',
      },
      {
        'name': 'Dwarka',
        'description': 'Ancient city and one of the Char Dham pilgrimage sites',
        'location': 'Dwarka District',
        'category': 'Temple',
        'ticket_price': 25.0,
        'image_url': 'https://example.com/dwarka.jpg',
        'rating': 4.3,
        'opening_hours': '5:00 AM - 9:00 PM',
        'best_time_to_visit': 'October to March',
      },
    ];

    for (var place in samplePlaces) {
      await db.insert('tourist_places', place);
    }
  }

  // User operations
  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<User?> getUserById(int id) async {
    final db = await database;
    final maps = await db.query('users', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  // Tourist place operations
  Future<List<TouristPlace>> getAllTouristPlaces() async {
    final db = await database;
    final maps = await db.query('tourist_places');
    return List.generate(maps.length, (i) {
      return TouristPlace.fromMap(maps[i]);
    });
  }

  Future<TouristPlace?> getTouristPlaceById(int id) async {
    final db = await database;
    final maps = await db.query(
      'tourist_places',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return TouristPlace.fromMap(maps.first);
    }
    return null;
  }

  Future<List<TouristPlace>> getTouristPlacesByCategory(String category) async {
    final db = await database;
    final maps = await db.query(
      'tourist_places',
      where: 'category = ?',
      whereArgs: [category],
    );
    return List.generate(maps.length, (i) {
      return TouristPlace.fromMap(maps[i]);
    });
  }

  // Ticket operations
  Future<int> insertTicket(Ticket ticket) async {
    final db = await database;
    return await db.insert('tickets', ticket.toMap());
  }

  Future<List<Ticket>> getTicketsByUserId(int userId) async {
    final db = await database;
    final maps = await db.query(
      'tickets',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'booked_at DESC',
    );
    return List.generate(maps.length, (i) {
      return Ticket.fromMap(maps[i]);
    });
  }

  Future<Ticket?> getTicketById(String ticketId) async {
    final db = await database;
    final maps = await db.query(
      'tickets',
      where: 'ticket_id = ?',
      whereArgs: [ticketId],
    );

    if (maps.isNotEmpty) {
      return Ticket.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateTicketStatus(String ticketId, String status) async {
    final db = await database;
    return await db.update(
      'tickets',
      {'status': status},
      where: 'ticket_id = ?',
      whereArgs: [ticketId],
    );
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
