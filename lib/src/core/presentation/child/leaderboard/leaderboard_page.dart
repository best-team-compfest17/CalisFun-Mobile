import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../constants/constants.dart';
import 'leaderboard_controller.dart';


class LeaderboardPage extends ConsumerStatefulWidget {
  const LeaderboardPage({super.key, required this.childId});
  final String childId;

  @override
  ConsumerState<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends ConsumerState<LeaderboardPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(leaderboardControllerProvider.notifier)
          .bootstrap(childId: widget.childId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(leaderboardControllerProvider);
    final ctrl = ref.read(leaderboardControllerProvider.notifier);

    return Scaffold(
      backgroundColor: ColorApp.mainWhite,
      body: RefreshIndicator(
        onRefresh: ctrl.fetch,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeApp.w16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap.h80,
                Text('Peringkat', style: TypographyApp.headingLargeBoldPrimary),
                Gap.h16,

                if (state.isLoading) const Center(child: CircularProgressIndicator()),
                if (state.error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text('Terjadi kesalahan: ${state.error}',
                        style: TypographyApp.bodyNormalRegular.copyWith(color: Colors.red)),
                  ),

                if (!state.isLoading && state.users.isNotEmpty)
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: ctrl.top3.map((item) {
                        final color = item.rank == 1
                            ? Colors.amber
                            : item.rank == 2
                            ? Colors.grey
                            : Colors.brown;
                        final radius = item.rank == 1 ? 50.0 : 40.0;

                        return Column(
                          children: [
                            if (item.rank == 1)
                              const Icon(Icons.emoji_events, color: Colors.amber, size: 32),
                            if (item.rank == 1) const SizedBox(height: 4),
                            Text(item.user.name, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: color, width: 4),
                              ),
                              child: CircleAvatar(
                                radius: radius,
                                backgroundImage: const NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRqUaGFKWrrv_RskYoykH2ONRynGRAAG6F0A&s',
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text('${item.rank}',
                                style: TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.bold)),
                          ],
                        );
                      }).toList(),
                    ),
                  ),

                Gap.h12,
                InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(color: ColorApp.primary, borderRadius: BorderRadius.circular(24)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Peringkatmu saat ini',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Text(
                              state.yourRank?.toString() ?? '-',
                              style: TextStyle(color: ColorApp.mainBlack, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Gap.h12,
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ctrl.listAfterTop3.length,
                  itemBuilder: (context, index) {
                    final item = ctrl.listAfterTop3[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Row(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              const CircleAvatar(
                                radius: 22,
                                backgroundImage: NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRqUaGFKWrrv_RskYoykH2ONRynGRAAG6F0A&s',
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(color: ColorApp.darkBlue, borderRadius: BorderRadius.circular(12)),
                                child: Text('${item.rank}',
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.user.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                Text('Level ${item.user.level}', style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(color: Colors.amber.withOpacity(0.2), borderRadius: BorderRadius.circular(16)),
                            child: Text('${item.user.xp} xp',
                                style: TextStyle(color: ColorApp.mainBlack, fontWeight: FontWeight.bold, fontSize: 14)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Gap.h24,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
