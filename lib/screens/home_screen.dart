
import 'package:flutter/material.dart';

import '../models/note.dart';
import '../services/auth_service.dart';
import '../services/note_service.dart';
import 'login_screen.dart';
import 'note_form_screen.dart';

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;

  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.locale,
    required this.onLocaleChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> _notes = [];
  bool _isLoading = true;
  String? _error;
  final TextEditingController _searchController =
      TextEditingController();
  Locale _locale = const Locale('en');
  ThemeMode _themeMode = ThemeMode.light;

  void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void changeTheme(bool isDark) {
    setState(() {
      _themeMode =
          isDark ? ThemeMode.dark : ThemeMode.light;
    });}
  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadNotes() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final notes = await NoteService.getNotes();

      if (!mounted) return;

      setState(() {
        _notes = notes;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _error = 'Could not load notes.';
        _isLoading = false;
      });
    }
  }

  List<Note> get _filteredNotes {
    final query = _searchController.text.toLowerCase();

    return _notes.where((note) {
      return note.title.toLowerCase().contains(query) ||
          note.content.toLowerCase().contains(query);
    }).toList();
  }

  Future<void> _openNoteForm({Note? note}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NoteFormScreen(note: note),
      ),
    );

    if (result == true) {
      _loadNotes();
    }
  }

  Future<void> _deleteNote(Note note) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete note?'),
        content: const Text(
          'Are you sure you want to delete this note?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await NoteService.deleteNote(note.id);
      _loadNotes();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Note deleted')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not delete note'),
          ),
        );
      }
    }
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log out'),
        content: const Text(
          'Are you sure you want to log out?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Log out'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await AuthService.logout();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
      (route) => false,
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFFBDBF09),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                widget.locale.languageCode == 'ar'
                    ? 'الإعدادات'
                    : 'Settings',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // Dark mode
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: Text(
              widget.locale.languageCode == 'ar'
                  ? 'الوضع الداكن'
                  : 'Dark Mode',
            ),
            value: widget.isDarkMode,
            onChanged: widget.onThemeChanged,
          ),

          const Divider(),

          // Language
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(
              widget.locale.languageCode == 'ar'
                  ? 'اللغة'
                  : 'Language',
            ),
            trailing: DropdownButton<Locale>(
              value: widget.locale,
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(
                  value: Locale('en'),
                  child: Text('English'),
                ),
                DropdownMenuItem(
                  value: Locale('ar'),
                  child: Text('العربية'),
                ),
              ],
              onChanged: (locale) {
                if (locale != null) {
                  widget.onLocaleChanged(locale);
                }
              },
            ),
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(
              widget.locale.languageCode == 'ar'
                  ? 'تسجيل الخروج'
                  : 'Log out',
            ),
            onTap: _logout,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = widget.locale.languageCode == 'ar';

    return Directionality(
      textDirection:
          isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        drawer: _buildDrawer(),

        appBar: AppBar(
          title: Text(isArabic ? 'ملاحظاتي' : 'My Notes'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _loadNotes,
              tooltip: isArabic ? 'تحديث' : 'Refresh',
            ),
          ],
        ),

        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: isArabic
                      ? 'ابحث في ملاحظاتك...'
                      : 'Search notes...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),

            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _error != null
                      ? Center(
                          child: Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Text(_error!),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: _loadNotes,
                                child: Text(
                                  isArabic ? 'إعادة المحاولة' : 'Retry',
                                ),
                              ),
                            ],
                          ),
                        )
                      : _filteredNotes.isEmpty
                          ? Center(
                              child: Text(
                                _searchController.text.isEmpty
                                    ? (isArabic
                                        ? 'لا توجد ملاحظات بعد'
                                        : 'No notes yet')
                                    : (isArabic
                                        ? 'لا توجد نتائج'
                                        : 'No results found'),
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: _loadNotes,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(12),
                                itemCount: _filteredNotes.length,
                                itemBuilder: (context, index) {
                                  final note =
                                      _filteredNotes[index];

                                  return Card(
                                    margin: const EdgeInsets.only(
                                      bottom: 12,
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        note.title,
                                        style: const TextStyle(
                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        note.content,
                                        maxLines: 2,
                                        overflow:
                                            TextOverflow.ellipsis,
                                      ),
                                      onTap: () =>
                                          _openNoteForm(note: note),
                                      trailing: IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () =>
                                            _deleteNote(note),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
            ),
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () => _openNoteForm(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
