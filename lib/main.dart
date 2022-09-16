import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_app/pages/auth_page.dart';
import 'package:firebase_app/pages/firestore_page.dart';
import 'package:firebase_app/pages/functions_page.dart';
import 'package:firebase_app/pages/storage_page.dart';
import 'package:firebase_app/widgets/custom_bottom_app_bar.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAcc96bc47hzeOUVu5smhQXNAELAA7wFFg",
      appId: "fir-app-9c681",
      messagingSenderId: "661342886164",
      projectId: "fir-app-9c681",
      authDomain: "fir-app-9c681.firebaseapp.com",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _State();
}

class _State extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text("Firebase Demo"))),
        bottomNavigationBar: const CustomBottomAppBar(),
        body: Center(
            child: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              color: Colors.grey.shade300,
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AuthPage()));
                  },
                  child: const Text("Authentication"))),
          Container(height: 10),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const FirestorePage()));
                  },
                  child: const Text("Cloud Firestore"))),
          Container(height: 10),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const FunctionsPage()));
                  },
                  child: const Text("Cloud Functions"))),
          Container(height: 10),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const StoragePage()));
                  },
                  child: const Text("Storage"))),
        ])));
  }
}

// final db = FirebaseFirestore.instance;
// String? value;

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: FloatingActionButton(
//         onPressed: () {
//           // When the User clicks on the button, display a BottomSheet
//           showModalBottomSheet(
//             context: context,
//             builder: (context) {
//               return showBottomSheet(context, false, null);
//             },
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//       appBar: AppBar(
//         title: const Text('Todo App'),
//         centerTitle: true,
//       ),
//       body: StreamBuilder(
//         // Reading Items form our Database Using the StreamBuilder widget
//         stream: db.collection('todos').snapshots(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return ListView.builder(
//             itemCount: snapshot.data?.docs.length,
//             itemBuilder: (context, int index) {
//               DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
//               return ListTile(
//                 title: Text(documentSnapshot['todo']),
//                 onTap: () {
//                   // Here We Will Add The Update Feature and passed the value 'true' to the is update
//                   // feature.
//                   showModalBottomSheet(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return showBottomSheet(context, true, documentSnapshot);
//                     },
//                   );
//                 },
//                 trailing: IconButton(
//                   icon: const Icon(
//                     Icons.delete_outline,
//                   ),
//                   onPressed: () {
//                     // Here We Will Add The Delete Feature
//                     db.collection('todos').doc(documentSnapshot.id).delete();
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// showBottomSheet(
//     BuildContext context, bool isUpdate, DocumentSnapshot? documentSnapshot) {
//   // Added the isUpdate argument to check if our item has been updated
//   return Padding(
//     padding: const EdgeInsets.only(top: 20),
//     child: Column(
//       children: [
//         SizedBox(
//           width: MediaQuery.of(context).size.width * 0.9,
//           child: TextField(
//             decoration: InputDecoration(
//               border: const OutlineInputBorder(),
//               // Used a ternary operator to check if isUpdate is true then display
//               // Update Todo.
//               labelText: isUpdate ? 'Update Todo' : 'Add Todo',
//               hintText: 'Enter An Item',
//             ),
//             onChanged: (String _val) {
//               // Storing the value of the text entered in the variable value.
//               value = _val;
//             },
//           ),
//         ),
//         TextButton(
//             style: ButtonStyle(
//               backgroundColor:
//                   MaterialStateProperty.all(Colors.lightBlueAccent),
//             ),
//             onPressed: () {
//               // Check to see if isUpdate is true then update the value else add the value
//               if (isUpdate) {
//                 db.collection('todos').doc(documentSnapshot?.id).update({
//                   'todo': value,
//                 });
//               } else {
//                 db.collection('todos').add({'todo': value});
//               }
//               Navigator.pop(context);
//             },
//             child: isUpdate
//                 ? const Text(
//                     'UPDATE',
//                     style: TextStyle(color: Colors.white),
//                   )
//                 : const Text('ADD', style: TextStyle(color: Colors.white))),
//       ],
//     ),
//   );
// }