import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/res/app_colors.dart';
import 'package:music_app/res/app_images.dart';
import 'package:music_app/view/player/music_player_screen.dart'; // This is now used!

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AudioPlayer _player = AudioPlayer();

  // State variables to track playback
  int? _playingIndex;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  void requestPermission() async {
    await [Permission.storage, Permission.audio].request();
    setState(() {});
  }

  void playSong(String? uri, int index) {
    try {
      _player.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      _player.play();
      setState(() {
        _playingIndex = index;
        _isPlaying = true;
      });
    } on Exception {
      debugPrint("Error parsing song");
    }
  }

  void pauseSong() {
    _player.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  String getRandomImage(int index) {
    return AppImages.list[index % AppImages.list.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("My Music",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: FutureBuilder<List<SongModel>>(
        future: _audioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, item) {
          if (item.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (item.data!.isEmpty) {
            return const Center(child: Text("No Songs Found"));
          }

          return ListView.builder(
            itemCount: item.data!.length,
            itemBuilder: (context, index) {
              bool isCurrentSong = _playingIndex == index;

              return Container(
                margin: const EdgeInsets.only(bottom: 12, left: 15, right: 15),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: shadowColor,
                        offset: const Offset(4, 4),
                        blurRadius: 10,
                      ),
                      const BoxShadow(
                        color: Colors.white,
                        offset: Offset(-4, -4),
                        blurRadius: 10,
                      ),
                    ]),
                child: ListTile(
                  onTap: () {
                    // 1. Play the song
                    playSong(item.data![index].uri, index);

                    // 2. Navigate to the Dark Player Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MusicPlayerScreen(
                          song: item.data![index],
                          player: _player,
                          image: getRandomImage(index),
                        ),
                      ),
                    );
                  },
                  // 1. IMAGE
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(getRandomImage(index)),
                  ),

                  // 2. TEXT
                  title: Text(
                    item.data![index].title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isCurrentSong ? blueBackground : Colors.black87),
                  ),
                  subtitle: Text(item.data![index].artist ?? "Unknown Artist",
                      maxLines: 1),

                  // 3. PLAY/PAUSE BUTTON
                  trailing: IconButton(
                    icon: Icon(
                      (isCurrentSong && _isPlaying)
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                      color: blueBackground,
                      size: 35,
                    ),
                    onPressed: () {
                      if (isCurrentSong && _isPlaying) {
                        pauseSong();
                      } else {
                        playSong(item.data![index].uri, index);
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
