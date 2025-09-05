import 'package:flutter/material.dart';
import 'package:frontend/presentation/pages/result_page.dart';
import 'package:frontend/routes/app_navigate.dart';

import '../../data/api/result_api.dart';
import '../../data/models/dto/Response/ResultResponse.dart';
import '../../data/storage/login_storage.dart';
import '../widgets/cards/card_result_history.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/loadings/loading_wait_api.dart';

class ResultHistoryPage extends StatefulWidget {
  const ResultHistoryPage({super.key});

  @override
  State<ResultHistoryPage> createState() => _ResultHistoryPageState();
}

class _ResultHistoryPageState extends State<ResultHistoryPage> {
  final ResultApi resultApi = ResultApi();
  List<ResultResponse> results = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchResults();
  }

  Future<void> fetchResults() async {
    final login = await LoginStorage.getLogin(context);
    final studentID = login.userID;
    try {
      final data = await resultApi.findAllByStudentID(studentID);
      final filtered = data.where((r) => r.finish != null).toList();
      filtered.sort((a, b) => b.finish!.compareTo(a.finish!));

      setState(() {
        results = filtered;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: "Lịch sử làm bài"),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.only(top: 80),
        child: loading
            ? const LoadingWaitApi(text: "Đang tải dữ liệu...")
            : results.isEmpty
                ? const Center(
                    child: Text(
                      "Bạn chưa làm bài tập nào",
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final r = results[index];
                      return ResultHistoryCard(
                        result: r,
                        onTap: () {
                          AppNavigator.navigateTo(
                              context, ResultPage(result: r));
                        },
                      );
                    },
                  ),
      ),
    );
  }
}
