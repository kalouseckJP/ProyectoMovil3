// ignore_for_file: avoid_print

import 'dart:async';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'Main',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class SecondPage extends StatefulWidget {
  const SecondPage(
      {super.key, required this.emailText, required this.passwordText});
  final String emailText;
  final String passwordText;

  @override
  State<SecondPage> createState() => _SecondPage();
}

class _MyHomePageState extends State<MyHomePage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late DatabaseReference _profesionalRef;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    final database = FirebaseDatabase.instance;
    _profesionalRef = database.ref('clinica/profesional');
  }

  Future<bool> _printValor() async {
    num i = 1;
    while (true) {
      // Recibe los datos desde la base de datos.
      DataSnapshot dataEmail = await _profesionalRef.child('$i/email').get();
      DataSnapshot dataPassword = await _profesionalRef.child('$i/clave').get();
      // Verificador de datos.
      if ((emailController.text == dataEmail.value) &&
          (passwordController.text == dataPassword.value)) {
        return true;
      } else if (!dataEmail.exists) {
        return true;
      } else {
        i++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromRGBO(189, 228, 250, 1),
                Color.fromRGBO(38, 88, 217, 1),
              ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'img/logoClinica.png',
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 50,
                  left: 10,
                  right: 10,
                ),
                child: Column(
                  children: <Widget>[
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    TextField(
                      controller: emailController,
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Ingresar Email',
                        filled: true,
                        fillColor: Color.fromRGBO(222, 237, 239, 1),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: Column(
                        children: <Widget>[
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Contraseña',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Ingresar Contraseña',
                              filled: true,
                              fillColor: Color.fromRGBO(222, 237, 239, 1),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 100,
                ),
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Color.fromRGBO(75, 75, 75, 1)),
                  ),
                  onPressed: () async {
                    if (await _printValor()) {
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SecondPage(
                            emailText: emailController.text,
                            passwordText: passwordController.text,
                          ),
                        ),
                      );
                      print('Datos Confirmados');
                    } else {
                      print('Datos Incorrectos');
                    }
                  },
                  child: const SizedBox(
                    width: 200,
                    height: 100,
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Continuar',
                            style: TextStyle(
                              color: Color.fromRGBO(242, 248, 241, 1),
                              fontSize: 32,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Color.fromRGBO(242, 248, 241, 1),
                            size: 36,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SecondPage extends State<SecondPage> with TickerProviderStateMixin {
  late final TabController _tabController;
  late DatabaseReference _citaRef;

  Future<void> init() async {
    final database = FirebaseDatabase.instance;
    _citaRef = database.ref('clinica/cita');
  }

  @override
  void initState() {
    init();
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(22),
              bottomRight: Radius.circular(22),
            ),
          ),
          backgroundColor: const Color.fromRGBO(189, 228, 250, 1),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: SizedBox(
              width: double.infinity,
              height: 100,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: Image.asset(
                          'img/logoClinica.png',
                          height: 50,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: AlignmentDirectional.centerEnd,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyHomePage(
                                    title: 'Flutter Demo Home Page'),
                              ),
                            );
                          },
                          child: const Text('Cerrar Sesion'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 50,
              width: double.infinity,
              child: TabBar(
                unselectedLabelStyle: const TextStyle(color: Colors.amber),
                indicator: UnderlineTabIndicator(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: const BorderSide(
                    width: 50,
                    color: Color.fromRGBO(188, 201, 235, 1),
                  ),
                ),
                dividerHeight: 0,
                controller: _tabController,
                tabs: const <Widget>[
                  SizedBox(
                    width: 100,
                    child: Tab(
                      child: Text(
                        'Administrar',
                        style: TextStyle(
                          color: Color.fromRGBO(75, 75, 75, 1),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Tab(
                      child: Text(
                        'Detalles',
                        style: TextStyle(
                          color: Color.fromRGBO(75, 75, 75, 1),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Tab(
                      child: Text(
                        'Pacientes',
                        style: TextStyle(
                          color: Color.fromRGBO(75, 75, 75, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.6,
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 50,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(14)),
                                color: Color.fromRGBO(189, 228, 250, 1)),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Horas Agendadas',
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1),
                              ),
                              child: Column(
                                children: [
                                  // Titulos Tabla
                                  Container(
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(110, 140, 220, 1),
                                      border: BorderDirectional(
                                        bottom: BorderSide(width: 1),
                                      ),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          height: 50,
                                          width: 40,
                                          decoration: const BoxDecoration(
                                            border: BorderDirectional(
                                              end: BorderSide(width: 1),
                                            ),
                                          ),
                                          child: const Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Id',
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 50,
                                            decoration: const BoxDecoration(
                                              border: BorderDirectional(
                                                end: BorderSide(width: 1),
                                              ),
                                            ),
                                            child: const Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Fecha',
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 50,
                                            decoration: const BoxDecoration(
                                              border: BorderDirectional(
                                                end: BorderSide(width: 1),
                                              ),
                                            ),
                                            child: const Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Hora',
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 50,
                                            decoration: const BoxDecoration(
                                              border: BorderDirectional(
                                                end: BorderSide(width: 1),
                                              ),
                                            ),
                                            child: const Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Sala',
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 50,
                                          width: 70,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Ocupado',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Fila 1
                                  Flexible(
                                    child: SizedBox(
                                      height: double.infinity,
                                      child: FirebaseAnimatedList(
                                        query: _citaRef,
                                        itemBuilder: (context, snapshot,
                                            animation, index) {
                                          return SizeTransition(
                                            sizeFactor: animation,
                                            child: Column(
                                              children: <Widget>[
                                                if (index % 2 == 0 ||
                                                    index == 0)
                                                  Container(
                                                    height: 50,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          188, 201, 235, 1),
                                                      border: Border(
                                                        bottom: BorderSide(
                                                            width: 1),
                                                      ),
                                                    ),
                                                    child: TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        foregroundColor:
                                                            Colors.black,
                                                        padding:
                                                            EdgeInsets.zero,
                                                        shape:
                                                            BeveledRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(0),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        print(index);
                                                      },
                                                      child: Row(
                                                        children: <Widget>[
                                                          Container(
                                                            height: 50,
                                                            width: 40,
                                                            decoration:
                                                                const BoxDecoration(
                                                              border: Border(
                                                                right:
                                                                    BorderSide(
                                                                        width:
                                                                            1),
                                                              ),
                                                            ),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                  '${snapshot.child('id').value}'),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              height: 50,
                                                              width: 40,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                border: Border(
                                                                  right:
                                                                      BorderSide(
                                                                          width:
                                                                              1),
                                                                ),
                                                              ),
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                    '${snapshot.child('fecha').value}'),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              height: 50,
                                                              width: 40,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                border: Border(
                                                                  right:
                                                                      BorderSide(
                                                                          width:
                                                                              1),
                                                                ),
                                                              ),
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                    '${snapshot.child('hora').value}'),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              height: 50,
                                                              width: 40,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                border: Border(
                                                                  right:
                                                                      BorderSide(
                                                                          width:
                                                                              1),
                                                                ),
                                                              ),
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                    '${snapshot.child('sala').value}'),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 50,
                                                            width: 70,
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Checkbox(
                                                                value: snapshot
                                                                    .child(
                                                                        'ocupado')
                                                                    .exists,
                                                                onChanged: null,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                if (index % 2 != 0)
                                                  Container(
                                                    height: 50,
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                            width: 1),
                                                      ),
                                                    ),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        print(index);
                                                      },
                                                      style:
                                                          TextButton.styleFrom(
                                                        foregroundColor:
                                                            Colors.black,
                                                        padding:
                                                            EdgeInsets.zero,
                                                        shape:
                                                            BeveledRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(0),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Container(
                                                            height: 50,
                                                            width: 40,
                                                            decoration:
                                                                const BoxDecoration(
                                                              border: Border(
                                                                right:
                                                                    BorderSide(
                                                                        width:
                                                                            1),
                                                              ),
                                                            ),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                  '${snapshot.child('id').value}'),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              height: 50,
                                                              width: 40,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                border: Border(
                                                                  right:
                                                                      BorderSide(
                                                                          width:
                                                                              1),
                                                                ),
                                                              ),
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                    '${snapshot.child('fecha').value}'),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              height: 50,
                                                              width: 40,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                border: Border(
                                                                  right:
                                                                      BorderSide(
                                                                          width:
                                                                              1),
                                                                ),
                                                              ),
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                    '${snapshot.child('hora').value}'),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              height: 50,
                                                              width: 40,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                border: Border(
                                                                  right:
                                                                      BorderSide(
                                                                          width:
                                                                              1),
                                                                ),
                                                              ),
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                    '${snapshot.child('sala').value}'),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 50,
                                                            width: 70,
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Checkbox(
                                                                value: snapshot
                                                                    .child(
                                                                        'ocupado')
                                                                    .exists,
                                                                onChanged: null,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(),
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
