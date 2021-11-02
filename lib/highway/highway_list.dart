// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:highway_peek/highway/highway_api.dart';
import 'package:highway_peek/highway/highway_images.dart';

class HighwayList extends StatefulWidget {
  const HighwayList({Key? key}) : super(key: key);

  @override
  _HighwayListState createState() => _HighwayListState();
}

class _HighwayListState extends State<HighwayList> {
  final _formKey = GlobalKey<FormState>();
  bool _onLoading = false;
  late Map<String, dynamic> chosenHighway;
  List<Map<String, dynamic>> highwayList = [
    {'NKV': 'E1:L/raya Baru Lembah Klang (NKVE)'},
    {'PLS': 'E1:L/raya Utara Selatan (PLUS Utara)'},
    {'SPL': 'E2:L/raya Utara Selatan (PLUS Selatan)'},
    {'LINK2': 'E3:L/raya Hubungan Kedua Malaysia Singapura (LINK2)'},
    {'KSS': 'E5:L/raya Shah Alam (KESAS)'},
    {'ELT': 'E6:L/raya Utara Selatan Hubungan Tengah (ELITE)'},
    {'CKH': 'E7:L/raya Cheras Kajang (GRANDSAGA)'},
    {'KLK': 'E8:L/raya KL-Karak (KLK)'},
    {'LPT': 'E8:L/raya Pantai Timur Fasa 1 (LPT1)'},
    {'ECE2': 'E8:L/raya Pantai Timur Fasa 2 (LPT2)'},
    {'BES': 'E9:L/raya BESRAYA (BES)'},
    {'NPE': 'E10:L/raya Pantai Baharu (NPE)'},
    {'LDP': 'E11:L/raya Damansara Puchong (LDP)'},
    {'AKL': 'E12:L/raya Bertingkat Ampang KL (AKLEH)'},
    {'KSA': 'E13:L/raya Kemuning Shah Alam (LKSA)'},
    {'SLK': 'E18:L/raya Lingkaran Luar Kajang (SILK)'},
    {'KLP': 'E20:L/raya KL-Putrajaya (MEX)'},
    {'LKS': 'E21:L/raya Kajang Seremban (LEKAS)'},
    {'SDE': 'E22:L/raya Senai Desaru (SDE)'},
    {'SRT': 'E23:L/raya Skim Penyuraian Trafik KL-Barat (SPRINT)'},
    {'LTR': 'E25:L/raya KL-Kuala Selangor (LATAR)'},
    {'SKV': 'E26:L/raya Lembah Klang Selatan (SKVE)'},
    {'PB2': 'E28:Jambatan Sultan Abdul Halim Muadzam Shah (JSAHMS)'},
    {'SPD': 'E30:L/raya Pintas Selat Klang Utara Baru (NNKSB)'},
    {'WCE': 'E32:L/raya Pesisiran Pantai Barat (WCE)'},
    {'DUKE': 'E33:L/raya Duta-Ulu Kelang (DUKE)'},
    {'GCE': 'E35:L/raya Koridor Gutrie (GCE)'},
    {'PNB': 'E33:L/raya Jambatan Pulau Pinang (PNB)'},
    {'SMT': 'E33:L/raya Terowong SMART'},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chosenHighway = highwayList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Highway Sneak Peek')),
      body: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: ExactAssetImage('assets/background.jfif'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70, bottom: 30),
              child: Text(
                'Choose Highway',
                style: TextStyle(fontSize: 24),
              ),
            ),
            Form(
              key: _formKey,
              child:
                  dropdownOption(highwayList, chosenHighway, 'Choose Highway'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.blueGrey.shade800),
                  ),
                  onPressed: _onLoading
                      ? null
                      : () async {
                          _onLoading = true;
                          setState(() {});
                          if (_formKey.currentState!.validate()) {
                            Map<String, dynamic> res = await highwayImagesGet(
                                chosenHighway.keys.first);
                            if (res['status'] == '200') {
                              _onLoading = false;
                              setState(() {});
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HighwayImages(
                                        highwayName: chosenHighway.keys.first,
                                        htmlView: res['status_msg'])),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(seconds: 5),
                                  content: Text(res['status_msg']),
                                ),
                              );

                              _onLoading = false;
                              setState(() {});
                            }
                          } else {
                            _onLoading = false;
                            setState(() {});
                          }
                        },
                  child: _onLoading
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.remove_red_eye_rounded),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8)),
                              Text('Peek'),
                            ],
                          ),
                        )),
            )
          ],
        ),
      ),
    );
  }

  Widget dropdownOption(
    List<Map<String, dynamic>> optionList,
    Map<String, dynamic>? chosenValue,
    String hintText,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButtonFormField<Map<String, dynamic>>(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(color: Colors.blueGrey.shade800)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(color: Colors.blueGrey.shade800)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.red)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.red)),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey.shade400,
                    ),
                    // focusColor: globals.colMain,
                    dropdownColor: Colors.grey.shade200,
                    value: chosenValue,
                    elevation: 5,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    // underline: Container(),
                    items: optionList
                        .map<DropdownMenuItem<Map<String, dynamic>>>(
                            (Map<String, dynamic> highway) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: highway,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width *
                              0.7, //width of dropdown bar

                          child: Text(highway[highway.keys.first],
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              )),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      hintText,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[400],
                      ),
                    ),
                    onChanged: (Map<String, dynamic>? value) {
                      chosenHighway = value!;
                      setState(() {});
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Field is required.';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
