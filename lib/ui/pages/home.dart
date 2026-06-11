import 'package:flutter/material.dart';
import '../widgets/movie_card.dart';
import 'movie_detail.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  static const movieList = [
    {
      'title': 'Avatar: The Way of Water',
      'overview':
          'Jake Sully lives with his newfound family formed on the extrasolar moon Pandora. Once a familiar threat returns to finish what was previously started, Jake must work with Neytiri and the army of the Na\'vi race to protect their home.',
      'releaseDate': '2022',
      'rating': '7.6',
      'imageUrl':
          'https://m.media-amazon.com/images/M/MV5BNWI0Y2NkOWEtMmM2OC00MjQ3LWI1YzItZGQxYzQ3NzI4NWZmXkEyXkFqcGc@._V1_SY278_CR5,0,184,278_.jpg',
    },
    {
      'title': 'Interstellar',
      'overview':
          'In a dystopian future where Earth has become near-uninhabitable, a team of astronauts embark on a mission to find a new home for humanity.',
      'releaseDate': '2014',
      'rating': '8.7',
      'imageUrl':
          'https://m.media-amazon.com/images/M/MV5BYzdjMDAxZGItMjI2My00ODA1LTlkNzItOWFjMDU5ZDJlYWY3XkEyXkFqcGc@._V1_SY278_CR2,0,184,278_.jpg',
    },
    {
      'title': 'Top Gun: Maverick',
      'overview':
          'The story involves Maverick confronting his past while training a group of younger Top Gun graduates, including the son of his deceased best friend, for a dangerous mission.',
      'releaseDate': '2022',
      'rating': '8.3',
      'imageUrl':
          'https://m.media-amazon.com/images/M/MV5BMDBkZDNjMWEtOTdmMi00NmExLTg5MmMtNTFlYTJlNWY5YTdmXkEyXkFqcGc@._V1_SY139_CR1,0,92,139_.jpg',
    },
    {
      'title': 'The Batman',
      'overview':
          'When a sadistic serial killer begins murdering key political figures in Gotham, the Batman is forced to investigate the city\'s hidden corruption and question his family\'s involvement.',
      'releaseDate': '2022',
      'rating': '7.8',
      'imageUrl':
          'https://m.media-amazon.com/images/M/MV5BMmU5NGJlMzAtMGNmOC00YjJjLTgyMzUtNjAyYmE4Njg5YWMyXkEyXkFqcGc@._V1_SY278_CR2,0,184,278_.jpg',
    },
    {
      'title': 'Dune: Part Two',
      'overview':
          'Paul Atreides unites with the Fremen while on a warpath of revenge against the conspirators who destroyed his family. Facing a choice between the love of his life and the fate of the universe, he endeavors to prevent a terrible future.',
      'releaseDate': '2024',
      'rating': '8.6',
      'imageUrl':
          'https://m.media-amazon.com/images/M/MV5BNTc0YmQxMjEtODI5MC00NjFiLTlkMWUtOGQ5NjFmYWUyZGJhXkEyXkFqcGc@._V1_SY278_CR2,0,184,278_.jpg',
    },
    {
      'title': 'Inception',
      'overview':
          'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a CEO, but his tragic past may doom the project and his team to disaster.',
      'releaseDate': '2010',
      'rating': '8.8',
      'imageUrl':
          'https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_SY278_CR2,0,184,278_.jpg',
    },
    {
      'title': 'Spider-Man: Into the Spider-Verse',
      'overview':
          'Teen Miles Morales becomes the Spider-Man of his universe and must join with five spider-powered individuals from other dimensions to stop a threat for all realities.',
      'releaseDate': '2018',
      'rating': '8.4',
      'imageUrl':
          'https://m.media-amazon.com/images/M/MV5BMjMwNDkxMTgzOF5BMl5BanBnXkFtZTgwNTkwNTQ3NjM@._V1_SY278_CR1,0,184,278_.jpg',
    },
  ];

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: Home.movieList.length,
          itemBuilder: (context, index) {
            final movie = Home.movieList[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetail(
                      title: movie['title'] ?? 'Unknown',
                      overview: movie['overview'] ?? 'No overview available',
                      releaseDate: movie['releaseDate'] ?? 'Unknown',
                      rating: movie['rating'] ?? 'Unknown',
                      imageUrl: movie['imageUrl'] ?? '',
                    ),
                  ),
                );
              },
              child: MovieCard(
                title: movie['title'] ?? 'Unknown',
                overview: movie['overview'] ?? 'No overview available',
                releaseDate: movie['releaseDate'] ?? 'Unknown',
                rating: movie['rating'] ?? 'Unknown',
                imageUrl: movie['imageUrl'] ?? '',
              ),
            );
          },
        ),
      ),
    );
  }
}
