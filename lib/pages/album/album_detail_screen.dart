import 'package:cached_network_image/cached_network_image.dart';
import 'package:eclipse_test/components/error_text_widget.dart';
import 'package:eclipse_test/constants/eclipse_text_style.dart';
import 'package:eclipse_test/logic/bloc/album/album_bloc.dart';
import 'package:eclipse_test/logic/models/album/album.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/dot_indicator.dart';
import '../../utils/text_extensions.dart';

class AlbumDetailScreen extends StatefulWidget {
  const AlbumDetailScreen({
    Key? key,
    required this.album,
  }) : super(key: key);

  final Album album;

  @override
  State<AlbumDetailScreen> createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends State<AlbumDetailScreen> {
  final albumBloc = AlbumBloc();

  final _controller = PageController();

  static const _kDuration = Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  @override
  void initState() {
    albumBloc.add(GetPhotosList(id: widget.album.id));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.album.title.capitalize(),
          style: EclipseTextStyle.title,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: BlocBuilder<AlbumBloc, AlbumState>(
            bloc: albumBloc,
            builder: (context, state) {
              if (state is AlbumInitial) {
                return const CircularProgressIndicator.adaptive();
              }

              if (state is PhotosLoaded) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: 10,
                    pageSnapping: true,
                    itemBuilder: (context, i) {
                      final photo = state.photosList[i];

                      return Stack(children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: photo.url,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  photo.title.capitalize(),
                                  style: EclipseTextStyle.title,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 80.0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: DotIndicator(
                                controller: _controller,
                                itemCount: 10,
                                onPageSelected: (int page) {
                                  _controller.animateToPage(
                                    page,
                                    duration: _kDuration,
                                    curve: _kCurve,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ]);
                    },
                  ),
                );
              }

              return const ErrorTextWidget();
            },
          ),
        ),
      ),
    );
  }
}
