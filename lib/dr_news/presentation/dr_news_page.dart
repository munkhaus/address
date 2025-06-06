import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // For DR logo (antaget SVG)

// For at bruge Google Fonts, tilføj `google_fonts: ^6.1.0` (eller seneste version) til din pubspec.yaml
// import 'package:google_fonts/google_fonts.dart';

class DRNewsPage extends StatelessWidget {
  const DRNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    // Simuleret DR logo (brug dit eget asset)
    final String drLogoSvg = '''
    <svg viewBox="0 0 100 40" xmlns="http://www.w3.org/2000/svg">
      <rect width="25" height="40" fill="#E30613"/>
      <text x="30" y="30" font-family="Arial, sans-serif" font-size="30" font-weight="bold" fill="#000000">DR</text>
    </svg>
    ''';

    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: AppBar(
        automaticallyImplyLeading: false, // Fjerner standard tilbage-knap hvis dette er hovedsiden
        title: Row(
          children: [
            // Erstat med dit faktiske logo asset
            // SvgPicture.asset('assets/dr_logo.svg', height: 30)
            // Eller en simpel tekst-repræsentation:
            SvgPicture.string(drLogoSvg, height: 28), // Simuleret logo
            const Spacer(),
            _navLink("NYHEDER", isActive: true),
            const SizedBox(width: 20),
            _navLink("DRTV"),
            const SizedBox(width: 20),
            _navLink("DR LYD"),
            const Spacer(flex: 2),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "LOG IND",
              style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Kontakt DR",
              style: TextStyle(color: Colors.black54, fontSize: 12),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
        bottom: PreferredSize( // Den tynde grå linje i bunden af appbaren
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[300],
            height: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _navLink(String text, {bool isActive = false}) {
    return Text(
      text,
      style: TextStyle(
        color: isActive ? Colors.black : Colors.black54,
        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        fontSize: 14,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildNewsTicker(context),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder( // Brug LayoutBuilder for potentiel responsivitet
              builder: (context, constraints) {
                bool isWideScreen = constraints.maxWidth > 800; // Juster breakpoint efter behov
                if (isWideScreen) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 7, // Juster flex for at matche DRs layout (ca. 2/3)
                        child: _buildMainStory(context),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 3, // Juster flex for at matche DRs layout (ca. 1/3)
                        child: _buildSidebar(context),
                      ),
                    ],
                  );
                } else {
                  // Stack elementerne vertikalt på mindre skærme
                  return Column(
                    children: [
                      _buildMainStory(context),
                      const SizedBox(height: 20),
                      _buildSidebar(context),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsTicker(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            color: Theme.of(context).primaryColor,
            child: const Text(
              "Seneste nyt >",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              height: 20, // Begræns højden for ticker-teksten
              child: ListView( // Simpel horisontal scroll, kan forbedres med PageView eller lign. for auto-scroll
                scrollDirection: Axis.horizontal,
                children: [
                  _tickerItem("3 min. siden", "Med otte hak i renten har centralbank givet gave efter gave til risikovillige boligejere"),
                  _tickerItem("6 min. siden", "Det er slut med 'usundt' hashtag på TikTok, men ekspert tror ikke, at det hjælper"),
                  _tickerItem("17 min. siden", "LIVE: Team Esbjerg og Odense Håndbold brager sammen i DM-duel"),
                  _tickerItem("36 min. siden", "AaB-fans: De tyske ejere skal helt ud af klubben"),
                ].map((widget) => Padding(padding: const EdgeInsets.only(right: 20), child: widget)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tickerItem(String time, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "$time ",
          style: const TextStyle(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.w600),
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.black, fontSize: 12),
          overflow: TextOverflow.ellipsis, // For at undgå overflow hvis teksten er for lang
          maxLines: 1,
        ),
      ],
    );
  }

  Widget _buildMainStory(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            // Placeholder container instead of network image
            Container(
              width: double.infinity,
              height: 400,
              color: Colors.grey[300],
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Hovedhistorie Billede',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                color: Colors.black.withOpacity(0.7),
                child: const Text(
                  "ECB sænker renten",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 12),
        Text(
          "Penge",
          style: TextStyle(color: Colors.grey[700], fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text(
          "Med otte hak i renten har centralbank givet gave efter gave til risikovillige boligejere",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            // For at efterligne DR's font, brug evt. en specifik font-familie
            // fontFamily: 'DR Public Sans', // Hvis du har en custom font
          ),
        ),
      ],
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Column(
      children: [
        _buildSidebarStory(
          context,
          imageUrl: 'https://via.placeholder.com/300x180/AFAFAF/FFFFFF?text=TikTok+Artikel', // Placeholder
          category: "Indland",
          headline: "Det er slut med 'usundt' hashtag på TikTok, men ekspert tror ikke, at det hjælper",
        ),
        const SizedBox(height: 20),
        _buildSidebarStory(
          context,
          imageUrl: 'https://via.placeholder.com/300x180/AFAFAF/FFFFFF?text=AaB+Fans+Artikel', // Placeholder
          category: "Fodbold",
          headline: "AaB-fans: De tyske ejere skal helt ud af klubben",
        ),
        // Tilføj flere historier efter behov
      ],
    );
  }

  Widget _buildSidebarStory(BuildContext context, {required String imageUrl, required String category, required String headline}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 150,
          color: Colors.grey[300],
          child: const Center(
            child: Icon(
              Icons.image,
              size: 32,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          category.toUpperCase(),
          style: TextStyle(color: Colors.grey[700], fontSize: 11, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          headline,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600, // Lidt mindre fed end hovedhistorien
          ),
        ),
      ],
    );
  }
} 