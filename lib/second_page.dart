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
                                            .orderBy('id').where('prof_rut',isEqualTo: widget.emailText)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          // If the connection is done and there is no error, display the data
                                          var tasks = snapshot.data!.docs;
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return CircularProgressIndicator();
                                          }
                                          return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            padding: const EdgeInsets.all(0),
                                            itemCount: tasks.length,
                                            itemBuilder: (context, index) {
                                              var task = tasks[index];
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
                                                                    '${task['id']}',
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
                                                                        '${task['fecha']}'),
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
                                                                        '${task['hora']}'),
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
                                                                        '${task['sala']}'),
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
                                                                    value: task[
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
                                                                    '${task['id']}',
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
                                                                        '${task['fecha']}'),
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
                                                                        '${task['hora']}'),
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
                                                                        '${task['sala']}'),
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
                                                                    value: task[
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
                                            // You can display additional information or perform actions here
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
