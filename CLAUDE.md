# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

DankAudioVisualizer is a circular audio visualizer desktop widget plugin for **Dank Material Shell (DMS)** — a Quickshell-based desktop shell. Ported from Noctalia's "Fancy Audiovisualizer" by Lemmy/Noctalia Team. Licensed MIT.

## Architecture

This is a QML/GLSL plugin with no build system — files are loaded directly by DMS at runtime.

### Key Files

- **`plugin.json`** — Plugin manifest (id: `dankAudioVisualizer`, type: desktop widget, requires DMS ≥1.2.0)
- **`DankAudioVisualizer.qml`** — Main component. Extends `DesktopPluginComponent`. Manages cava lifecycle, encodes 32 audio bars into a 32×1 Canvas texture, passes uniforms to the shader.
- **`CavaProcess.qml`** — Self-contained cava wrapper. Spawns `cava` via `Process` (Quickshell.Io) with inline config (32 bars, 60 FPS, ASCII output). Parses stdout, tracks idle state with a 2-second timeout. Uses reference counting for lifecycle.
- **`DankAudioVisualizerSettings.qml`** — 12 settings mapped to DMS `PluginSettings` components (sliders, toggles, color pickers, selection).
- **`shaders/visualizer.frag`** — GLSL 450 fragment shader. All rendering: bars, wave (Catmull-Rom spline), ring system, bloom, corner masking, dynamic content scaling.
- **`shaders/visualizer.frag.qsb`** — Pre-compiled Qt shader bundle (required by Qt6 ShaderEffect).

### Data Flow

1. `CavaProcess` spawns cava → parses ASCII stdout → `values` (list of 32 floats 0.0–1.0)
2. `DankAudioVisualizer` encodes `values` into a 32×1 Canvas (grayscale pixels)
3. `ShaderEffectSource` feeds the Canvas as a `sampler2D` texture to the fragment shader
4. Shader samples audio via `texture()`, renders visualization with uniforms from QML properties
5. Settings stored in `pluginData` (DMS persistence), mapped to shader uniform ranges via formulas in QML

### Shader Compilation

The `.frag` source must be compiled to `.qsb` using Qt's shader toolchain:
```bash
qsb --glsl "100 es,120,150" --hlsl 50 --msl 12 -o shaders/visualizer.frag.qsb shaders/visualizer.frag
```

### DMS Integration Points

- Extends `DesktopPluginComponent` (not Noctalia's `DraggableDesktopWidget`)
- Theme colors via `Theme.primary`, `Theme.secondary`, `Theme.cornerRadius`, etc.
- Settings via `PluginSettings` with `SelectionSetting`, `SliderSetting`, `ToggleSetting`, `ColorSetting`
- Imports: `qs.Common`, `qs.Modules.Plugins`, `Quickshell`, `Quickshell.Io`

### Visualization Modes (shader int mapping)

0=bars, 1=wave, 2=rings, 3=bars+rings, 4=wave+rings, 5=all

## Requirements

- `cava` must be installed on the system
- DMS ≥ 1.2.0
- Qt6 (for ShaderEffect with .qsb bundles)
