import 'package:clinica_app3/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  final db = FirebaseFirestore.instance;

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
                                Future<String?> dateSelected;
                                Future<String?> timeSelected;
                                String dropDownValue = '1';

                                var _items = [
                                  '1',
                                  '2',
                                  '3',
                                  '4',
                                  '5',
                                  '6',
                                  '7',
                                  '8'
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
                                                                color: Color
                                                                    .fromRGBO(
                                                                        110,
                                                                        140,
                                                                        220,
                                                                        1))),
                                                  ),
                                                  readOnly: true,
                                                  onTap: () {
                                                    dateSelected =
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
                                                                color: Color
                                                                    .fromRGBO(
                                                                        110,
                                                                        140,
                                                                        220,
                                                                        1))),
                                                  ),
                                                  readOnly: true,
                                                  onTap: () {
                                                    timeSelected =
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
                                                                  .map((String
                                                                          item) =>
                                                                      DropdownMenuItem(
                                                                          value:
                                                                              item,
                                                                          child:
                                                                              Text(item)))
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
                                                      var nextId;
                                                      var snapshot = await db
                                                          .collection('citas')
                                                          .get()
                                                          .then(
                                                              (querySnapshot) =>
                                                                  querySnapshot
                                                                      .docs
                                                                      .length);
                                                      var fecha,
                                                          id,
                                                          hora,
                                                          prof_rut,
                                                          ocupado,
                                                          prof_email,
                                                          sala;

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
                                                        db
                                                            .collection('citas')
                                                            .where('prof_rut',
                                                                isEqualTo: widget
                                                                    .emailText);
                                                        print(_fechaController
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
                                                                '/'));
                                                        print(_horaController
                                                            .text);
                                                        print('id: ${snapshot}');
                                                        var citaData = {
                                                          id: snapshot.toInt(),
                                                          fecha:
                                                              "your_fecha_value",
                                                          hora:
                                                              "your_hora_value",
                                                          ocupado:
                                                              false, // or true based on your requirement
                                                          prof_rut:
                                                              "prof_rut_value",
                                                          prof_email:
                                                              "prof_email_value",
                                                          sala: "sala_value"
                                                        };
                                                      }
                                                      print(dropDownValue);
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
