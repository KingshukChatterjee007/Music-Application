import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// FIXED IMPORT: Pointing directly to the file in the bloc folder
import 'package:music_app/bloc/boarding_bloc.dart';
import 'package:music_app/res/app_colors.dart';
import 'package:music_app/view/home/home_view.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BoardingBLoc>();

    return Scaffold(
      backgroundColor: backgroundColor,
      // Floating "Let's Go" Button
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30, right: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
            child: InkWell(
              onTap: () {
                // If we are on the last page (index 2), go to Home
                if (bloc.state.index >= 2) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const HomeView()));
                } else {
                  // Otherwise, go to next page
                  bloc.add(OnPageChangeEvent(index: bloc.state.index + 1));
                }
              },
              child: Container(
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Let\'s go', style: TextStyle(color: Colors.blue)),
                    SizedBox(width: 5),
                    Icon(Icons.arrow_forward_rounded, color: Colors.blue)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // The Page View (Swipable area)
            PageView(
              controller: bloc.pageController,
              onPageChanged: (value) =>
                  bloc.add(OnPageChangeEvent(index: value)),
              children: const [
                _BoardingPage(
                    title: "Feel the Beat",
                    text: "Immerse yourself in the world of music."),
                _BoardingPage(
                    title: "Customize Your Beast",
                    text: "Create your own playlists and enjoy."),
                _BoardingPage(
                    title: "Vibe Together",
                    text: "Share your favorite tracks with friends."),
              ],
            ),

            // The Dots Indicator
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: BlocBuilder<BoardingBLoc, BoardingState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: state.index == index ? 10 : 8,
                        width: state.index == index ? 10 : 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: state.index == index
                              ? blueBackground
                              : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper Widget for the pages
class _BoardingPage extends StatelessWidget {
  final String title;
  final String text;
  const _BoardingPage({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: shadowColor,
                  offset: const Offset(8, 6),
                  blurRadius: 12),
              const BoxShadow(
                  color: Colors.white, offset: Offset(-8, -6), blurRadius: 12),
            ],
          ),
          child: Icon(Icons.music_note, size: 80, color: blueBackground),
        ),
        const SizedBox(height: 50),
        Text(
          title,
          style: TextStyle(
              color: blueBackground, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        const SizedBox(height: 10),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}
