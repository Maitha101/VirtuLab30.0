
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firebaseURL = 'https://virtulab-9b909.firebaseio.com/'; //firebase link
//'https://virtulab-9b909.firebaseio.com/student' // to create a folder in ur firebase named 'student'


final firebaseref = FirebaseDatabase.instance.reference();
final firebasePersistence = FirebaseDatabase.instance.setPersistenceEnabled(true);
final auth = FirebaseAuth.instance;
final authPersistence = auth.setPersistence(Persistence.LOCAL);
