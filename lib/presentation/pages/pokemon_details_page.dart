import 'package:flutter/material.dart';
import 'package:pokemon_card_list/core/utils/extensions.dart';
import 'package:pokemon_card_list/data/models/pokemon_card.dart';
import 'package:pokemon_card_list/presentation/widgets/network_image_widget.dart';

class PokemonDetailsPage extends StatefulWidget {
  final PokemonCard card;

  const PokemonDetailsPage({super.key, required this.card});

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
        .animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.card.name),
      ),
      body: Stack(
        children: [
          _buildBackgroundAnimation(),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCardImage(),
                  20.toVerticalSpace,
                  _buildCardInfo(),
                  20.toVerticalSpace,
                  _buildTypes(),
                  20.toVerticalSpace,
                  _buildWeaknesses(),
                  20.toVerticalSpace,
                  _buildAttacks(),
                  20.toVerticalSpace,
                  _buildSetInfo(),
                  20.toVerticalSpace,
                  _buildArtistInfo(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundAnimation() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context)
                    .cardColor
                    .withOpacity(_fadeInAnimation.value * 0.3),
                Theme.of(context)
                    .primaryColor
                    .withOpacity(_fadeInAnimation.value * 0.3),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardImage() {
    return ScaleTransition(
      scale: _fadeInAnimation,
      child: Hero(
        tag: widget.card.id,
        child: NetworkImageWidget(
          imageUrl: widget.card.images.large,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildCardInfo() {
    return FadeTransition(
      opacity: _fadeInAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.card.name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                8.toVerticalSpace,
                Text(
                  'Supertype: ${widget.card.supertype}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypes() {
    return _buildAnimatedSection(
      title: 'Types',
      children:
          widget.card.types.map((type) => Chip(label: Text(type))).toList(),
    );
  }

  Widget _buildWeaknesses() {
    return _buildAnimatedSection(
      title: 'Weaknesses',
      children: widget.card.weaknesses
          .map((weakness) =>
              Chip(label: Text('${weakness.type} ${weakness.value}')))
          .toList(),
    );
  }

  Widget _buildAttacks() {
    return _buildAnimatedSection(
      title: 'Attacks',
      children: widget.card.attacks
          .map((attack) => ExpansionTile(
                title: Text(attack.name),
                subtitle: Text('Damage: ${attack.damage}'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(attack.text),
                  ),
                  if (attack.cost.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Cost: ${attack.cost.join(", ")}'),
                    ),
                ],
              ))
          .toList(),
    );
  }

  Widget _buildSetInfo() {
    return _buildAnimatedSection(
      title: 'Set',
      children: [
        ListTile(
          title: Text(widget.card.set.name),
          subtitle: Text('Series: ${widget.card.set.series}'),
          trailing: Text('Total: ${widget.card.set.total}'),
        ),
        ListTile(
          title: const Text('Release Date'),
          trailing: Text(widget.card.set.releaseDate),
        ),
      ],
    );
  }

  Widget _buildArtistInfo() {
    return FadeTransition(
      opacity: _fadeInAnimation,
      child: ScaleTransition(
        scale: _fadeInAnimation,
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(Icons.brush, size: 24),
                8.toHorizontalSpace,
                Text(
                  'Artist: ${widget.card.artist}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedSection(
      {required String title, required List<Widget> children}) {
    return FadeTransition(
      opacity: _fadeInAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                8.toVerticalSpace,
                ...children,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
