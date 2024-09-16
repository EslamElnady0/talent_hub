import 'package:flutter/material.dart';

class DescPostSection extends StatelessWidget {
  const DescPostSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Cristiano Ronaldo dos Santos Aveiro GOIH ComM (Portuguese pronunciation: [kɾiʃˈtjɐnu ʁɔˈnaldu]; born 5 February 1985) is a Portuguese professional footballer who plays as a forward for and captains both Saudi Pro League club Al Nassr and the Portugal national team. Widely regarded as one of the greatest players of all time, Ronaldo has won five.",
      overflow: TextOverflow.ellipsis,
      maxLines: 4,
    );
  }
}
