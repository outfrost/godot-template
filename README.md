Template repository for new Godot projects

## Dependencies

This template project uses **Godot 4.3**.

The GitHub Actions workflow uses `firebelley/godot-export`, `actions/checkout`, and `ncipollo/release-action`.

## What's included

* Export presets for Linux, Windows
* GitHub Actions workflow that builds the project and creates a release upon tagging a version (e.g. `v0.1.0`)
* Main Game scene with a stub `Game` script
* Main menu template
* Automated version text in the menu, updated inside each GitHub Actions export
* Fade transition screen
* UI theme template
* Debug overlay for continuous monitoring of arbitrary data
* `Harbinger`, a singleton for sending and subscribing to signal-like messages
* A couple prototyping/scene design helper scripts
* Hook-based debug script template for easier local testing without changing the implementation
* A license which you may or may not want to remove once you start a project ;)

## Contributing

Issues & PRs welcome.
