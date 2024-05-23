import 'package:cat_pragma/app/module/splash/presenter/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Modular.get<SplashBloc>()..add(InitializeEvent()),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is LoadedState) {
            Modular.to.navigate('/home');
          }
          return;
        },
        child: Center(
          child: Hero(
            tag: 'logo',
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/gif/loader_cat.gif',
                  width: 200,
                ),
                const SizedBox(height: 160),
                const LoadingWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, SplashState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text('Loading...', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: state.model.progress,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
                minHeight: 10,
              ),
              const SizedBox(height: 10),
              Text('${(state.model.progress * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
        );
      },
    );
  }
}
