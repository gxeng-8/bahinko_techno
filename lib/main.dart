import 'package:flutter/material.dart';
import 'models/person.dart';
import 'theme/app_colors.dart';
import 'widgets/avatar.dart';
import 'widgets/box.dart';
import 'widgets/pill.dart';
import 'widgets/btn.dart';
import 'utils/navigation.dart';
import 'widgets/app_page.dart';


void main() => runApp(const BahinKoApp());

// ---------- Theme colors ----------

class BahinKoApp extends StatelessWidget {
  const BahinKoApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BahinKo',
        theme: ThemeData(
          colorSchemeSeed: green,
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFF8FAF9),
        ),
        home: const Onboarding(),
      );
}

// ---------- Mock data (edit freely) ----------

const people = [
  Person('Mia', 'MI', green, 'Paid the bill', 'Paid'),
  Person('Jun', 'JU', orange, 'GCash', 'Owes ₱220'),
  Person('Ana', 'AN', purple, 'Maya', 'Paid'),
  Person('Leo', 'LE', deep, 'Cash', 'Owes ₱430'),
  Person('You', 'YO', Color(0xFF5ED38A), 'GCash', 'Owes ₱490'),
];

const items = [
  ('Pork Belly set', 890),
  ('Rice x5', 250),
  ('Iced Tea x2', 300),
  ('Soju', 420),
  ('Service and tax', 590),
];

const shares = [490, 610, 520, 430, 400];

void go(BuildContext c, Widget w) =>
    Navigator.push(c, MaterialPageRoute(builder: (_) => w));

// ---------- Reusable widgets ----------








// Shared screen layout: back button + title + body + optional bottom buttons


// ---------- 1. Onboarding ----------
class Onboarding extends StatelessWidget {
  const Onboarding({super.key});
  @override
  Widget build(BuildContext context) {
    const perks = [
      'Scan a receipt and list items automatically',
      'Assign who ordered what',
      'Track payments and send polite reminders',
      'Settle with GCash or Maya in one tap',
    ];
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF12A883), Color(0xFF056B52)]),
        ),
        child: SafeArea(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 24),
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(18)),
              child: const Center(
                  child: Text('LOGO',
                      style: TextStyle(color: green, fontWeight: FontWeight.bold))),
            ),
            const SizedBox(height: 24),
            const Text('BahinKo',
                style: TextStyle(
                    color: Colors.white, fontSize: 44, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            const Text('Split bills with friends without the awkward math.',
                style: TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 24),
            for (final p in perks)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(children: [
                  const Icon(Icons.check_circle, color: Colors.white70),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Text(p, style: const TextStyle(color: Colors.white))),
                ]),
              ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: Colors.white, foregroundColor: green),
                onPressed: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const Shell())),
                child: const Text('Get Started'),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
                child: Text('Your data stays private. We never hold your money.',
                    style: TextStyle(color: Colors.white70, fontSize: 12))),
          ]),
        ),
      ),
    );
  }
}

// ---------- Shell: bottom nav (Home / Stats) + scan FAB ----------
class Shell extends StatefulWidget {
  const Shell({super.key});
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int tab = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: IndexedStack(index: tab, children: const [Home(), Statistics()]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: green,
          shape: const CircleBorder(),
          onPressed: () => go(context, const ScanReceipt()),
          child: const Icon(Icons.qr_code_scanner, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: Icon(Icons.home_outlined, color: tab == 0 ? green : Colors.grey),
                  onPressed: () => setState(() => tab = 0)),
              IconButton(
                  icon: Icon(Icons.bar_chart, color: tab == 1 ? green : Colors.grey),
                  onPressed: () => setState(() => tab = 1)),
              const SizedBox(width: 48),
              IconButton(
                  icon: const Icon(Icons.description_outlined, color: Colors.grey),
                  onPressed: () => go(context, const Members())),
              IconButton(
                  icon: const Icon(Icons.person_outline, color: Colors.grey),
                  onPressed: () => go(context, const Privacy())),
            ],
          ),
        ),
      );
}

// ---------- 2. Home ----------
class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    const cats = [
      ('Dinner', Icons.coffee), ('Boarding', Icons.home_outlined),
      ('Trips', Icons.explore_outlined), ('Utilities', Icons.bolt),
      ('Subscriptions', Icons.repeat), ('Groceries', Icons.shopping_cart_outlined),
      ('Bills', Icons.description_outlined), ('More', Icons.grid_view),
    ];
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 56, 20, 28),
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFF12A883), Color(0xFF056B52)]),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(36)),
          ),
          child: Column(children: [
            const Text('Net balance', style: TextStyle(color: Colors.white70)),
            const Text('₱920.00',
                style: TextStyle(
                    color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Pill('Owed to you ₱1,240', bg: lime, fg: deep),
              const SizedBox(width: 8),
              Pill('You owe ₱320', bg: Colors.white, fg: Colors.red.shade600),
            ]),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Box(Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              _action(context, Icons.qr_code_scanner, 'Scan', const ScanReceipt()),
              _action(context, Icons.add, 'Add', const AssignItems()),
              _action(context, Icons.credit_card, 'Settle Up', const SettleUp()),
              _action(context, Icons.history, 'History', const SplitSummary()),
            ])),
            const Text('Group Categories',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
            const SizedBox(height: 8),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (final c in cats)
                  Column(children: [
                    CircleAvatar(
                        backgroundColor: mint, child: Icon(c.$2, color: green)),
                    const SizedBox(height: 4),
                    Text(c.$1, style: const TextStyle(fontSize: 11)),
                  ]),
              ],
            ),
            const Text('Active Groups',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
            const SizedBox(height: 8),
            SizedBox(
              height: 110,
              child: ListView(scrollDirection: Axis.horizontal, children: [
                _group(context, 'Dinner at Jaro', '5 members · 2 unpaid', '₱2,450',
                    green, Colors.white),
                _group(context, 'Boarding', '4 members', '₱3,800', lime, deep),
              ]),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget _action(BuildContext c, IconData i, String t, Widget to) => InkWell(
        onTap: () => go(c, to),
        child: Column(children: [
          CircleAvatar(backgroundColor: mint, child: Icon(i, color: green)),
          const SizedBox(height: 4),
          Text(t, style: const TextStyle(fontSize: 11)),
        ]),
      );

  Widget _group(BuildContext c, String name, String sub, String amt, Color bg,
          Color fg) =>
      GestureDetector(
        onTap: () => go(c, const GroupDetail()),
        child: Container(
          width: 240,
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.all(16),
          decoration:
              BoxDecoration(color: bg, borderRadius: BorderRadius.circular(18)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name,
                style: TextStyle(color: fg, fontWeight: FontWeight.w800, fontSize: 16)),
            Text(sub, style: TextStyle(color: fg.withAlpha(200), fontSize: 12)),
            const Spacer(),
            Text(amt,
                style: TextStyle(color: fg, fontWeight: FontWeight.w900, fontSize: 24)),
          ]),
        ),
      );
}

// ---------- 3. Group Detail ----------
class GroupDetail extends StatelessWidget {
  const GroupDetail({super.key});
  @override
  Widget build(BuildContext context) => AppPage(
        'Dinner at Jaro',
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Box(
              color: green,
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Total spent', style: TextStyle(color: Colors.white70)),
                Text('₱2,450',
                    style: TextStyle(
                        color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                Row(children: [
                  Pill('Paid by Mia', bg: lime, fg: deep),
                  SizedBox(width: 8),
                  Pill('2 unpaid', bg: Color(0xFFFFF3D6), fg: Color(0xFFB7791F)),
                ]),
              ])),
          Box(
            onTap: () => go(context, const Members()),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Members', style: TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Row(children: [
                for (final p in people)
                  Padding(padding: const EdgeInsets.only(right: 8), child: Avatar(p)),
              ]),
            ]),
          ),
          const Text('Expenses', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Box(
              onTap: () => go(context, const SplitSummary()),
              const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                      backgroundColor: mint, child: Icon(Icons.coffee, color: green)),
                  title: Text('Samgyup Dinner'),
                  subtitle: Text('Paid by Mia · split 5 ways'),
                  trailing: Text('₱2,450',
                      style: TextStyle(fontWeight: FontWeight.bold)))),
          const Box(
              ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                      backgroundColor: mint, child: Icon(Icons.coffee, color: green)),
                  title: Text('Milk Tea Run'),
                  subtitle: Text('Paid by You · split 3 ways'),
                  trailing: Text('₱380',
                      style: TextStyle(fontWeight: FontWeight.bold)))),
          const Box(Text('Activity history\nJun edited the price of Soju · 2h ago')),
        ]),
        bottom: Btn('+ Add Expense', () => go(context, const ScanReceipt())),
      );
}

// ---------- 4. Scan Receipt ----------
class ScanReceipt extends StatelessWidget {
  const ScanReceipt({super.key});
  @override
  Widget build(BuildContext context) => AppPage(
        'Scan Receipt',
        Column(children: [
          Box(Column(children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: mint, borderRadius: BorderRadius.circular(16)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('SAMGYUP HOUSE',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                for (final i in items)
                  Text('${i.$1}   ₱${i.$2}', style: const TextStyle(fontSize: 12)),
                const Text('TOTAL   2,450',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ]),
            ),
            const SizedBox(height: 12),
            const Text('Point your camera at the receipt. Items are listed for you.',
                textAlign: TextAlign.center),
            const SizedBox(height: 12),
            // TODO: hook up camera / ML Kit text recognition here
            Btn('Scan Receipt', () => go(context, const AssignItems())),
          ])),
          const Text('or'),
          const SizedBox(height: 8),
          Btn('Enter manually', () => go(context, const AssignItems()), outlined: true),
          const SizedBox(height: 16),
          const Box(
              color: lime,
              Text('Receipts are processed securely. You can delete them anytime.')),
        ]),
      );
}

// ---------- 5. Assign Items ----------
class AssignItems extends StatelessWidget {
  const AssignItems({super.key});
  @override
  Widget build(BuildContext context) {
    // who ordered each item (indexes into `people`); empty list = split equally
    const who = [[0, 1, 2], <int>[], [2, 4], [1, 3], <int>[]];
    return AppPage(
      'Assign Items',
      Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
          Text('Scanned 5 items'),
          Pill('1 needs review', bg: Color(0xFFFFF3D6), fg: Color(0xFFB7791F)),
        ]),
        const SizedBox(height: 12),
        for (var i = 0; i < items.length; i++)
          Box(Row(children: [
            Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(items[i].$1, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('₱${items[i].$2}'),
            ])),
            if (who[i].isEmpty)
              Pill(i == 1 ? 'All' : 'Split equally')
            else
              for (final p in who[i])
                Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Avatar(people[p], size: 30)),
          ])),
      ]),
      bottom: Column(mainAxisSize: MainAxisSize.min, children: [
        const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Total'),
          Text('₱2,450', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
        ]),
        const SizedBox(height: 8),
        Btn('Confirm Split', () => go(context, const SplitSummary())),
      ]),
    );
  }
}

// ---------- 6. Split Summary ----------
class SplitSummary extends StatelessWidget {
  const SplitSummary({super.key});
  @override
  Widget build(BuildContext context) => AppPage(
        'Split Summary',
        Box(Column(children: [
          const Text('Samgyup House',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
          const Text('Oct 20, 2026 · 5 people',
              style: TextStyle(color: Colors.grey, fontSize: 12)),
          const Divider(),
          for (final i in items)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(i.$1), Text('₱${i.$2}')]),
            ),
          const Divider(),
          const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('₱2,450',
                style: TextStyle(
                    color: green, fontSize: 20, fontWeight: FontWeight.w900)),
          ]),
          const SizedBox(height: 12),
          const Align(
              alignment: Alignment.centerLeft,
              child: Text('Each person pays',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          for (var i = 0; i < people.length; i++)
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: Avatar(people[i], size: 32),
              title: Text(people[i].name),
              trailing: Text('₱${shares[i]}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
        ])),
        actions: [IconButton(icon: const Icon(Icons.share), onPressed: () {})],
        bottom: Column(mainAxisSize: MainAxisSize.min, children: [
          Btn('Settle Up', () => go(context, const SettleUp())),
          const SizedBox(height: 8),
          Btn('Download report', () {}, outlined: true),
        ]),
      );
}

// ---------- 7. Settle Up ----------
class SettleUp extends StatelessWidget {
  const SettleUp({super.key});
  @override
  Widget build(BuildContext context) => AppPage(
        'Settle Up',
        Column(children: [
          const Box(
              color: lime,
              Text('✓ Smart settle: 2 transfers instead of 4',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Box(Column(children: [
            const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('You pay Mia', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('₱490', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(
                  child: FilledButton(
                      // TODO: open GCash with prefilled amount (url_launcher)
                      onPressed: () {},
                      child: const Text('Pay with GCash'))),
              const SizedBox(width: 8),
              Expanded(
                  child: FilledButton(
                      style: FilledButton.styleFrom(backgroundColor: Colors.black),
                      onPressed: () {},
                      child: const Text('Maya'))),
            ]),
            const Text('Amount is prefilled. You confirm in the payment app.',
                style: TextStyle(fontSize: 11, color: Colors.grey)),
          ])),
          Box(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Jun pays you', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('₱220', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
            ]),
            const Pill('Unpaid', bg: Color(0xFFFFF3D6), fg: Color(0xFFB7791F)),
            const SizedBox(height: 8),
            Btn('Send neutral reminder', () {}, outlined: true),
          ])),
          const Box(
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Ana paid you', style: TextStyle(fontWeight: FontWeight.bold)),
            Pill('Paid'),
            Text('₱180', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
          ])),
          TextButton(
              onPressed: () => go(context, const Privacy()),
              child: const Text('How we protect your data ›')),
        ]),
        bottom: Btn('Done', () => Navigator.popUntil(context, (r) => r.isFirst)),
      );
}

// ---------- 8. Statistics ----------
class Statistics extends StatelessWidget {
  const Statistics({super.key});
  @override
  Widget build(BuildContext context) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'];
    const paid = <double>[30, 50, 70, 25, 15, 45, 55];
    const owed = <double>[55, 110, 80, 60, 75, 70, 65];
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Center(
              child: Text('Statistics',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900))),
          const SizedBox(height: 16),
          const Text('Total owed to you'),
          const Text('₱4,820.00',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: deep)),
          const SizedBox(height: 12),
          const Text('Overview', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          // Simple bar chart. Swap for fl_chart later if you want.
          Box(SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (var i = 0; i < months.length; i++)
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Container(width: 10, height: paid[i], color: green),
                      const SizedBox(width: 2),
                      Container(width: 10, height: owed[i], color: const Color(0xFF5ED38A)),
                    ]),
                    const SizedBox(height: 4),
                    Text(months[i], style: const TextStyle(fontSize: 10)),
                  ]),
              ],
            ),
          )),
          Row(children: [
            Expanded(child: _stat('Collected', '₱4,820', deep, Icons.arrow_downward)),
            const SizedBox(width: 12),
            Expanded(child: _stat('Paid out', '₱3,150', green, Icons.arrow_upward)),
          ]),
        ]),
      ),
    );
  }

  Widget _stat(String l, String v, Color c, IconData i) => Container(
        padding: const EdgeInsets.all(16),
        decoration:
            BoxDecoration(color: c, borderRadius: BorderRadius.circular(16)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CircleAvatar(
              radius: 14,
              backgroundColor: Colors.white,
              child: Icon(i, size: 16, color: c)),
          const SizedBox(height: 24),
          Text(l, style: const TextStyle(color: Colors.white70)),
          Text(v,
              style: const TextStyle(
                  color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
        ]),
      );
}

// ---------- 9. Members ----------
class Members extends StatelessWidget {
  const Members({super.key});
  @override
  Widget build(BuildContext context) => AppPage(
        'Members',
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search member',
                  filled: true,
                  fillColor: mint,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none))),
          const SizedBox(height: 12),
          const Text('Dinner at Jaro members',
              style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          for (final p in people)
            Box(ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Avatar(p),
              title: Text(p.name),
              subtitle: Text(p.pay),
              trailing: Pill(p.status,
                  bg: p.status == 'Paid' ? mint : const Color(0xFFFFF3D6),
                  fg: p.status == 'Paid' ? green : const Color(0xFFB7791F)),
            )),
          Box(
              color: lime,
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Invite friends',
                    style: TextStyle(fontWeight: FontWeight.w800)),
                const Text(
                    'Share a link or QR code. Friends without the app can join as guests.',
                    style: TextStyle(fontSize: 12)),
                const SizedBox(height: 8),
                Btn('Copy invite link', () {}),
              ])),
        ]),
        actions: [IconButton(icon: const Icon(Icons.add), onPressed: () {})],
      );
}

// ---------- 10. Privacy and Trust ----------
class Privacy extends StatelessWidget {
  const Privacy({super.key});
  @override
  Widget build(BuildContext context) {
    const rows = [
      (Icons.shield_outlined, 'Clear privacy policy',
          'See what we collect, why we collect it, and how long we keep it.'),
      (Icons.lock_outline, 'Encrypted data',
          'Your expense history and receipts are encrypted in storage and in transit.'),
      (Icons.credit_card, 'We never hold your money',
          'Payments open GCash or Maya with the amount prefilled. You confirm there.'),
      (Icons.delete_outline, 'You control your receipts',
          'Receipt photos are only used to read items. Delete them anytime or set auto-delete.'),
    ];
    return AppPage(
      'Privacy and Trust',
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        for (final r in rows)
          Box(ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(backgroundColor: mint, child: Icon(r.$1, color: green)),
            title: Text(r.$2, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(r.$3, style: const TextStyle(fontSize: 12)),
          )),
        const Pill('GCash / Maya payment redirect', bg: lime, fg: deep),
      ]),
    );
  }
}