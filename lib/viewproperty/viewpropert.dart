import 'package:commercilapp/constant/colorconstant.dart';
import 'package:flutter/material.dart';


class SubDetails extends StatefulWidget {
  const SubDetails({super.key});

  @override
  State<SubDetails> createState() => _SubDetailsState();
}

class _SubDetailsState extends State<SubDetails> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<int> items =
      List.generate(150, (index) => index + 1); // Example data (1 to 150)
  int? selectedIndex;
  int currentPage = 1;
  int itemsPerPage = 10;

  void _handleItemTap(int index) {
    setState(() {
      selectedIndex = index;
      currentPage = (index ~/ itemsPerPage) + 1;
    });
  }

  void _goToNextPage() {
    if (currentPage * itemsPerPage < items.length) {
      setState(() {
        currentPage++;
      });
    }
  }

  void _goToPreviousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = (currentPage * itemsPerPage).clamp(0, items.length);
    List<int> visibleItems = items.sublist(startIndex, endIndex);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
     
     
    );
  }
}
