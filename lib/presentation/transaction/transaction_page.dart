import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  int step = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              // height: MediaQuery.sizeOf(context).height / 5,
              color: Colors.amber,
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      child: CircularPercentIndicator(
                        radius: MediaQuery.sizeOf(context).width / 8,
                        lineWidth: MediaQuery.sizeOf(context).width / 30,
                        percent: 0.1,
                        center: Text(
                          "1 of 4",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        progressColor: Colors.green,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      width: double.infinity,
                      // color: Colors.blue,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pilih Pelanggan",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 5),
                          Text("Selanjutnya : kategori")
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 7,
            child: Container(
              color: Colors.blue,
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return Text("data");
                },
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Kembali"),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Lanjut"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
