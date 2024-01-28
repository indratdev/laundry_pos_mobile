// import 'package:flutter/material.dart';
// import 'package:laundry_app/core/constants/colors.dart';
// import 'package:laundry_app/presentation/status/widgets/queue_status_widget.dart';

// class StatusPage extends StatefulWidget {
//   const StatusPage({super.key});

//   @override
//   State<StatusPage> createState() => _StatusPageState();
// }

// class _StatusPageState extends State<StatusPage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   int selectedIndex = 0;

//   static const List<Tab> myTabs = <Tab>[
//     Tab(
//       text: 'Antrian',
//     ),
//     Tab(
//       text: 'Proses',
//     ),
//     Tab(
//       text: 'Selesai',
//     ),
//   ];

//   @override
//   void initState() {
//     _tabController = TabController(vsync: this, length: myTabs.length);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Status"),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // header menu
//             Container(
//               // padding: EdgeInsets.all(4),
//               // color: Colors.amber,
//               height: MediaQuery.sizeOf(context).height / 12,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       margin: const EdgeInsets.all(8),
//                       // padding: EdgeInsets.symmetric(horizontal: 8),
//                       child: TextFormField(
//                         textAlign: TextAlign.center,
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.symmetric(horizontal: 8),
//                           alignLabelWithHint: true,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           filled: true,
//                           hintStyle: TextStyle(color: Colors.grey[800]),
//                           hintText: "Ketik nama / No. Hp / No. kwitansi",
//                           hintMaxLines: 1,
//                           fillColor: Colors.transparent,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       IconButton(
//                         onPressed: () {},
//                         icon: const Icon(
//                           Icons.qr_code_scanner_outlined,
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () {},
//                         icon: const Icon(
//                           Icons.refresh,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             // end header menu
//             // page view
//             DefaultTabController(
//               initialIndex: 0,
//               length: myTabs.length,
//               child: TabBar(
//                 padding: EdgeInsets.zero,

//                 indicatorColor: AppColors.hardYellow,
//                 indicatorSize: TabBarIndicatorSize.tab,
//                 indicatorWeight: 3.0,
//                 labelColor: AppColors.hardBlueColor,
//                 // labelPadding: EdgeInsets.only(top: 10.0),
//                 unselectedLabelColor: Colors.grey,
//                 tabs: myTabs,
//                 controller: _tabController,
//                 onTap: (value) {
//                   selectedIndex = value;
//                   // loadData(value);
//                 },
//               ),
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height,
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   QuequeStatusWidget(),
//                   Container(color: Colors.blue,),
//                    Container(color: Colors.purple,),
//                 ],
//               ),
//             ),

//             // end page view
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:laundry_app/core/constants/colors.dart';
import 'package:laundry_app/presentation/status/widgets/queue_status_widget.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedIndex = 0;

  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Antrian'),
    Tab(text: 'Proses'),
    Tab(text: 'Selesai'),
  ];

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: myTabs.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Status"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header menu
          Container(
            height: MediaQuery.of(context).size.height / 12,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(


                          borderRadius: BorderRadius.circular(8),
                          
                        ),
                        
                        filled: true,
                        hintStyle: TextStyle(color: AppColors.disabled),
                        hintText: "Ketik nama / No. Hp / No. kwitansi",
                        hintMaxLines: 1,
                        fillColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.qr_code_scanner_outlined,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.refresh,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // End header menu
          // Page view
          Expanded(
            child: DefaultTabController(
              initialIndex: 0,
              length: myTabs.length,
              child: Column(
                children: [
                  TabBar(
                    padding: EdgeInsets.zero,
                    indicatorColor: AppColors.hardYellow,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 3.0,
                    labelColor: AppColors.hardBlueColor,
                    unselectedLabelColor: Colors.grey,
                    tabs: myTabs,
                    controller: _tabController,
                    onTap: (value) {
                      selectedIndex = value;
                      // loadData(value);
                    },
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        QuequeStatusWidget(),
                        Container(color: Colors.blue),
                        Container(color: Colors.purple),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // End page view
        ],
      ),
    );
  }
}
