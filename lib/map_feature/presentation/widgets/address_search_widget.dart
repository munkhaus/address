import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/k_sizes.dart';
import '../../application/address_search_cubit.dart';
import '../../application/address_search_state.dart';
import '../../domain/address_suggestion_model.dart';

class AddressSearchWidget extends StatefulWidget {
  final Function(AddressSuggestion) onAddressSelected;
  final TextEditingController? controller;
  final String? hintText;

  const AddressSearchWidget({
    super.key,
    required this.onAddressSelected,
    this.controller,
    this.hintText,
  });

  @override
  State<AddressSearchWidget> createState() => _AddressSearchWidgetState();
}

class _AddressSearchWidgetState extends State<AddressSearchWidget> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    
    // Listen to focus changes to show/hide suggestions
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        context.read<AddressSearchCubit>().showSuggestions();
      }
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressSearchCubit, AddressSearchState>(
      listener: (context, state) {
        // Update text field when suggestion is selected
        if (state.selectedSuggestion != null) {
          _controller.text = state.currentQuery;
          widget.onAddressSelected(state.selectedSuggestion!);
        }
      },
      child: Container(
        margin: EdgeInsets.all(KSizes.margin4x),
        child: Column(
          children: [
            // Search text field
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(KSizes.radiusL),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: widget.hintText ?? 'Søg adresse...',
                  prefixIcon: Icon(
                    Icons.search,
                    size: KSizes.iconM,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  suffixIcon: _buildSuffixIcon(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(KSizes.radiusL),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: KSizes.margin4x,
                    vertical: KSizes.margin3x,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                ),
                onChanged: (value) {
                  context.read<AddressSearchCubit>().searchAddresses(value);
                },
                onTap: () {
                  context.read<AddressSearchCubit>().showSuggestions();
                },
              ),
            ),
            
            // Suggestions list
            BlocBuilder<AddressSearchCubit, AddressSearchState>(
              builder: (context, state) {
                if (!state.shouldShowSuggestions) {
                  return const SizedBox.shrink();
                }

                return Container(
                  margin: EdgeInsets.only(top: KSizes.margin1x),
                  constraints: BoxConstraints(
                    maxHeight: KSizes.suggestionListMaxHeight,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(KSizes.radiusL),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: _buildSuggestionsList(state),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    return BlocBuilder<AddressSearchCubit, AddressSearchState>(
      builder: (context, state) {
        if (state.isSearching) {
          return Container(
            padding: EdgeInsets.all(KSizes.margin3x),
            child: SizedBox(
              width: KSizes.iconS,
              height: KSizes.iconS,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          );
        }

        if (_controller.text.isNotEmpty) {
          return IconButton(
            icon: Icon(
              Icons.clear,
              size: KSizes.iconM,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            onPressed: () {
              _controller.clear();
              context.read<AddressSearchCubit>().clearSearch();
              _focusNode.unfocus();
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildSuggestionsList(AddressSearchState state) {
    if (state.isSearching) {
      return Container(
        padding: EdgeInsets.all(KSizes.margin4x),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(height: KSizes.margin2x),
              Text(
                'Søger adresser...',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (state.hasSearchError) {
      return Container(
        padding: EdgeInsets.all(KSizes.margin4x),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: KSizes.iconL,
                color: Theme.of(context).colorScheme.error,
              ),
              SizedBox(height: KSizes.margin2x),
              Text(
                state.searchErrorMessage ?? 'Search error',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    if (!state.hasSuggestions) {
      return Container(
        padding: EdgeInsets.all(KSizes.margin4x),
        child: Center(
          child: Text(
            'Ingen adresser fundet',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.all(KSizes.margin2x),
      itemCount: state.suggestions.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        color: Theme.of(context).colorScheme.outlineVariant,
      ),
      itemBuilder: (context, index) {
        final suggestion = state.suggestions[index];
        return ListTile(
          leading: Icon(
            Icons.location_on_outlined,
            size: KSizes.iconM,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            suggestion.shortDisplayName,
            style: Theme.of(context).textTheme.bodyLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: suggestion.subtitle.isNotEmpty
              ? Text(
                  suggestion.subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              : null,
          onTap: () {
            context.read<AddressSearchCubit>().selectSuggestion(suggestion);
            _focusNode.unfocus();
          },
        );
      },
    );
  }
} 