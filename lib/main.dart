import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Gano Hesapla'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dersAdi;
  int dersKredi = 1;
  double dersHarfNotu = 4;
  List<Ders> tumDersler;
  var formkey = GlobalKey<FormState>();
  double ortlama = 0;
  // TODO DERS SAYISI ADETİ FALAN FİLAN DA EKLE MAVİ SATIRA
  static int sayac = 0;

  List<DropdownMenuItem<int>> dropDownKrediOlustur() {
    List<DropdownMenuItem<int>> list = [];
    for (var i = 0; i < 9; i++) {
      list.add(DropdownMenuItem(child: Text('$i'), value: i));
    }
    return list;
  }

  List<DropdownMenuItem<double>> dropDownHarfOlustur() {
    List<DropdownMenuItem<double>> list = [];

    list.add(DropdownMenuItem(child: Text('AA'), value: 4));
    list.add(DropdownMenuItem(child: Text('BA'), value: 3.5));
    list.add(DropdownMenuItem(child: Text('BB'), value: 3));
    list.add(DropdownMenuItem(child: Text('CB'), value: 2.5));
    list.add(DropdownMenuItem(child: Text('CC'), value: 2));
    list.add(DropdownMenuItem(child: Text('DC'), value: 1.5));
    list.add(DropdownMenuItem(child: Text('DD'), value: 1));
    list.add(DropdownMenuItem(child: Text('FF'), value: 0));

    return list;
  }

  ortalamayiHesapla() {
    double toplamNot = 0;
    double toplamKredi = 0;

    for (var ders in tumDersler) {
      var kredi = ders.kredi;
      var notDegeri = ders.harfDegeri;

      toplamNot = toplamNot + (notDegeri * kredi);
      toplamKredi = toplamKredi + kredi;
    }
    var x = toplamNot / toplamKredi;

    setState(() {
      if (!x.isNaN) {
        ortlama = double.parse(x.toStringAsFixed(2));
      } else {
        ortlama = 0;
      }
    });
  }

  Color randomColor() {
    var r = 50 + Random().nextInt(206);
    var g = 50 + Random().nextInt(206);
    var b = 50 + Random().nextInt(206);

    return Color.fromRGBO(r, g, b, 1);
  }

  Widget screenPortrait() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (v) {
                        if (v.length < 5)
                          return "Ders adi 5 karakterden az olamaz";
                        else
                          return null;
                      },
                      onSaved: (v) {
                        dersAdi = v;
                      },
                      decoration: InputDecoration(
                          hintText: "Ders adi",
                          labelText: "Ders adi",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // margin: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Kredi Sayisi'),
                                Container(
                                  /* decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(4)), */
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DropdownButtonHideUnderline(
                                      child: SizedBox(
                                        width: 80,
                                        child: DropdownButton<int>(
                                          items: dropDownKrediOlustur(),
                                          onChanged: (value) {
                                            setState(() {
                                              dersKredi = value;
                                            });
                                          },
                                          value: dersKredi,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Row(
                              children: [
                                Text('Harf Notu'),
                                Container(
                                  /* decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(4)), */
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DropdownButtonHideUnderline(
                                      child: SizedBox(
                                        width: 80,
                                        child: DropdownButton<double>(
                                          items: dropDownHarfOlustur(),
                                          onChanged: (value) {
                                            setState(() {
                                              dersHarfNotu = value;
                                            });
                                          },
                                          value: dersHarfNotu,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // Divider(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Eklenen Ders Adeti : " +
                    tumDersler.length.toString() +
                    " - Ortalama : " +
                    ortlama.toString(),
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Divider(),
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    sayac++;

                    return Dismissible(
                      key: Key(sayac.toString()),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (direction) {
                        setState(
                          () {
                            tumDersler.removeAt(index);
                            ortalamayiHesapla();
                          },
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        child: Card(
                          color: tumDersler[index].renk,
                          elevation: 6,
                          child: ListTile(
                            title: Text("Ders : " + tumDersler[index].ad),
                            subtitle: Text(
                              "Kredi : " +
                                  tumDersler[index].kredi.toString() +
                                  " - " +
                                  "Harf notu : " +
                                  tumDersler[index].harfDegeri.toString(),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: tumDersler.length,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
            // child: Container(color: Colors.red),
          )
        ],
      ),
    );
  }

  Widget screenLandscape() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        validator: (v) {
                          if (v.length < 5)
                            return "Ders adi 5 karakterden az olamaz";
                          else
                            return null;
                        },
                        onSaved: (v) {
                          dersAdi = v;
                        },
                        decoration: InputDecoration(
                            hintText: "Ders adi",
                            labelText: "Ders adi",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // margin: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Kredi Sayisi'),
                                  Container(
                                    /* decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                        borderRadius: BorderRadius.circular(4)), */
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DropdownButtonHideUnderline(
                                        child: SizedBox(
                                          width: 60,
                                          child: DropdownButton<int>(
                                            items: dropDownKrediOlustur(),
                                            onChanged: (value) {
                                              setState(() {
                                                dersKredi = value;
                                              });
                                            },
                                            value: dersKredi,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  // width: 40,
                                  ),
                              Row(
                                children: [
                                  Text('Harf Notu'),
                                  Container(
                                    /* decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                        borderRadius: BorderRadius.circular(4)), */
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DropdownButtonHideUnderline(
                                        child: SizedBox(
                                          width: 60,
                                          child: DropdownButton<double>(
                                            items: dropDownHarfOlustur(),
                                            onChanged: (value) {
                                              setState(() {
                                                dersHarfNotu = value;
                                              });
                                            },
                                            value: dersHarfNotu,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Eklenen Ders Adeti : " +
                                tumDersler.length.toString() +
                                " - Ortalama : " +
                                ortlama.toString(),
                            style: TextStyle(fontSize: 16, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    sayac++;

                    return Dismissible(
                      key: Key(sayac.toString()),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (direction) {
                        setState(
                          () {
                            tumDersler.removeAt(index);
                            ortalamayiHesapla();
                          },
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        child: Card(
                          color: tumDersler[index].renk,
                          elevation: 6,
                          child: ListTile(
                            title: Text("Ders : " + tumDersler[index].ad),
                            subtitle: Text(
                              "Kredi : " +
                                  tumDersler[index].kredi.toString() +
                                  " - " +
                                  "Harf notu : " +
                                  tumDersler[index].harfDegeri.toString(),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: tumDersler.length,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
            // child: Container(color: Colors.red),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumDersler = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      /* appBar: AppBar(
        title: Text(widget.title),
      ), */
      body: SafeArea(
        child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            if (orientation == Orientation.portrait) {
              return screenPortrait();
            } else {
              return screenLandscape();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formkey.currentState.validate()) {
            formkey.currentState.save();
            print("-----------");
            print(dersAdi);
            print(dersHarfNotu);
            print(dersKredi);
            print("-----------");
            setState(() {
              tumDersler.add(Ders(
                  ad: dersAdi,
                  harfDegeri: dersHarfNotu,
                  kredi: dersKredi,
                  renk: randomColor()));
            });
            ortalamayiHesapla();
          }
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class Ders {
  String ad;
  double harfDegeri;
  int kredi;
  Color renk;

  Ders({
    @required this.ad,
    @required this.harfDegeri,
    @required this.kredi,
    @required this.renk,
  });
}
