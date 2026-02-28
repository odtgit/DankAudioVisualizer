import QtQuick
import qs.Common
import qs.Modules.Plugins

PluginSettings {
    id: root
    pluginId: "dankAudioVisualizer"

    SelectionSetting {
        settingKey: "visualizationMode"
        label: "Visualization Mode"
        description: "Choose visualization style"
        options: [
            { label: "Bars", value: "bars" },
            { label: "Wave", value: "wave" },
            { label: "Rings", value: "rings" },
            { label: "Bars + Rings", value: "barsRings" },
            { label: "Wave + Rings", value: "waveRings" },
            { label: "All", value: "all" }
        ]
        defaultValue: "barsRings"
    }

    SliderSetting {
        settingKey: "sensitivity"
        label: "Sensitivity"
        description: "Audio reactivity (0.5x to 3.0x)"
        minimum: 5
        maximum: 30
        defaultValue: 15
    }

    SliderSetting {
        settingKey: "rotationSpeed"
        label: "Rotation Speed"
        description: "Visualization rotation (0.0 to 2.0)"
        minimum: 0
        maximum: 20
        defaultValue: 5
    }

    SliderSetting {
        settingKey: "barWidth"
        label: "Bar Width"
        description: "Width of frequency bars (0.2 to 1.0)"
        minimum: 2
        maximum: 10
        defaultValue: 6
    }

    SliderSetting {
        settingKey: "ringOpacity"
        label: "Ring Opacity"
        minimum: 0
        maximum: 100
        defaultValue: 80
        unit: "%"
    }

    SliderSetting {
        settingKey: "bloomIntensity"
        label: "Bloom Intensity"
        minimum: 0
        maximum: 100
        defaultValue: 50
        unit: "%"
    }

    SliderSetting {
        settingKey: "waveThickness"
        label: "Wave Thickness"
        description: "Wave fill thickness (0.3 to 2.0)"
        minimum: 3
        maximum: 20
        defaultValue: 10
    }

    SliderSetting {
        settingKey: "innerDiameter"
        label: "Inner Diameter"
        minimum: 0
        maximum: 100
        defaultValue: 70
        unit: "%"
    }

    ToggleSetting {
        settingKey: "fadeWhenIdle"
        label: "Fade When Idle"
        description: "Fade out visualizer when no audio is playing"
        defaultValue: false
    }

    ToggleSetting {
        settingKey: "useCustomColors"
        label: "Use Custom Colors"
        description: "Override theme colors with custom colors"
        defaultValue: false
    }

    ColorSetting {
        settingKey: "customPrimaryColor"
        label: "Primary Color"
        defaultValue: "#6750A4"
    }

    ColorSetting {
        settingKey: "customSecondaryColor"
        label: "Secondary Color"
        defaultValue: "#625B71"
    }
}
