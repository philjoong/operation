import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operation/blocs/auth_bloc.dart';
import 'package:operation/blocs/startSelectorBloc.dart';
import 'package:operation/blocs/strategyBloc.dart';
import 'package:operation/component/timelinePage.dart';
import 'package:operation/init_dependencies.dart';
import 'package:operation/repository/startRepository.dart';
import '../blocs/startBloc.dart';
import '../blocs/startBlocDI.dart';
import '../cases/strategyUseCase.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => StartRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => StartBlocDI(context.read<StartRepository>()),
          ),
          BlocProvider(
            create: (context) => StartSelectorBloc(),
          ),
        ],
        child: StartPage(),
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                            create: (context) => StrategyBloc(strategyUseCase: getIt<StrategyUseCase>()),
                            child: TimelinePage()),
                      ));
                },
                child: Text('Timeline')),
            BlocBuilder<StartBlocDI, int>(
                builder: (context, state) => Text(state.toString())),
            BlocSelector<StartSelectorBloc, StartSelectorState, bool>(
                selector: (state) => state.changeState,
                builder: (context, state) {
                  return Text(state.toString());
                }),
            BlocBuilder<StartSelectorBloc, StartSelectorState>(
                buildWhen: (previous, current) => current.changeState,
                builder: (context, state) => Text(state.value.toString())),
            BlocListener<StartBlocDI, int>(
              listenWhen: (previous, current) => current > 5,
              listener: (context, state) {
                _showMessage(context);
              },
              child: Text(context.read<StartBlocDI>().state.toString()),
            ),
            
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthInitial) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => context.read<AuthBloc>().add(SignInWithGoogle()),
                        child: Text('Sign In with Google'),
                      ),
                      ElevatedButton(
                        onPressed: () => context.read<AuthBloc>().add(SignInWithApple()),
                        child: Text('Sign In with Apple'),
                      ),
                    ],
                  );
                }
                else if (state is AuthLoading) {
                  return CircularProgressIndicator();
                } else if (state is AuthAuthenticated) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Hello, ${state.user.name}'),
                      ElevatedButton(
                        onPressed: () => context.read<AuthBloc>().add(SignOut()),
                        child: Text('Sign Out'),
                      ),
                    ],
                  );
                } else if (state is AuthError) {
                  return Text('Error: ${state.message}');
                }
                return Container();
              }
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      context.read<StartSelectorBloc>().add(ChangeStateEvent());
                    },
                    child: Text("상태 변경")),
                ElevatedButton(
                    onPressed: () {
                      context.read<StartSelectorBloc>().add(ValueEvent());
                    },
                    child: Text("value 변경"))
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<StartBlocDI>().add(AddStartDIEvent());
        },
      ),
    );
  }
}

void _showMessage(BuildContext context) {
  final snackBar = SnackBar(
    content: Text('The value is now greater than 5!'),
    duration: Duration(seconds: 3),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Handle the undo action here, if necessary.
      },
    ),
  );

  // Find the closest Scaffold widget and show the snackbar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
