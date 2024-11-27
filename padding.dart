class FetchDataScreen extends StatefulWidget {
  const FetchDataScreen({super.key});

  @override
  FetchDataScreenState createState() => FetchDataScreenState();
}

class FetchDataScreenState extends State<FetchDataScreen> {
  String? fetchedData;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('https://raw.githubusercontent.com/hina06botify/my-update-view/main/update_key_value.txt'),
      );

      if (response.statusCode == 200) {
        setState(() {
          fetchedData = response.body;
          log("get api data:-$fetchedData");
          Widget data = jsonDecode(fetchedData ?? "");
          log("get decoded data :-$data");
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e, st) {
      setState(() {
        isLoading = false;
        log('Error: $e ==== $st');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data Example'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : fetchedData != null
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      fetchedData!,
                      style: const TextStyle(fontSize: 16),
                    ),
                  )
                : const Text('No data fetched.'),
      ),
    );
  }
}
