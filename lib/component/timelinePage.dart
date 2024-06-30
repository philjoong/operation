import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/strategyBloc.dart';

class TimelinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataBloc = BlocProvider.of<StrategyBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Timeline"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<StrategyBloc, DataState>(
              builder: (context, state) {
                if (state is DataInitial) {
                  return Text('Press the button to fetch data');
                } else if (state is DataLoading) {
                  return CircularProgressIndicator();
                } else if (state is DataLoaded) {
                  return Text(state.data.toString());
                } else if (state is DataError) {
                  return Text('Error: ${state.message}');
                } else {
                  return Container();
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                dataBloc.add(FetchDataEvent());
              },
              child: Text('Fetch Data'),
            ),
          ],
        ),
      ),
      // body: ,
    );
  }
}
