import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  String? _submittedName;
  int? _submittedAge;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _submittedName = _nameController.text;
        _submittedAge = int.parse(_ageController.text);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SkullBackground(),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 320,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.shade100,
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'User Form',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              hintText: 'At least 15 characters',
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.deepPurple.shade200,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.deepPurple,
                                  width: 2,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a name';
                              }
                              if (value.length < 15) {
                                return 'Min 15 characters (${value.length} entered)';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _ageController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Age',
                              hintText: 'Must be above 18',
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.deepPurple.shade200,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.deepPurple,
                                  width: 2,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an age';
                              }
                              final age = int.tryParse(value);
                              if (age == null) {
                                return 'Please enter a valid number';
                              }
                              if (age <= 18) {
                                return 'Age must be above 18';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          AnimatedSubmitButton(onPressed: _submit),
                        ],
                      ),
                    ),
                  ),
                  if (_submittedName != null && _submittedAge != null) ...[
                    const SizedBox(height: 24),
                    AnimatedResultCard(
                      name: _submittedName!,
                      age: _submittedAge!,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SkullBackground extends StatefulWidget {
  const SkullBackground({super.key});

  @override
  State<SkullBackground> createState() => _SkullBackgroundState();
}

class _SkullBackgroundState extends State<SkullBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  static const String skull =
      '         ##*******         \n'
      '     ###########*###%      \n'
      ' ###########%#*#%%###%%%   \n'
      ' %%#########%#######%#%%%% \n'
      ' %#%%%%#####%%%%%%#%%%#%%%#\n'
      '###%%%@@%%####%%#%%%%%%%#%%\n'
      '###%%%%%*+===+++****#####%%\n'
      '#%%#%#*=---===========+++*#\n'
      '%##*=-------==============*\n'
      '%#%*=-----------=---======#\n'
      '#%%+---==----========-----=\n'
      '%##--====+*##*+==+**#%#**+=\n'
      '=*+--=+*#@@##*=--=*#%%%##+=\n'
      '*#==----=+***+=-:-=+*****++=\n'
      '*=+=--::--------::-=======--\n'
      ' =+-----:-------=======---= \n'
      ' ---------==-=#**###+======  \n'
      ' ==----====----=++=====++=== \n'
      '   ---=====+=+*######*+++++  \n'
      '    ======++==++++*++++++++  \n'
      '     =========++***++++++++ \n'
      '     -=+++===---===+=+++*++ \n'
      '     -==+**+=++*********+== \n'
      '   +---==+****######****+==+\n'
      '======---===+++**#####***++=\n'
      '=========+=-=====+++***#****\n'
      '============+++=====+++*****\n'
      '==-=============+++++===++**\n'
      '-=====================+++++ \n'
      '--=======================+++ \n'
      '======+===================++ \n'
      '====+++======++============+ ';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          color: const Color(0xFF0D0D0D),
          child: LayoutBuilder(
            builder: (context, constraints) {
              const skullWidth = 200.0;
              const skullHeight = 220.0;
              const fontSize = 6.5;

              final cols = (constraints.maxWidth / skullWidth).ceil() + 1;
              final rows = (constraints.maxHeight / skullHeight).ceil() + 1;
              final offsetY = (_controller.value * skullHeight) % skullHeight;

              return ClipRect(
                child: Stack(
                  children: [
                    for (int row = -1; row < rows; row++)
                      for (int col = 0; col < cols; col++)
                        Positioned(
                          left:
                              col * skullWidth +
                              (row.isOdd ? skullWidth / 2 : 0),
                          top: row * skullHeight + offsetY,
                          child: Opacity(
                            opacity: 0.25,
                            child: Text(
                              skull,
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: fontSize,
                                color: Colors.deepPurple.shade200,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class AnimatedSubmitButton extends StatefulWidget {
  final VoidCallback onPressed;
  const AnimatedSubmitButton({super.key, required this.onPressed});

  @override
  State<AnimatedSubmitButton> createState() => _AnimatedSubmitButtonState();
}

class _AnimatedSubmitButtonState extends State<AnimatedSubmitButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _glowAnim;
  bool _isHovering = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _glowAnim = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHoverEnter() {
    setState(() => _isHovering = true);
    _controller.forward();
  }

  void _onHoverExit() {
    setState(() => _isHovering = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHoverEnter(),
      onExit: (_) => _onHoverExit(),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onPressed();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _isPressed ? 0.95 : _scaleAnim.value,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(
                        0.3 + (_glowAnim.value * 0.4),
                      ),
                      blurRadius: 8 + (_glowAnim.value * 16),
                      spreadRadius: _glowAnim.value * 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: _isHovering
                        ? [
                            Colors.deepPurple.shade300,
                            Colors.deepPurple.shade700,
                          ]
                        : [Colors.deepPurple, Colors.deepPurple.shade800],
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: const Text(
                  'Submit',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AnimatedResultCard extends StatefulWidget {
  final String name;
  final int age;
  const AnimatedResultCard({super.key, required this.name, required this.age});

  @override
  State<AnimatedResultCard> createState() => _AnimatedResultCardState();
}

class _AnimatedResultCardState extends State<AnimatedResultCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.deepPurple.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.shade100,
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Submitted Info',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const Divider(),
              const SizedBox(height: 4),
              Text(
                'Name: ${widget.name}',
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 6),
              Text('Age: ${widget.age}', style: const TextStyle(fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}
