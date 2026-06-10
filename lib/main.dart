import 'package:flutter/material.dart';

void main() => runApp(const PlaylistApp());

/// Root of the demo app.
class PlaylistApp extends StatelessWidget {
  const PlaylistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListTile Demo — My Playlist',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const PlaylistScreen(),
    );
  }
}

/// A simple song model: title, artist, duration.
class Song {
  final String title;
  final String artist;
  final String duration;
  const Song(this.title, this.artist, this.duration);
}

/// The playlist data shown in the list.
const List<Song> songs = [
  Song('Lo-Fi Sunrise', 'Kaya Beats', '3:12'),
  Song('Kigali Nights', 'The 250 Band', '3:47'),
  Song('Golden Hour', 'Amara', '4:05'),
  Song('Midnight Drive', 'Echo Lane', '2:58'),
  Song('Ocean Steps', 'Mojo & Keys', '3:21'),
  Song('Paper Planes Home', 'Nia Rivers', '3:40'),
];

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  /// Index of the song currently "playing". -1 means nothing yet.
  int nowPlaying = -1;

  /// Songs the user has liked (toggled from the trailing icon).
  final Set<int> liked = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Playlist'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.music_note),
          ),
        ],
      ),

      // ListView.builder repeats ONE ListTile pattern for every song.
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
          final bool isPlaying = index == nowPlaying;

          // ================= THE WIDGET BEING DEMONSTRATED =================
          return ListTile(
            // PROPERTY 1: leading — widget at the START of the row.
            // Default: null (title text shifts to the left edge).
            // Here: a CircleAvatar acting as simple "album art".
            leading: CircleAvatar(
              backgroundColor:
                  isPlaying ? Colors.deepPurple : Colors.deepPurple.shade300,
              child: Icon(
                isPlaying ? Icons.play_arrow : Icons.music_note,
                color: Colors.white,
              ),
            ),

            title: Text(
              song.title,
              style: TextStyle(
                fontWeight: isPlaying ? FontWeight.bold : FontWeight.w600,
              ),
            ),
            subtitle: Text(song.artist),

            // PROPERTY 2: trailing — widget at the END of the row.
            // Default: null (row simply ends after the text).
            // Here: a like button + the song duration.
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    liked.contains(index)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.deepPurple,
                  ),
                  onPressed: () {
                    setState(() {
                      liked.contains(index)
                          ? liked.remove(index)
                          : liked.add(index);
                    });
                  },
                ),
                Text(song.duration),
              ],
            ),

            // PROPERTY 3: tileColor — background color of the tile.
            // Default: transparent.
            // Here: a light purple highlight marks the "Now Playing" song.
            tileColor:
                isPlaying ? Colors.deepPurple.shade50 : Colors.transparent,

            // onTap makes the WHOLE row tappable — tap anywhere to play.
            onTap: () => setState(() => nowPlaying = index),
          );
          // =================================================================
        },
      ),

      // Small "Now Playing" bar so onTap has a visible effect.
      bottomNavigationBar: nowPlaying == -1
          ? null
          : Container(
              color: Colors.deepPurple,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Icon(Icons.graphic_eq, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Now Playing:  ${songs[nowPlaying].title} — '
                      '${songs[nowPlaying].artist}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}