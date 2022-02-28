## Getting Started
Flutter puzzle hack (literally) challange
Please read ./docs/idea.md to get started

## Styling
Conform to lint style from lint_rules.yaml
Code is formatted to 110 characters per line

For VScode change these settings:
```json
"dart.lineLength": 110,
"[dart]": {
    "editor.rulers": [
        110
    ],
},
```

## Architecture
For state management Flutter Bloc package is used <3
We do not use Flutter's Inherited widget nor Provider (That includes BlocProvider), instead logic and views are separated
wherever possible. Dependency injection is used which included get_it (no generator used)
Bloc state classes use vanilla dart classes with no code generation tangled in (No freezed)
Code generation in the project is limited to the minimum (preferably 0 code generation)

*(To consider) Translation layer (project only supports english language version (there will be few strings in the game))
