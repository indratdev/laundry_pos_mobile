import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_app/core/componets/spaces.dart';
import 'package:laundry_app/data/models/response/history_response_model.dart';
import 'package:laundry_app/presentation/blocs/history_bloc/history_bloc.dart';
import 'package:laundry_app/presentation/history/widgets/history_transaction_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryBloc>().add(const HistoryEvent.fetch());
  }

  @override
  Widget build(BuildContext context) {
    const paddingHorizontal = EdgeInsets.symmetric(horizontal: 16.0);

    return Scaffold(
        appBar: AppBar(
          title: const Text('History Orders',
              style: TextStyle(fontWeight: FontWeight.bold)),
          // backgroundColor: AppColors.primary,
          elevation: 0,
          centerTitle: true,
        ),
        body: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            return state.maybeWhen(orElse: () {
              return const Center(
                child: Text('No data'),
              );
            }, loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }, success: (data) {
              if (data.data.isEmpty) {
                return const Center(
                  child: Text('No data'),
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                itemCount: data.data.length,
                separatorBuilder: (context, index) => const SpaceHeight(8.0),
                itemBuilder: (context, index) {
                  HistoryData datas = data.data[index];
                  return HistoryTransactionCard(
                    data: datas,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  );
                },
              );
            });
          },
        ));
  }
}
