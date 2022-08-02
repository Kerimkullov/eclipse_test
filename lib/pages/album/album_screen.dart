import 'package:eclipse_test/constants/eclipse_text_style.dart';
import 'package:eclipse_test/logic/bloc/album/album_bloc.dart';
import 'package:eclipse_test/logic/models/album/album.dart';
import 'package:eclipse_test/pages/album/album_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/text_extensions.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({Key? key}) : super(key: key);

  void onTapAlbumCard(Album album, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AlbumDetailScreen(
          album: album,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Album',
        style: EclipseTextStyle.title,
      )),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<AlbumBloc, AlbumState>(
            bloc: context.read<AlbumBloc>(),
            builder: (context, state) {
              if (state is AlbumInitial) {
                return const CircularProgressIndicator.adaptive();
              }

              if (state is AlbumLoaded) {
                return ListView.separated(
                  itemCount: state.albumList.length,
                  itemBuilder: (context, i) {
                    final album = state.albumList[i];

                    return Card(
                      child: ListTile(
                        onTap: (() => onTapAlbumCard(album, context)),
                        title: Text(
                          album.title.capitalize(),
                          style: EclipseTextStyle.title,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, i) => const SizedBox(height: 10),
                );
              }

              return const Text('Проверьте интернет соединение');
            },
          ),
        ),
      ),
    );
  }
}
