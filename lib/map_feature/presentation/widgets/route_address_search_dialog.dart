import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/address_search_cubit.dart';
import '../../application/address_search_state.dart';
import '../../application/map_cubit.dart';
import '../../domain/address_suggestion_model.dart';
import '../../../core/constants/k_sizes.dart';

class RouteAddressSearchDialog extends StatefulWidget {
  final bool isStartPoint;

  const RouteAddressSearchDialog({
    super.key,
    required this.isStartPoint,
  });

  @override
  State<RouteAddressSearchDialog> createState() => _RouteAddressSearchDialogState();
}

class _RouteAddressSearchDialogState extends State<RouteAddressSearchDialog> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.isStartPoint ? 'Search Start Address' : 'Search Destination'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Column(
          children: [
            // Search input
            Container(
              padding: EdgeInsets.all(KSizes.margin4x),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: 'Enter address...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _controller.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _controller.clear();
                            context.read<AddressSearchCubit>().clearSearch();
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(KSizes.radiusDefault),
                  ),
                ),
                onChanged: (value) {
                  setState(() {}); // Update suffixIcon visibility
                  context.read<AddressSearchCubit>().searchAddresses(value);
                },
              ),
            ),
            // Search results
            Expanded(
              child: BlocBuilder<AddressSearchCubit, AddressSearchState>(
                builder: (context, state) {
                  if (state.isSearching) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Searching addresses...'),
                        ],
                      ),
                    );
                  }

                  if (state.hasSearchError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            state.searchErrorMessage ?? 'Search error',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }

                  if (!state.hasSuggestions && _controller.text.isNotEmpty) {
                    return const Center(
                      child: Text('No addresses found'),
                    );
                  }

                  if (_controller.text.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Enter an address to search',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: state.suggestions.length,
                    itemBuilder: (context, index) {
                      final suggestion = state.suggestions[index];
                      return ListTile(
                        leading: Icon(
                          Icons.location_on_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text(suggestion.shortDisplayName),
                        subtitle: suggestion.subtitle.isNotEmpty 
                            ? Text(suggestion.subtitle)
                            : null,
                        onTap: () {
                          _selectAddress(context, suggestion);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectAddress(BuildContext context, AddressSuggestion suggestion) {
    if (widget.isStartPoint) {
      context.read<MapCubit>().setAddressAsStartPoint(suggestion.coordinates);
    } else {
      context.read<MapCubit>().setAddressAsEndPoint(suggestion.coordinates);
    }
    
    context.read<AddressSearchCubit>().clearSearch();
    Navigator.of(context).pop();
  }
} 