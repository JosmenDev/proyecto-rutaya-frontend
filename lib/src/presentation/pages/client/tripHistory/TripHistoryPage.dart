import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequest.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/tripHistory/TripHistoryContent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/tripHistory/bloc/TripHistoryBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/tripHistory/bloc/TripHistoryEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/tripHistory/bloc/TripHistoryState.dart';

class TripHistoryPage extends StatefulWidget {
  const TripHistoryPage({super.key});

  @override
  State<TripHistoryPage> createState() => _TripHistoryPageState();
}

class _TripHistoryPageState extends State<TripHistoryPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<TripHistoryBloc>().add(GetHistoryTrip());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripHistoryBloc, TripHistoryState>(
      builder: (context, state) {
        final response = state.response;
        if (response is Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (response is Success) {
          List<ClientRequest> data = response.data as List<ClientRequest>;
          print('Data: ${data}');

          return Container(
            margin: EdgeInsets.all(10),
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return TripHistoryContent(data[index]);
                }),
          );
        }
        return Container();
      },
    );
  }
}
