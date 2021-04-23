
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';


final firebaseURL = 'https://virtulab-9b909.firebaseio.com/'; //firebase link
//'https://virtulab-9b909.firebaseio.com/student' // to create a folder in ur firebase named 'student'


final firebaseref = FirebaseDatabase.instance.reference();
final firebasePersistence = FirebaseDatabase.instance.setPersistenceEnabled(true);
final auth = FirebaseAuth.instance;
final authPersistence = auth.setPersistence(Persistence.LOCAL);

// Future<void> get firebase async {
//   final FirebaseApp app = await Firebase.initializeApp(
//       name: 'virtulab',
//       options: Platform.isAndroid || Platform.isIOS
//           ? FirebaseOptions(
//               apiKey: '', appId: '', messagingSenderId: '', projectId: '')
//           : FirebaseOptions(
//               apiKey: '', appId: '', messagingSenderId: '', projectId: ''));

//   final FirebaseDatabase _db = FirebaseDatabase();
// }

// Future<Database> get database async {
//   Directory documentsDirectory = await getApplicationDocumentsDirectory();
//   String path = join(documentsDirectory.path, "asset_virtulabDB.db");

//   ByteData data = await rootBundle.load(join('assets', 'virtulbDB.db'));
//   List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

//   await new File(path).writeAsBytes(bytes);

//   Directory appDocDir = await getApplicationDocumentsDirectory();
//   String databasePath = join(appDocDir.path, 'asset_virtulabDB.db');
//   Database _db = await openDatabase(databasePath);
//   return _db;
// }

//sqflite connection attempt
// Future<Database> get database async {
//   //get database directory
//   var dbpath = await getDatabasesPath();
//   var path = join(dbpath, 'virtulabDB.db');

//   //does database exist?
//   var exists = await databaseExists(dbpath);
//   if (!exists) {
//     // Should happen only the first time you launch your application
//     print("Creating new copy from asset");

//     // Make sure the directory exists
//     try {
//       await Directory(dirname(dbpath)).create(recursive: true);
//     } catch (_) {}

//     // Copy from asset
//     ByteData data = await rootBundle.load(join("assets", "virtulabDB.db"));
//     List<int> bytes =
//         data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

//     // Write and flush the bytes written
//     await File(dbpath).writeAsBytes(bytes, flush: true);
//   } else {
//     print('opening an existing database');
//   }

//   _onConfigure(Database db) async {
//     // Add support for cascade delete
//     await db.execute("PRAGMA foreign_keys = ON");
//   }

//   _onCreate(Database db, int version) async {
//     // Database is created, create the table
//     await db.execute("CREATE TABLE Test (id INTEGER PRIMARY KEY, value TEXT)");
//     // populate data
//     await db.insert(
//       'Test',
//       {'id test': 'value test'},
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   //open database
//   Database dbase = await openDatabase(path,
//       version: 1, onConfigure: _onConfigure, onCreate: _onCreate);

//   return dbase;
// }
