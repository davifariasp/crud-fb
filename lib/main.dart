import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_teste/firestore.dart';
import 'package:fb_teste/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'components/card_user.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //configurando tipo de plataforma
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      home: const MyHomePage(title: 'Cadastro Usuários'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<User> usuarios = [];
  int countUsers = 0;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await carregarDB();
  }

  carregarDB() async {
    List<User> usersSnapshot = [];

    final docRef = FirebaseFirestore.instance.collection("users").withConverter(
        fromFirestore: User.fromFirestore,
        toFirestore: (User user, _) => user.toFirestore());

    await docRef.get().then(
      (querySnapshot) {
        debugPrint("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          User user = docSnapshot.data();
          user.id = docSnapshot.id;
          usersSnapshot.add(user);
          debugPrint(
              '${docSnapshot.id} => ${user.name}, ${user.age}, ${user.createOn}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );

    setState(() {
      usuarios = usersSnapshot;
      countUsers = usuarios.length;
    });
  }

  adicionar(String name, String age) async {
    DateTime data = DateTime.now();
    final datapt = DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY, 'pt_Br')
        .format(data);

    User user = User(
      name: name,
      age: int.parse(age),
      createOn: datapt.toString(),
    );

    final docRef = FirebaseFirestore.instance.collection("users").withConverter(
        fromFirestore: User.fromFirestore,
        toFirestore: (User user, options) => user.toFirestore());

    await docRef.add(user).then((DocumentReference doc) =>
        debugPrint("DocumentSnapshot added with ID: ${doc.id}"));
  }

  atualizar(id, name, age) async {
    await FirebaseFirestore.instance.collection('users').doc(id).update({
      "name": name,
      "age": int.parse(age),
    }).then(
      (doc) => debugPrint("Document updated"),
      onError: (e) => debugPrint("Error updating document $e"),
    );
    await carregarDB();
  }

  delete(id) async {
    await FirebaseFirestore.instance.collection('users').doc(id).delete().then(
          (doc) => debugPrint("Document deleted"),
          onError: (e) => debugPrint("Error updating document $e"),
        );

    await carregarDB();
  }

  @override
  Widget build(BuildContext context) {
    void showBottomSheetAdd() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (_) => Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  height: 250,
                  padding: const EdgeInsets.all(15),
                  child: Column(children: [
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "Name"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _ageController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "Age"),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () async {
                          adicionar(_nameController.text, _ageController.text);

                          _nameController.text = "";
                          _ageController.text = "";

                          Navigator.of(context).pop();

                          await carregarDB();
                        },
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(
                                top: 5, left: 25, bottom: 5, right: 25),
                            foregroundColor: Colors.white,
                            backgroundColor: Theme.of(context).primaryColor),
                        child: const Text("Enviar"))
                  ]),
                ),
              ));
    }

    void showBottomSheetUpdate(id, name, age) {
      _nameController.text = name!;
      _ageController.text = (age).toString();

      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (_) => Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  height: 250,
                  padding: const EdgeInsets.all(15),
                  child: Column(children: [
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "Name"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _ageController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "Age"),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () async {
                          atualizar(
                              id, _nameController.text, _ageController.text);

                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(
                                top: 5, left: 25, bottom: 5, right: 25),
                            foregroundColor: Colors.white,
                            backgroundColor: Theme.of(context).primaryColor),
                        child: const Text("Enviar"))
                  ]),
                ),
              ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.brown[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              flex: 1,
              child: ListView.separated(
                  padding: const EdgeInsets.all(10),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return CardUser(
                      user: usuarios[index],
                      delete: delete,
                      atualizar: atualizar,
                      bsUpdate: showBottomSheetUpdate,
                    );
                  },
                  separatorBuilder: ((context, index) {
                    return const Divider(
                      //color: Color(0xffDEDEDE),
                      height: 10,
                    );
                  }),
                  itemCount: usuarios.length),
            )
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBottomSheetAdd(),
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
