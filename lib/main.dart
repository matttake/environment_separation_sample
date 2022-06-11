import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

// 本番かリリースかを判断するには bool.fromEnvironment('dart.vm.product')を使う。
// よりわかりやすくするためにラップして使っている。
bool isRelease() {
  bool _bool;
  // release環境ならtrue
  const bool.fromEnvironment('dart.vm.product') ? _bool = true : _bool = false;
  return _bool;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(
          // isRelease()の戻り値がture(release)なら"リリース"
          'firestoreの動作確認\n(${isRelease() ? 'リリース' : 'デバック'}モード)'))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(isRelease() ? "リリースモード" : "デバッグモード",
                style: Theme.of(context).textTheme.titleLarge),
            const NewWidget(),
          ],
        ),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('check').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          default:
            return Text('取得した値: ${snapshot.data!.docs[0]['name']}');
        }
      },
    );
  }
}
