import 'package:flutter/material.dart';
import 'package:glossy_tunes/data/repo/music_repository.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    List musics;
    musicRepository.getAll().then((value) => musics=value);
    return const Placeholder();
  }
}
