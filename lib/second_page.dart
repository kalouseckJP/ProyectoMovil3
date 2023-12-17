// ignore_for_file: use_build_context_synchronously

import 'package:clinica_app3/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage(
      {super.key, required this.emailText, required this.passwordText});
  final String emailText;
  final String passwordText;
  @override
  State<SecondPage> createState() => _SecondPage();
}

class _SecondPage extends State<SecondPage> with TickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();
  final TextEditingController _editarFechaController = TextEditingController();
  final TextEditingController _editarHoraController = TextEditingController();
  final TextEditingController _detallesController = TextEditingController();

  final db = FirebaseFirestore.instance;

  GlobalKey globalKey = GlobalKey();

  String pacienteNombre = 'null';
  String pacienteRut = 'null';
  String pacienteSala = 'null';

  bool isExpanded = false;
  bool buttonPressed = false;
  Icon nombreIcon = const Icon(Icons.keyboard_arrow_down_rounded);

  int detalleSeleccionado = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<String> _seleccionarFecha() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025, 12, 31),
    );
    if (_picked != null) {
      setState(
        () {
          _fechaController.text = _picked.toString().split(" ")[0];
        },
      );
      print(_fechaController.text);
      return _fechaController.text;
    }
    return _fechaController.text;
  }

  Future<String> _editarFecha() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025, 12, 31),
    );
    if (_picked != null) {
      setState(
        () {
          _editarFechaController.text = _picked.toString().split(" ")[0];
        },
      );
      print(_editarFechaController.text);
      return _editarFechaController.text;
    }
    return _editarFechaController.text;
  }

  Future<String> _seleccionarHora() async {
    TimeOfDay? _picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (_picked != null) {
      setState(
        () {
          _horaController.text =
              '${_picked.hour.toString().padLeft(2, '0')}:${_picked.minute.toString().padLeft(2, '0')}';
        },
      );
      print(_horaController.text);
      return _horaController.text;
    }
    return _horaController.text;
  }

  Future<String> _editarHora() async {
    TimeOfDay? _picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (_picked != null) {
      setState(
        () {
          _editarHoraController.text =
              '${_picked.hour.toString().padLeft(2, '0')}:${_picked.minute.toString().padLeft(2, '0')}';
        },
      );
      print(_editarHoraController.text);
      return _editarHoraController.text;
    }
    return _editarHoraController.text;
  }

  Future<void> addCitaToFirestore(Map<String, dynamic> citaData) async {
    try {
      await db.collection('citas').doc().set(citaData);
      print('Cita added to Firestore successfully!');
    } catch (e) {
      print('Error adding cita to Firestore: $e');
    }
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
            preferredSize: Size(MediaQuery.of(context).size.width, 100),
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
                                        bottom: BorderSide(
                                          width: 2,
                                        ),
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
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: StreamBuilder(
                                        stream: db
                                            .collection('citas')
                                            .orderBy('id')
                                            .where('prof_rut',
                                                isEqualTo: widget.emailText)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          // If the connection is done and there is no error, display the data
                                          var tasks = snapshot.data?.docs;
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child: SizedBox(
                                                  width: 50,
                                                  height: 50,
                                                  child:
                                                      CircularProgressIndicator()),
                                            );
                                          }
                                          return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            padding: const EdgeInsets.all(0),
                                            itemCount: tasks?.length,
                                            itemBuilder: (context, index) {
                                              var task = tasks?[index];
                                              return ListTile(
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                visualDensity:
                                                    const VisualDensity(
                                                        horizontal: 0,
                                                        vertical: 0),
                                                minLeadingWidth: 0,
                                                minVerticalPadding: 0,
                                                subtitle: Column(
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
                                                          style: TextButton
                                                              .styleFrom(
                                                            foregroundColor:
                                                                Colors.black,
                                                            padding:
                                                                EdgeInsets.zero,
                                                            shape:
                                                                BeveledRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0),
                                                            ),
                                                          ),
                                                          onPressed: () async {
                                                            var _items = [
                                                              '1',
                                                              '2',
                                                              '3',
                                                              '4',
                                                              '5',
                                                              '6',
                                                              '7',
                                                              '8',
                                                            ];
                                                            var dropDownValue =
                                                                '1';
                                                            var datosEditar = await db
                                                                .collection(
                                                                    'citas')
                                                                .where('id',
                                                                    isEqualTo:
                                                                        task?[
                                                                            'id'])
                                                                .get();

                                                            _editarFechaController
                                                                    .text =
                                                                datosEditar
                                                                    .docs[0]
                                                                    .get(
                                                                        'fecha');

                                                            _editarHoraController
                                                                    .text =
                                                                datosEditar
                                                                    .docs[0]
                                                                    .get(
                                                                        'hora');

                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return StatefulBuilder(
                                                                  builder: (BuildContext
                                                                          context,
                                                                      StateSetter
                                                                          setState) {
                                                                    return Dialog(
                                                                      child:
                                                                          Container(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                20,
                                                                            vertical:
                                                                                30),
                                                                        child:
                                                                            ListView(
                                                                          shrinkWrap:
                                                                              true,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    'Cita ${task?['id']}',
                                                                                    textAlign: TextAlign.center,
                                                                                    style: const TextStyle(
                                                                                      fontSize: 28,
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  child: IconButton(
                                                                                    onPressed: () async {
                                                                                      var idABorrar = await db.collection('citas').where('id', isEqualTo: task?['id']).get();

                                                                                      String idFinal = idABorrar.docs[0].id;
                                                                                      showDialog(
                                                                                        context: context,
                                                                                        builder: (BuildContext context) {
                                                                                          return StatefulBuilder(
                                                                                            builder: (BuildContext context, StateSetter setState) {
                                                                                              return Dialog(
                                                                                                child: Container(
                                                                                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                                                                                                  child: ListView(
                                                                                                    shrinkWrap: true,
                                                                                                    children: [
                                                                                                      const SizedBox(
                                                                                                        height: 50,
                                                                                                        width: double.infinity,
                                                                                                        child: Text(
                                                                                                          'Confirmar',
                                                                                                          textAlign: TextAlign.center,
                                                                                                          style: TextStyle(
                                                                                                            fontSize: 24,
                                                                                                            fontWeight: FontWeight.w500,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Row(
                                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                                        children: <Widget>[
                                                                                                          Expanded(
                                                                                                            child: Container(
                                                                                                              height: 70,
                                                                                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                                                              child: ElevatedButton(
                                                                                                                style: ButtonStyle(
                                                                                                                  backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(110, 140, 220, 1)),
                                                                                                                ),
                                                                                                                child: const Text(
                                                                                                                  'Cancelar',
                                                                                                                  style: TextStyle(
                                                                                                                    fontSize: 24,
                                                                                                                    color: Color.fromRGBO(242, 248, 241, 1),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                onPressed: () => Navigator.pop(context),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Expanded(
                                                                                                            child: Container(
                                                                                                              height: 70,
                                                                                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                                                              child: ElevatedButton(
                                                                                                                style: ButtonStyle(
                                                                                                                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 220, 112, 110)),
                                                                                                                ),
                                                                                                                child: const Text(
                                                                                                                  'Eliminar',
                                                                                                                  style: TextStyle(
                                                                                                                    fontSize: 24,
                                                                                                                    color: Color.fromRGBO(242, 248, 241, 1),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                onPressed: () {
                                                                                                                  Navigator.pop(context);
                                                                                                                  Navigator.pop(context);
                                                                                                                  db.collection('citas').doc(idFinal).delete();
                                                                                                                },
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              );
                                                                                            },
                                                                                          );
                                                                                        },
                                                                                      );
                                                                                    },
                                                                                    icon: const Icon(
                                                                                      IconData(
                                                                                        0xf4c4,
                                                                                        fontFamily: CupertinoIcons.iconFont,
                                                                                        fontPackage: CupertinoIcons.iconFontPackage,
                                                                                      ),
                                                                                      size: 32,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 70,
                                                                              child: Align(
                                                                                alignment: Alignment.bottomLeft,
                                                                                child: Text('Fecha'),
                                                                              ),
                                                                            ),
                                                                            TextField(
                                                                              controller: _editarFechaController,
                                                                              decoration: const InputDecoration(
                                                                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                                                                                labelText: 'Fecha',
                                                                                suffixIcon: Icon(Icons.calendar_today),
                                                                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(110, 140, 220, 1))),
                                                                              ),
                                                                              readOnly: true,
                                                                              onTap: () {
                                                                                _editarFecha();
                                                                              },
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 70,
                                                                              width: double.infinity,
                                                                              child: Align(
                                                                                alignment: Alignment.bottomLeft,
                                                                                child: Text(
                                                                                  'Hora',
                                                                                  style: TextStyle(
                                                                                    fontSize: 18,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            TextField(
                                                                              controller: _editarHoraController,
                                                                              decoration: const InputDecoration(
                                                                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                                                                                labelText: 'Hora',
                                                                                suffixIcon: Icon(Icons.access_time),
                                                                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                                focusedBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(
                                                                                    color: Color.fromRGBO(110, 140, 220, 1),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              readOnly: true,
                                                                              onTap: () {
                                                                                _editarHora();
                                                                              },
                                                                            ),
                                                                            Container(
                                                                              margin: const EdgeInsets.only(top: 40),
                                                                              child: Row(
                                                                                children: [
                                                                                  const SizedBox(
                                                                                    child: Text(
                                                                                      'Sala',
                                                                                      style: TextStyle(
                                                                                        fontSize: 18,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(
                                                                                        border: Border.all(
                                                                                          width: 1,
                                                                                        ),
                                                                                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                                                                                      ),
                                                                                      margin: const EdgeInsets.only(left: 20),
                                                                                      child: Align(
                                                                                        alignment: Alignment.centerRight,
                                                                                        child: DropdownButton(
                                                                                          underline: const SizedBox(),
                                                                                          items: _items
                                                                                              .map(
                                                                                                (String item) => DropdownMenuItem(
                                                                                                  value: item,
                                                                                                  child: Text(item),
                                                                                                ),
                                                                                              )
                                                                                              .toList(),
                                                                                          onChanged: (String? newValue) {
                                                                                            setState(
                                                                                              () {
                                                                                                dropDownValue = newValue!;
                                                                                              },
                                                                                            );
                                                                                          },
                                                                                          value: dropDownValue,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              height: 50,
                                                                              margin: const EdgeInsets.only(top: 20),
                                                                              child: ElevatedButton(
                                                                                style: ButtonStyle(
                                                                                  backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(110, 140, 220, 1)),
                                                                                ),
                                                                                onPressed: () async {
                                                                                  var idABorrar = await db.collection('citas').where('id', isEqualTo: task?['id']).get();
                                                                                  String idFinal = idABorrar.docs[0].id;
                                                                                  db.collection('citas').doc(idFinal).update({
                                                                                    'fecha': _editarFechaController.text.split('-').reversed.toString().replaceAll(RegExp(r'\('), '').replaceAll(RegExp(r'\)'), '').replaceAll(RegExp(r', '), '/'),
                                                                                    'hora': _editarHoraController.text,
                                                                                    'sala': dropDownValue,
                                                                                  });
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                child: Container(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                                  child: const Text(
                                                                                    'Confirmar',
                                                                                    style: TextStyle(
                                                                                      fontSize: 24,
                                                                                      color: Color.fromRGBO(242, 248, 241, 1),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: Row(
                                                            children: <Widget>[
                                                              Container(
                                                                height: 50,
                                                                width: 40,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  border:
                                                                      Border(
                                                                    right: BorderSide(
                                                                        width:
                                                                            1),
                                                                  ),
                                                                ),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    '${task?['id']}',
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  height: 50,
                                                                  width: 40,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      right: BorderSide(
                                                                          width:
                                                                              1),
                                                                    ),
                                                                  ),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        '${task?['fecha']}'),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  height: 50,
                                                                  width: 40,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      right: BorderSide(
                                                                          width:
                                                                              1),
                                                                    ),
                                                                  ),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        '${task?['hora']}'),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  height: 50,
                                                                  width: 40,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      right: BorderSide(
                                                                          width:
                                                                              1),
                                                                    ),
                                                                  ),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        '${task?['sala']}'),
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
                                                                  child:
                                                                      Checkbox(
                                                                    value: task?[
                                                                        'ocupado'],
                                                                    onChanged:
                                                                        null,
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
                                                          style: TextButton
                                                              .styleFrom(
                                                            foregroundColor:
                                                                Colors.black,
                                                            padding:
                                                                EdgeInsets.zero,
                                                            shape:
                                                                BeveledRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0),
                                                            ),
                                                          ),
                                                          onPressed: () async {
                                                            var _items = [
                                                              '1',
                                                              '2',
                                                              '3',
                                                              '4',
                                                              '5',
                                                              '6',
                                                              '7',
                                                              '8',
                                                            ];
                                                            var dropDownValue =
                                                                '1';
                                                            var datosEditar = await db
                                                                .collection(
                                                                    'citas')
                                                                .where('id',
                                                                    isEqualTo:
                                                                        task?[
                                                                            'id'])
                                                                .get();

                                                            _editarFechaController
                                                                    .text =
                                                                datosEditar
                                                                    .docs[0]
                                                                    .get(
                                                                        'fecha');

                                                            _editarHoraController
                                                                    .text =
                                                                datosEditar
                                                                    .docs[0]
                                                                    .get(
                                                                        'hora');

                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return StatefulBuilder(
                                                                  builder: (BuildContext
                                                                          context,
                                                                      StateSetter
                                                                          setState) {
                                                                    return Dialog(
                                                                      child:
                                                                          Container(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                20,
                                                                            vertical:
                                                                                30),
                                                                        child:
                                                                            ListView(
                                                                          shrinkWrap:
                                                                              true,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    'Cita ${task?['id']}',
                                                                                    textAlign: TextAlign.center,
                                                                                    style: const TextStyle(
                                                                                      fontSize: 28,
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  child: IconButton(
                                                                                    onPressed: () async {
                                                                                      var idABorrar = await db.collection('citas').where('id', isEqualTo: task?['id']).get();

                                                                                      String idFinal = idABorrar.docs[0].id;
                                                                                      showDialog(
                                                                                        context: context,
                                                                                        builder: (BuildContext context) {
                                                                                          return StatefulBuilder(
                                                                                            builder: (BuildContext context, StateSetter setState) {
                                                                                              return Dialog(
                                                                                                child: Container(
                                                                                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                                                                                                  child: ListView(
                                                                                                    shrinkWrap: true,
                                                                                                    children: [
                                                                                                      const SizedBox(
                                                                                                        height: 50,
                                                                                                        width: double.infinity,
                                                                                                        child: Text(
                                                                                                          'Confirmar',
                                                                                                          textAlign: TextAlign.center,
                                                                                                          style: TextStyle(
                                                                                                            fontSize: 24,
                                                                                                            fontWeight: FontWeight.w500,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Row(
                                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                                        children: <Widget>[
                                                                                                          Expanded(
                                                                                                            child: Container(
                                                                                                              height: 70,
                                                                                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                                                              child: ElevatedButton(
                                                                                                                style: ButtonStyle(
                                                                                                                  backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(110, 140, 220, 1)),
                                                                                                                ),
                                                                                                                child: const Text(
                                                                                                                  'Cancelar',
                                                                                                                  style: TextStyle(
                                                                                                                    fontSize: 24,
                                                                                                                    color: Color.fromRGBO(242, 248, 241, 1),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                onPressed: () => Navigator.pop(context),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Expanded(
                                                                                                            child: Container(
                                                                                                              height: 70,
                                                                                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                                                              child: ElevatedButton(
                                                                                                                style: ButtonStyle(
                                                                                                                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 220, 112, 110)),
                                                                                                                ),
                                                                                                                child: const Text(
                                                                                                                  'Eliminar',
                                                                                                                  style: TextStyle(
                                                                                                                    fontSize: 24,
                                                                                                                    color: Color.fromRGBO(242, 248, 241, 1),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                onPressed: () {
                                                                                                                  Navigator.pop(context);
                                                                                                                  Navigator.pop(context);
                                                                                                                  db.collection('citas').doc(idFinal).delete();
                                                                                                                },
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              );
                                                                                            },
                                                                                          );
                                                                                        },
                                                                                      );
                                                                                    },
                                                                                    icon: const Icon(
                                                                                      IconData(
                                                                                        0xf4c4,
                                                                                        fontFamily: CupertinoIcons.iconFont,
                                                                                        fontPackage: CupertinoIcons.iconFontPackage,
                                                                                      ),
                                                                                      size: 32,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 70,
                                                                              child: Align(
                                                                                alignment: Alignment.bottomLeft,
                                                                                child: Text('Fecha'),
                                                                              ),
                                                                            ),
                                                                            TextField(
                                                                              controller: _editarFechaController,
                                                                              decoration: const InputDecoration(
                                                                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                                                                                labelText: 'Fecha',
                                                                                suffixIcon: Icon(Icons.calendar_today),
                                                                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(110, 140, 220, 1))),
                                                                              ),
                                                                              readOnly: true,
                                                                              onTap: () {
                                                                                _editarFecha();
                                                                              },
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 70,
                                                                              width: double.infinity,
                                                                              child: Align(
                                                                                alignment: Alignment.bottomLeft,
                                                                                child: Text(
                                                                                  'Hora',
                                                                                  style: TextStyle(
                                                                                    fontSize: 18,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            TextField(
                                                                              controller: _editarHoraController,
                                                                              decoration: const InputDecoration(
                                                                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                                                                                labelText: 'Hora',
                                                                                suffixIcon: Icon(Icons.access_time),
                                                                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                                focusedBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(
                                                                                    color: Color.fromRGBO(110, 140, 220, 1),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              readOnly: true,
                                                                              onTap: () {
                                                                                _editarHora();
                                                                              },
                                                                            ),
                                                                            Container(
                                                                              margin: const EdgeInsets.only(top: 40),
                                                                              child: Row(
                                                                                children: [
                                                                                  const SizedBox(
                                                                                    child: Text(
                                                                                      'Sala',
                                                                                      style: TextStyle(
                                                                                        fontSize: 18,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(
                                                                                        border: Border.all(
                                                                                          width: 1,
                                                                                        ),
                                                                                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                                                                                      ),
                                                                                      margin: const EdgeInsets.only(left: 20),
                                                                                      child: Align(
                                                                                        alignment: Alignment.centerRight,
                                                                                        child: DropdownButton(
                                                                                          underline: const SizedBox(),
                                                                                          items: _items
                                                                                              .map(
                                                                                                (String item) => DropdownMenuItem(
                                                                                                  value: item,
                                                                                                  child: Text(item),
                                                                                                ),
                                                                                              )
                                                                                              .toList(),
                                                                                          onChanged: (String? newValue) {
                                                                                            setState(
                                                                                              () {
                                                                                                dropDownValue = newValue!;
                                                                                              },
                                                                                            );
                                                                                          },
                                                                                          value: dropDownValue,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              height: 50,
                                                                              margin: const EdgeInsets.only(top: 20),
                                                                              child: ElevatedButton(
                                                                                style: ButtonStyle(
                                                                                  backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(110, 140, 220, 1)),
                                                                                ),
                                                                                onPressed: () async {
                                                                                  var idABorrar = await db.collection('citas').where('id', isEqualTo: task?['id']).get();
                                                                                  String idFinal = idABorrar.docs[0].id;
                                                                                  db.collection('citas').doc(idFinal).update({
                                                                                    'fecha': _editarFechaController.text.split('-').reversed.toString().replaceAll(RegExp(r'\('), '').replaceAll(RegExp(r'\)'), '').replaceAll(RegExp(r', '), '/'),
                                                                                    'hora': _editarHoraController.text,
                                                                                    'sala': dropDownValue,
                                                                                  });
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                child: Container(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                                  child: const Text(
                                                                                    'Confirmar',
                                                                                    style: TextStyle(
                                                                                      fontSize: 24,
                                                                                      color: Color.fromRGBO(242, 248, 241, 1),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: Row(
                                                            children: <Widget>[
                                                              Container(
                                                                height: 50,
                                                                width: 40,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  border:
                                                                      Border(
                                                                    right: BorderSide(
                                                                        width:
                                                                            1),
                                                                  ),
                                                                ),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    '${task?['id']}',
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  height: 50,
                                                                  width: 40,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      right: BorderSide(
                                                                          width:
                                                                              1),
                                                                    ),
                                                                  ),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        '${task?['fecha']}'),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  height: 50,
                                                                  width: 40,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      right: BorderSide(
                                                                          width:
                                                                              1),
                                                                    ),
                                                                  ),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        '${task?['hora']}'),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  height: 50,
                                                                  width: 40,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      right: BorderSide(
                                                                          width:
                                                                              1),
                                                                    ),
                                                                  ),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        '${task?['sala']}'),
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
                                                                  child:
                                                                      Checkbox(
                                                                    value: task?[
                                                                        'ocupado'],
                                                                    onChanged:
                                                                        null,
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
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 70,
                            margin: const EdgeInsets.only(bottom: 10),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromRGBO(110, 140, 220, 1)),
                              ),
                              onPressed: () {
                                String dropDownValue = '1';

                                var _items = [
                                  '1',
                                  '2',
                                  '3',
                                  '4',
                                  '5',
                                  '6',
                                  '7',
                                  '8',
                                ];

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                      builder: (BuildContext context,
                                          StateSetter setState) {
                                        return Dialog(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 30),
                                            child: ListView(
                                              shrinkWrap: true,
                                              children: <Widget>[
                                                const SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    'Agregar Datos',
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        TextStyle(fontSize: 24),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 50,
                                                  width: double.infinity,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Text(
                                                      'Fecha:',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                TextField(
                                                  controller: _fechaController,
                                                  decoration:
                                                      const InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    width: 1)),
                                                    labelText: 'Fecha',
                                                    suffixIcon: Icon(
                                                        Icons.calendar_today),
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior
                                                            .never,
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromRGBO(
                                                            110, 140, 220, 1),
                                                      ),
                                                    ),
                                                  ),
                                                  readOnly: true,
                                                  onTap: () {
                                                    _seleccionarFecha();
                                                  },
                                                ),
                                                const SizedBox(
                                                  height: 70,
                                                  width: double.infinity,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Text(
                                                      'Hora',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                TextField(
                                                  controller: _horaController,
                                                  decoration:
                                                      const InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    width: 1)),
                                                    labelText: 'Hora',
                                                    suffixIcon:
                                                        Icon(Icons.access_time),
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior
                                                            .never,
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromRGBO(
                                                            110, 140, 220, 1),
                                                      ),
                                                    ),
                                                  ),
                                                  readOnly: true,
                                                  onTap: () {
                                                    _seleccionarHora();
                                                  },
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 40),
                                                  child: Row(
                                                    children: [
                                                      const SizedBox(
                                                        child: Text(
                                                          'Sala',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            4)),
                                                          ),
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 20),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child:
                                                                DropdownButton(
                                                              underline:
                                                                  const SizedBox(),
                                                              items: _items
                                                                  .map(
                                                                    (String item) =>
                                                                        DropdownMenuItem(
                                                                      value:
                                                                          item,
                                                                      child: Text(
                                                                          item),
                                                                    ),
                                                                  )
                                                                  .toList(),
                                                              onChanged: (String?
                                                                  newValue) {
                                                                setState(
                                                                  () {
                                                                    dropDownValue =
                                                                        newValue!;
                                                                  },
                                                                );
                                                              },
                                                              value:
                                                                  dropDownValue,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 50,
                                                  margin: const EdgeInsets.only(
                                                      top: 20),
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(const Color
                                                                  .fromRGBO(110,
                                                                  140, 220, 1)),
                                                    ),
                                                    onPressed: () async {
                                                      var snapshot = await db
                                                          .collection('citas')
                                                          .orderBy('id')
                                                          .get();
                                                      var newSnapshot = snapshot
                                                              .docs.last
                                                              .get('id') +
                                                          1;

                                                      var prof_rut2 = await db
                                                          .collection(
                                                              'profesional')
                                                          .where('email',
                                                              isEqualTo: widget
                                                                  .emailText)
                                                          .get()
                                                          .then((querySnapshot) =>
                                                              querySnapshot
                                                                  .docs[0]
                                                                  .get('rut'));

                                                      if (_fechaController
                                                                  .text ==
                                                              '' ||
                                                          _horaController
                                                                  .text ==
                                                              '') {
                                                        if (_fechaController
                                                                .text ==
                                                            '') {
                                                          print('fecha vacio');
                                                        }
                                                        if (_horaController
                                                                .text ==
                                                            '') {
                                                          print('hora vacio');
                                                        }
                                                      } else {
                                                        var citaData =
                                                            <String, dynamic>{
                                                          'id': newSnapshot,
                                                          'fecha': _fechaController
                                                              .text
                                                              .split('-')
                                                              .reversed
                                                              .toString()
                                                              .replaceAll(
                                                                  RegExp(r'\('),
                                                                  '')
                                                              .replaceAll(
                                                                  RegExp(r'\)'),
                                                                  '')
                                                              .replaceAll(
                                                                  RegExp(r', '),
                                                                  '/'),
                                                          'hora':
                                                              _horaController
                                                                  .text,
                                                          'ocupado':
                                                              false, // or true based on your requirement
                                                          'prof_rut':
                                                              widget.emailText,
                                                          'prof_email':
                                                              prof_rut2,
                                                          'sala': dropDownValue,
                                                        };
                                                        addCitaToFirestore(
                                                            citaData);
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    child: const Text(
                                                      'Continuar',
                                                      style: TextStyle(
                                                        fontSize: 24,
                                                        color: Color.fromRGBO(
                                                            242, 248, 241, 1),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: const Text(
                                  'Agendar',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Color.fromRGBO(242, 248, 241, 1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //////////////////////////////////// DETALLES ////////////////////////////////////
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
                                'Historial',
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
                                  //////////////////////////////////// TITULOS TABLA ////////////////////////////////////
                                  Container(
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(110, 140, 220, 1),
                                      border: BorderDirectional(
                                        bottom: BorderSide(
                                          width: 2,
                                        ),
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
                                                'Paciente',
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              '',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //////////////////////////////////// FILA 1 ////////////////////////////////////
                                  Flexible(
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: StreamBuilder(
                                        stream: db
                                            .collection('citas')
                                            .orderBy('id')
                                            .where('prof_rut',
                                                isEqualTo: widget.emailText)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          var tasks = snapshot.data?.docs;
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child: SizedBox(
                                                  width: 50,
                                                  height: 50,
                                                  child:
                                                      CircularProgressIndicator()),
                                            );
                                          }
                                          return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            padding: const EdgeInsets.all(0),
                                            itemCount: tasks?.length,
                                            itemBuilder: (context, index) {
                                              var task = tasks?[index];
                                              return ListTile(
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                visualDensity:
                                                    const VisualDensity(
                                                        horizontal: 0,
                                                        vertical: 0),
                                                minLeadingWidth: 0,
                                                minVerticalPadding: 0,
                                                subtitle: Column(
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
                                                          style: TextButton
                                                              .styleFrom(
                                                            foregroundColor:
                                                                Colors.black,
                                                            padding:
                                                                EdgeInsets.zero,
                                                            shape:
                                                                BeveledRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0),
                                                            ),
                                                          ),
                                                          onPressed: () async {
                                                            var dbPaciente = await db
                                                                .collection(
                                                                    'citas')
                                                                .where('id',
                                                                    isEqualTo:
                                                                        task?[
                                                                            'id'])
                                                                .get()
                                                                .then((value) =>
                                                                    value);

                                                            pacienteNombre =
                                                                dbPaciente
                                                                    .docs[0]
                                                                    .get(
                                                                        'pac_nombre');

                                                            pacienteRut =
                                                                dbPaciente
                                                                    .docs[0]
                                                                    .get(
                                                                        'pac_rut');

                                                            pacienteSala =
                                                                dbPaciente
                                                                    .docs[0]
                                                                    .get(
                                                                        'sala');

                                                            _detallesController
                                                                    .text =
                                                                dbPaciente
                                                                    .docs[0]
                                                                    .get(
                                                                        'detalles');

                                                            print(
                                                                pacienteNombre);

                                                            setState(
                                                              () {
                                                                detalleSeleccionado =
                                                                    index;
                                                                isExpanded =
                                                                    !isExpanded;
                                                              },
                                                            );
                                                          },
                                                          child: Row(
                                                            children: <Widget>[
                                                              Container(
                                                                height: 50,
                                                                width: 40,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  border:
                                                                      Border(
                                                                    right: BorderSide(
                                                                        width:
                                                                            1),
                                                                  ),
                                                                ),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    '${task?['id']}',
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  height: 50,
                                                                  width: 40,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      right: BorderSide(
                                                                          width:
                                                                              1),
                                                                    ),
                                                                  ),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        '${task?['fecha']}'),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  height: 50,
                                                                  width: 40,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      right: BorderSide(
                                                                          width:
                                                                              1),
                                                                    ),
                                                                  ),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        '${task?['hora']}'),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  height: 50,
                                                                  width: 40,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      right: BorderSide(
                                                                          width:
                                                                              1),
                                                                    ),
                                                                  ),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        '${task?['pac_nombre']}'),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 50,
                                                                width: 50,
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      nombreIcon,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                    //////////////////////////////////// FILA 2 ////////////////////////////////////
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
                                                          style: TextButton
                                                              .styleFrom(
                                                            foregroundColor:
                                                                Colors.black,
                                                            padding:
                                                                EdgeInsets.zero,
                                                            shape:
                                                                BeveledRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0),
                                                            ),
                                                          ),
                                                          onPressed: () async {
                                                            var dbPaciente = await db
                                                                .collection(
                                                                    'citas')
                                                                .where('id',
                                                                    isEqualTo:
                                                                        task?[
                                                                            'id'])
                                                                .get()
                                                                .then((value) =>
                                                                    value);

                                                            pacienteNombre =
                                                                dbPaciente
                                                                    .docs[0]
                                                                    .get(
                                                                        'pac_nombre');

                                                            pacienteRut =
                                                                dbPaciente
                                                                    .docs[0]
                                                                    .get(
                                                                        'pac_rut');

                                                            pacienteSala =
                                                                dbPaciente
                                                                    .docs[0]
                                                                    .get(
                                                                        'sala');

                                                            _detallesController
                                                                    .text =
                                                                dbPaciente
                                                                    .docs[0]
                                                                    .get(
                                                                        'detalles');

                                                            print(
                                                                pacienteNombre);

                                                            setState(
                                                              () {
                                                                detalleSeleccionado =
                                                                    index;
                                                                isExpanded =
                                                                    !isExpanded;
                                                              },
                                                            );
                                                          },
                                                          child: Row(
                                                            children: <Widget>[
                                                              Container(
                                                                height: 50,
                                                                width: 40,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  border:
                                                                      Border(
                                                                    right: BorderSide(
                                                                        width:
                                                                            1),
                                                                  ),
                                                                ),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    '${task?['id']}',
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  height: 50,
                                                                  width: 40,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      right: BorderSide(
                                                                          width:
                                                                              1),
                                                                    ),
                                                                  ),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        '${task?['fecha']}'),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  height: 50,
                                                                  width: 40,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      right: BorderSide(
                                                                          width:
                                                                              1),
                                                                    ),
                                                                  ),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        '${task?['hora']}'),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  height: 50,
                                                                  width: 40,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      right: BorderSide(
                                                                          width:
                                                                              1),
                                                                    ),
                                                                  ),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        '${task?['pac_nombre']}'),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 50,
                                                                width: 50,
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      nombreIcon,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    if (index ==
                                                        detalleSeleccionado)
                                                      AnimatedContainer(
                                                        duration:
                                                            const Duration(
                                                          milliseconds: 500,
                                                        ),
                                                        height: isExpanded
                                                            ? 550
                                                            : 0,
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              const BoxDecoration(
                                                            border: Border(
                                                              bottom:
                                                                  BorderSide(
                                                                      width: 2),
                                                            ),
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                height: 50,
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  border:
                                                                      Border(
                                                                    top: BorderSide(
                                                                        width:
                                                                            2),
                                                                    bottom: BorderSide(
                                                                        width:
                                                                            2),
                                                                  ),
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          189,
                                                                          228,
                                                                          250,
                                                                          1),
                                                                ),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    pacienteNombre,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          24,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: double
                                                                    .infinity,
                                                                height: 498,
                                                                child: SizedBox(
                                                                  width: double
                                                                      .infinity,
                                                                  child: Column(
                                                                    children: <Widget>[
                                                                      SizedBox(
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            Row(
                                                                          children: <Widget>[
                                                                            Expanded(
                                                                              child: Container(
                                                                                height: 100,
                                                                                decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 1), right: BorderSide(width: 1))),
                                                                                child: Column(
                                                                                  children: <Widget>[
                                                                                    Container(
                                                                                      width: double.infinity,
                                                                                      height: 50,
                                                                                      decoration: const BoxDecoration(
                                                                                        border: Border(bottom: BorderSide(width: 1)),
                                                                                        color: Color.fromRGBO(110, 140, 220, 1),
                                                                                      ),
                                                                                      child: const Center(
                                                                                        child: Text(
                                                                                          'RUT',
                                                                                          style: TextStyle(
                                                                                            color: Color.fromRGBO(242, 248, 241, 1),
                                                                                            fontSize: 18,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 49,
                                                                                      child: Center(
                                                                                        child: Text(
                                                                                          pacienteRut,
                                                                                          style: const TextStyle(fontSize: 18),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Container(
                                                                                height: 100,
                                                                                decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
                                                                                child: Column(
                                                                                  children: <Widget>[
                                                                                    Container(
                                                                                      width: double.infinity,
                                                                                      height: 50,
                                                                                      decoration: const BoxDecoration(
                                                                                        border: Border(bottom: BorderSide(width: 1)),
                                                                                        color: Color.fromRGBO(110, 140, 220, 1),
                                                                                      ),
                                                                                      child: const Center(
                                                                                        child: Text(
                                                                                          'Sala',
                                                                                          style: TextStyle(
                                                                                            color: Color.fromRGBO(242, 248, 241, 1),
                                                                                            fontSize: 18,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 49,
                                                                                      child: Center(
                                                                                        child: Text(
                                                                                          pacienteSala,
                                                                                          style: const TextStyle(fontSize: 18),
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: double
                                                                            .infinity,
                                                                        height:
                                                                            300,
                                                                        margin: const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                        child:
                                                                            TextField(
                                                                          controller:
                                                                              _detallesController,
                                                                          key:
                                                                              globalKey,
                                                                          decoration:
                                                                              const InputDecoration(
                                                                            contentPadding:
                                                                                EdgeInsets.symmetric(vertical: 280, horizontal: 10),
                                                                            border:
                                                                                OutlineInputBorder(),
                                                                          ),
                                                                          textAlignVertical:
                                                                              TextAlignVertical.top,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            50,
                                                                        child:
                                                                            ElevatedButton(
                                                                          style:
                                                                              ButtonStyle(
                                                                            backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(
                                                                                110,
                                                                                140,
                                                                                220,
                                                                                1)),
                                                                          ),
                                                                          onPressed:
                                                                              () async {
                                                                            var idAModificar =
                                                                                await db.collection('citas').where('id', isEqualTo: task?['id']).get();
                                                                            String
                                                                                idFinal =
                                                                                idAModificar.docs[0].id;
                                                                            db.collection('citas').doc(idFinal).update(
                                                                              {
                                                                                'detalles': _detallesController.text
                                                                              },
                                                                            );
                                                                          },
                                                                          child:
                                                                              const Text(
                                                                            'Editar',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 24,
                                                                              color: Color.fromRGBO(242, 248, 241, 1),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
