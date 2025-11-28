import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicPlayerScreen extends StatefulWidget {
  final SongModel song;
  final AudioPlayer player;
  final String image;

  const MusicPlayerScreen({
    super.key,
    required this.song,
    required this.player,
    required this.image,
  });

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    widget.player.playerStateStream.listen((state) {
      if (mounted) {
        setState(() {
          isPlaying = state.playing;
        });
      }
    });
  }

  String _formatDuration(Duration? duration) {
    if (duration == null) return "--:--";
    String minutes = duration.inMinutes.toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C), // Dark Background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Now Playing",
            style: TextStyle(color: Colors.white, fontSize: 14)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. ALBUM ART
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(widget.image),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ]),
            ),
            const SizedBox(height: 40),

            // 2. TITLE & ARTIST
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.song.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.song.artist ?? "Unknown Artist",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.6), fontSize: 16),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border,
                        color: Colors.white, size: 28)),
              ],
            ),
            const SizedBox(height: 20),

            // 3. PROGRESS BAR
            StreamBuilder<Duration>(
                stream: widget.player.positionStream,
                builder: (context, snapshot) {
                  final position = snapshot.data ?? Duration.zero;
                  final total = widget.player.duration ?? Duration.zero;

                  return Column(
                    children: [
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 6),
                          trackHeight: 2,
                          activeTrackColor: Colors.white,
                          inactiveTrackColor: Colors.white.withOpacity(0.2),
                          thumbColor: Colors.white,
                        ),
                        child: Slider(
                          min: 0,
                          max: total.inMilliseconds.toDouble(),
                          value: position.inMilliseconds
                              .toDouble()
                              .clamp(0, total.inMilliseconds.toDouble()),
                          onChanged: (value) {
                            widget.player
                                .seek(Duration(milliseconds: value.toInt()));
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_formatDuration(position),
                                style: const TextStyle(
                                    color: Colors.white60, fontSize: 12)),
                            Text(_formatDuration(total),
                                style: const TextStyle(
                                    color: Colors.white60, fontSize: 12)),
                          ],
                        ),
                      )
                    ],
                  );
                }),
            const SizedBox(height: 20),

            // 4. CONTROLS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.shuffle, color: Colors.white60)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.skip_previous_rounded,
                        color: Colors.white, size: 40)),

                // PLAY/PAUSE BUTTON
                GestureDetector(
                  onTap: () {
                    if (widget.player.playing) {
                      widget.player.pause();
                    } else {
                      widget.player.play();
                    }
                  },
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(
                      isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: Colors.black,
                      size: 40,
                    ),
                  ),
                ),

                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.skip_next_rounded,
                        color: Colors.white, size: 40)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.loop, color: Colors.white60)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
