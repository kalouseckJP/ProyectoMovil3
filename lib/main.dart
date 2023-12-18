import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:clinica_app3/second_page.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool datosErroneos = false;

  final db = FirebaseFirestore.instance;

  Future<bool> verificarCredenciales(emailIngresado, passwordIngresada) async {
    bool correcto = false;
    await db.collection("profesional").where("email", isEqualTo: "${emailIngresado.text}").where("clave", isEqualTo: "${passwordIngresada.text}").get().then(
      (querySnapshot) {
        if (querySnapshot.docs.isEmpty) {
          datosErroneos = false;
          correcto = false;
          return correcto;
        } else {
          datosErroneos = true;
          correcto = true;
          return correcto;
        }
      },
    );
    return correcto;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
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
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(),
                      labelText: 'Ingresar Email',
                      filled: true,
                      fillColor: Color.fromRGBO(222, 237, 239, 1),
                      prefixIcon: Icon(Icons.email),
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
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(),
                            labelText: 'Ingresar Contraseña',
                            filled: true,
                            fillColor: Color.fromRGBO(222, 237, 239, 1),
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (datosErroneos)
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
                        'Datos erroneos',
                        style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 100,
              ),
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(75, 75, 75, 1)),
                ),
                onPressed: () async {
                  if ((await verificarCredenciales(emailController, passwordController)) == true) {
                    datosErroneos = false;
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
                  } else {
                    setState(
                      () {
                        datosErroneos = true;
                      },
                    );
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
    );
  }
}
