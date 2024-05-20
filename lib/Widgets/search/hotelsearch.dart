import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectf/Cubits/search_cubits/hotel_search_cubit/hotel_search_cubit.dart';
import 'package:projectf/Cubits/search_cubits/hotel_search_cubit/hotel_search_state.dart';
import 'package:projectf/Screens/details_screen.dart';
import 'package:projectf/Widgets/searchWidegts/search_hotel_card.dart';
import 'package:projectf/constant.dart';

class SearchHotelPage extends StatelessWidget {
  const SearchHotelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => HotelSearchCubit(hotelList1),
          child: const SearchPageContent(),
        ),
      ),
    );
  }
}

class SearchPageContent extends StatelessWidget {
  const SearchPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                ),
              ),
              suffixIcon: const Icon(
                Icons.search,
              ),
              hintText: 'Search',
              hintStyle: Styles.headlineStyle1.copyWith(fontSize: 20),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) {
              context.read<HotelSearchCubit>().search(value);
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<HotelSearchCubit, HotelSearchState>(
            builder: (context, state) {
              if (state is InitialHotelSearchState) {
                return buildHotelList(state.hotelList);
              } else if (state is SearchingHotelState) {
                return buildHotelList(state.hotelList);
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }

  Widget buildHotelList(List<Map<String, dynamic>> hotelList) {
    return ListView.builder(
      itemCount: hotelList.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> hotel = hotelList[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    itemDetails: hotel,
                    ishotel: true,
                  ),
                ),
              );
            },
            child: SearchHotelCard(
              image: 'assets/images/hotels/${hotel['image']}',
              name: hotel['name'].toString(),
              place: hotel['place'].toString(),
              price: hotel['price'].toString(),
            ),
          ),
        );
      },
    );
  }
}
