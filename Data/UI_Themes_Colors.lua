-- ===================================================
-- EmzTools - Data/UI_Themes_Colors.lua
-- Définition des palettes de couleurs pour EmzTools
-- Compatible WoW 1.12 (LUA 5.0)
-- ===================================================

-- Initialiser le module Themes
EmzTools.Data.UI_Themes_Colors = {
    -- ===================================================
    -- THÈMES CLASSIQUES
    -- ===================================================

    ["Amber"] = {  -- Thème Ambré/Doré
        name = "Amber",
        frame = {
            bgColor = {0.1, 0.08, 0.02, 0.98},
            borderColor = {0.3, 0.25, 0.1, 1}
        },
        card = {
            bgColor = {0.25, 0.2, 0.1, 0.9},
            borderColor = {0.4, 0.35, 0.2, 1},
            hoverColor = {0.3, 0.25, 0.15, 0.95},
            titleColor = {1, 0.9, 0.4, 1},
            descColor = {1, 0.8, 0.3, 1},
            labelColor = {0.9, 0.7, 0.2, 1}
        },
        header = {
            bgColor = {0.15, 0.12, 0.04, 1},  -- AJOUTÉ
            titleColor = {1, 0.9, 0.4, 1},
            subtitleColor = {1, 0.8, 0.3, 1}
        },
        button = {
            normalColor = {0.6, 0.5, 0.2, 1},
            highlightColor = {0.8, 0.7, 0.3, 1},
            pressedColor = {0.5, 0.4, 0.15, 1},
            disabledColor = {0.3, 0.25, 0.1, 1},
            textColor = {1, 1, 0.8, 1}
        }
    },

    ["BlackWhite"] = {  -- Thème Noir et Blanc
        name = "BlackWhite",
        frame = {
            bgColor = {0, 0, 0, 0.98},
            borderColor = {1, 1, 1, 1}
        },
        card = {
            bgColor = {0.1, 0.1, 0.1, 0.9},
            borderColor = {0.8, 0.8, 0.8, 1},
            hoverColor = {0.2, 0.2, 0.2, 0.95},
            titleColor = {1, 1, 1, 1},
            descColor = {0.7, 0.7, 0.7, 1},
            labelColor = {0.9, 0.9, 0.9, 1}
        },
        header = {
            bgColor = {0.15, 0.15, 0.15, 1},  -- AJOUTÉ
            titleColor = {1, 1, 1, 1},
            subtitleColor = {0.8, 0.8, 0.8, 1}
        },
        button = {
            normalColor = {0.4, 0.4, 0.5, 1},
            highlightColor = {0.5, 0.5, 0.6, 1},
            pressedColor = {0.3, 0.3, 0.4, 1},
            disabledColor = {0.2, 0.2, 0.3, 1},
            textColor = {1, 1, 1, 1}
        }
    },

    -- ===================================================
    -- THÈMES BLEUS
    -- ===================================================

    ["Sapphire"] = {  -- Bleu saphir avec accents dorés
        name = "Sapphire",
        frame = {
            bgColor = {0.02, 0.04, 0.1, 0.98},
            borderColor = {0.1, 0.2, 0.4, 1}
        },
        card = {
            bgColor = {0.1, 0.15, 0.25, 0.9},
            borderColor = {0.2, 0.3, 0.5, 1},
            hoverColor = {0.15, 0.2, 0.3, 0.95},
            titleColor = {1, 0.9, 0.3, 1},      -- Or
            descColor = {0.6, 0.8, 1, 1},       -- Bleu clair
            labelColor = {0.9, 0.8, 0.4, 1}     -- Or pâle
        },
        header = {
            bgColor = {0.05, 0.08, 0.15, 1},  -- AJOUTÉ
            titleColor = {1, 0.9, 0.3, 1},
            subtitleColor = {0.6, 0.8, 1, 1}
        },
        button = {
            normalColor = {0.2, 0.3, 0.5, 1},
            highlightColor = {0.3, 0.4, 0.6, 1},
            pressedColor = {0.15, 0.25, 0.4, 1},
            disabledColor = {0.1, 0.15, 0.3, 1},
            textColor = {1, 1, 1, 1}
        }
    },

    ["Ocean"] = {  -- Thème Océan profond
        name = "Ocean",
        frame = {
            bgColor = {0.02, 0.05, 0.1, 0.98},
            borderColor = {0.1, 0.3, 0.5, 1}
        },
        card = {
            bgColor = {0.1, 0.2, 0.3, 0.9},
            borderColor = {0.2, 0.4, 0.6, 1},
            hoverColor = {0.15, 0.25, 0.35, 0.95},
            titleColor = {0.6, 0.9, 1, 1},
            descColor = {0.5, 0.8, 1, 1},
            labelColor = {0.4, 0.7, 0.9, 1}
        },
        header = {
            bgColor = {0.05, 0.1, 0.15, 1},  -- AJOUTÉ
            titleColor = {0.6, 0.9, 1, 1},
            subtitleColor = {0.5, 0.8, 1, 1}
        },
        button = {
            normalColor = {0.2, 0.4, 0.6, 1},
            highlightColor = {0.3, 0.5, 0.7, 1},
            pressedColor = {0.15, 0.3, 0.5, 1},
            disabledColor = {0.1, 0.2, 0.4, 1},
            textColor = {1, 1, 1, 1}
        }
    },

    -- ===================================================
    -- THÈMES ROUGES
    -- ===================================================

    ["CrimsonGold"] = {  -- Rouge bordeaux avec or
        name = "CrimsonGold",
        frame = {
            bgColor = {0.2, 0.05, 0.05, 0.98},
            borderColor = {0.8, 0.6, 0.2, 1}
        },
        card = {
            bgColor = {0.3, 0.1, 0.1, 0.9},
            borderColor = {0.9, 0.7, 0.3, 1},
            hoverColor = {0.35, 0.15, 0.15, 0.95},
            titleColor = {1, 0.9, 0.4, 1},
            descColor = {1, 0.8, 0.6, 1},
            labelColor = {0.9, 0.8, 0.5, 1}
        },
        header = {
            bgColor = {0.25, 0.08, 0.08, 1},  -- AJOUTÉ
            titleColor = {1, 0.9, 0.4, 1},
            subtitleColor = {1, 0.8, 0.6, 1}
        },
        button = {
            normalColor = {0.5, 0.2, 0.2, 1},
            highlightColor = {0.6, 0.3, 0.3, 1},
            pressedColor = {0.4, 0.15, 0.15, 1},
            disabledColor = {0.3, 0.1, 0.1, 1},
            textColor = {1, 1, 0.8, 1}
        }
    },

    ["DeepRed"] = {  -- Rouge profond pur
        name = "DeepRed",
        frame = {
            bgColor = {0.1, 0.02, 0.02, 0.98},
            borderColor = {0.3, 0.1, 0.1, 1}
        },
        card = {
            bgColor = {0.25, 0.1, 0.1, 0.9},
            borderColor = {0.45, 0.15, 0.15, 1},
            hoverColor = {0.3, 0.12, 0.12, 0.95},
            titleColor = {1, 0.6, 0.6, 1},
            descColor = {1, 0.5, 0.5, 1},
            labelColor = {0.9, 0.4, 0.4, 1}
        },
        header = {
            bgColor = {0.15, 0.05, 0.05, 1},  -- AJOUTÉ
            titleColor = {1, 0.6, 0.6, 1},
            subtitleColor = {1, 0.5, 0.5, 1}
        },
        button = {
            normalColor = {0.4, 0.1, 0.1, 1},
            highlightColor = {0.5, 0.2, 0.2, 1},
            pressedColor = {0.3, 0.08, 0.08, 1},
            disabledColor = {0.2, 0.05, 0.05, 1},
            textColor = {1, 0.8, 0.8, 1}
        }
    },

    -- ===================================================
    -- THÈMES ORANGE/TERRE
    -- ===================================================

    ["DesertSunset"] = {  -- Coucher de soleil désert
        name = "DesertSunset",
        frame = {
            bgColor = {0.15, 0.08, 0.02, 0.98},
            borderColor = {0, 0.3, 0.3, 1}
        },
        card = {
            bgColor = {0.25, 0.15, 0.05, 0.9},
            borderColor = {0.1, 0.4, 0.4, 1},
            hoverColor = {0.3, 0.2, 0.08, 0.95},
            titleColor = {0, 0.8, 0.8, 1},
            descColor = {1, 0.7, 0.4, 1},
            labelColor = {0.9, 0.6, 0.3, 1}
        },
        header = {
            bgColor = {0.2, 0.12, 0.05, 1},  -- AJOUTÉ
            titleColor = {0, 0.8, 0.8, 1},
            subtitleColor = {1, 0.7, 0.4, 1}
        },
        button = {
            normalColor = {0.5, 0.3, 0.1, 1},
            highlightColor = {0.6, 0.4, 0.2, 1},
            pressedColor = {0.4, 0.25, 0.08, 1},
            disabledColor = {0.3, 0.2, 0.05, 1},
            textColor = {1, 1, 0.8, 1}
        }
    },

    ["Desert"] = {  -- Thème Désert/Sable
        name = "Desert",
        frame = {
            bgColor = {0.15, 0.1, 0.05, 0.98},
            borderColor = {0.3, 0.25, 0.15, 1}
        },
        card = {
            bgColor = {0.25, 0.2, 0.12, 0.9},
            borderColor = {0.4, 0.35, 0.25, 1},
            hoverColor = {0.3, 0.25, 0.18, 0.95},
            titleColor = {1, 0.9, 0.6, 1},
            descColor = {0.9, 0.8, 0.5, 1},
            labelColor = {0.8, 0.7, 0.4, 1}
        },
        header = {
            bgColor = {0.2, 0.15, 0.08, 1},  -- AJOUTÉ
            titleColor = {1, 0.9, 0.6, 1},
            subtitleColor = {0.9, 0.8, 0.5, 1}
        },
        button = {
            normalColor = {0.5, 0.4, 0.2, 1},
            highlightColor = {0.6, 0.5, 0.3, 1},
            pressedColor = {0.4, 0.35, 0.15, 1},
            disabledColor = {0.3, 0.25, 0.1, 1},
            textColor = {1, 1, 0.8, 1}
        }
    },

    -- ===================================================
    -- THÈMES VERTS
    -- ===================================================

    ["Emerald"] = {  -- Thème Émeraude
        name = "Emerald",
        frame = {
            bgColor = {0.02, 0.08, 0.04, 0.98},
            borderColor = {0.1, 0.3, 0.15, 1}
        },
        card = {
            bgColor = {0.1, 0.25, 0.15, 0.9},
            borderColor = {0.2, 0.4, 0.25, 1},
            hoverColor = {0.15, 0.3, 0.2, 0.95},
            titleColor = {0.6, 1, 0.7, 1},
            descColor = {0.5, 0.9, 0.6, 1},
            labelColor = {0.4, 0.8, 0.5, 1}
        },
        header = {
            bgColor = {0.05, 0.12, 0.08, 1},  -- AJOUTÉ
            titleColor = {0.6, 1, 0.7, 1},
            subtitleColor = {0.5, 0.9, 0.6, 1}
        },
        button = {
            normalColor = {0.2, 0.4, 0.25, 1},
            highlightColor = {0.3, 0.5, 0.35, 1},
            pressedColor = {0.15, 0.35, 0.2, 1},
            disabledColor = {0.1, 0.25, 0.15, 1},
            textColor = {1, 1, 1, 1}
        }
    },

    -- ===================================================
    -- THÈMES VIOLETS
    -- ===================================================

    ["RoyalPurple"] = {  -- Violet royal avec or
        name = "RoyalPurple",
        frame = {
            bgColor = {0.08, 0.05, 0.15, 0.98},
            borderColor = {0.2, 0.15, 0.4, 1}
        },
        card = {
            bgColor = {0.2, 0.15, 0.35, 0.9},
            borderColor = {0.35, 0.25, 0.55, 1},
            hoverColor = {0.25, 0.2, 0.4, 0.95},
            titleColor = {1, 0.9, 0.3, 1},      -- Or
            descColor = {1, 0.8, 0.4, 1},       -- Orange doré
            labelColor = {0.9, 0.7, 0.5, 1}     -- Or pâle
        },
        header = {
            bgColor = {0.12, 0.08, 0.2, 1},  -- AJOUTÉ
            titleColor = {1, 0.9, 0.3, 1},
            subtitleColor = {1, 0.8, 0.4, 1}
        },
        button = {
            normalColor = {0.3, 0.2, 0.4, 1},
            highlightColor = {0.4, 0.3, 0.5, 1},
            pressedColor = {0.25, 0.15, 0.35, 1},
            disabledColor = {0.2, 0.1, 0.3, 1},
            textColor = {1, 1, 1, 1}
        }
    },

    ["Twilight"] = {  -- Violet crépuscule pur
        name = "Twilight",
        frame = {
            bgColor = {0.08, 0.04, 0.1, 0.98},
            borderColor = {0.25, 0.15, 0.3, 1}
        },
        card = {
            bgColor = {0.18, 0.1, 0.22, 0.9},
            borderColor = {0.35, 0.2, 0.4, 1},
            hoverColor = {0.22, 0.15, 0.28, 0.95},
            titleColor = {0.9, 0.6, 1, 1},
            descColor = {0.8, 0.5, 0.9, 1},
            labelColor = {0.7, 0.4, 0.8, 1}
        },
        header = {
            bgColor = {0.12, 0.08, 0.15, 1},  -- AJOUTÉ
            titleColor = {0.9, 0.6, 1, 1},
            subtitleColor = {0.8, 0.5, 0.9, 1}
        },
        button = {
            normalColor = {0.3, 0.15, 0.4, 1},
            highlightColor = {0.4, 0.25, 0.5, 1},
            pressedColor = {0.25, 0.1, 0.35, 1},
            disabledColor = {0.2, 0.05, 0.3, 1},
            textColor = {1, 1, 1, 1}
        }
    },

    -- ===================================================
    -- THÈMES SPÉCIAUX
    -- ===================================================

    ["Cyber"] = {  -- Thème Cyberpunk/Néon
        name = "Cyber",
        frame = {
            bgColor = {0.02, 0.02, 0.08, 0.98},
            borderColor = {0.1, 0.1, 0.4, 1}
        },
        card = {
            bgColor = {0.08, 0.08, 0.2, 0.9},
            borderColor = {0.2, 0.2, 0.6, 1},
            hoverColor = {0.12, 0.12, 0.3, 0.95},
            titleColor = {0, 1, 1, 1},
            descColor = {0.2, 0.8, 1, 1},
            labelColor = {0.4, 0.6, 1, 1}
        },
        header = {
            bgColor = {0.05, 0.05, 0.15, 1},  -- AJOUTÉ
            titleColor = {0, 1, 1, 1},
            subtitleColor = {0.2, 0.8, 1, 1}
        },
        button = {
            normalColor = {0.1, 0.3, 0.5, 1},
            highlightColor = {0.2, 0.4, 0.6, 1},
            pressedColor = {0.08, 0.25, 0.4, 1},
            disabledColor = {0.05, 0.15, 0.3, 1},
            textColor = {1, 1, 1, 1}
        }
    },

    ["Obsidian"] = {  -- Thème Obsidienne
        name = "Obsidian",
        frame = {
            bgColor = {0.01, 0.01, 0.01, 0.99},
            borderColor = {0.15, 0.15, 0.2, 1}
        },
        card = {
            bgColor = {0.1, 0.1, 0.15, 0.95},
            borderColor = {0.25, 0.25, 0.3, 1},
            hoverColor = {0.15, 0.15, 0.2, 0.97},
            titleColor = {0.9, 0.9, 1, 1},
            descColor = {0.8, 0.8, 0.9, 1},
            labelColor = {0.7, 0.7, 0.8, 1}
        },
        header = {
            bgColor = {0.08, 0.08, 0.12, 1},  -- AJOUTÉ
            titleColor = {0.9, 0.9, 1, 1},
            subtitleColor = {0.8, 0.8, 0.9, 1}
        },
        button = {
            normalColor = {0.3, 0.3, 0.4, 1},
            highlightColor = {0.4, 0.4, 0.5, 1},
            pressedColor = {0.25, 0.25, 0.35, 1},
            disabledColor = {0.2, 0.2, 0.3, 1},
            textColor = {1, 1, 1, 1}
        }
    },

    ["Fire"] = {  -- Thème Feu intense
        name = "Fire",
        frame = {
            bgColor = {0.15, 0.05, 0.02, 0.98},
            borderColor = {0.5, 0.2, 0.1, 1}
        },
        card = {
            bgColor = {0.3, 0.15, 0.1, 0.9},
            borderColor = {0.6, 0.3, 0.15, 1},
            hoverColor = {0.35, 0.2, 0.12, 0.95},
            titleColor = {1, 0.7, 0.3, 1},
            descColor = {1, 0.6, 0.25, 1},
            labelColor = {0.9, 0.5, 0.2, 1}
        },
        header = {
            bgColor = {0.2, 0.08, 0.05, 1},  -- AJOUTÉ
            titleColor = {1, 0.7, 0.3, 1},
            subtitleColor = {1, 0.6, 0.25, 1}
        },
        button = {
            normalColor = {0.5, 0.2, 0.1, 1},
            highlightColor = {0.6, 0.3, 0.15, 1},
            pressedColor = {0.4, 0.15, 0.08, 1},
            disabledColor = {0.3, 0.1, 0.05, 1},
            textColor = {1, 1, 0.8, 1}
        }
    },

    -- ===================================================
    -- THÈMES CONTRASTÉS
    -- ===================================================

    ["YellowPurple"] = {  -- Thème Jaune et Violet contrasté
        name = "YellowPurple",
        frame = {
            bgColor = {0.15, 0.1, 0.2, 0.98},
            borderColor = {0.8, 0.7, 0.1, 1}
        },
        card = {
            bgColor = {0.2, 0.15, 0.25, 0.9},
            borderColor = {0.9, 0.8, 0.2, 1},
            hoverColor = {0.25, 0.2, 0.3, 0.95},
            titleColor = {1, 0.9, 0.2, 1},
            descColor = {0.9, 0.7, 1, 1},
            labelColor = {0.8, 0.6, 0.9, 1}
        },
        header = {
            bgColor = {0.2, 0.15, 0.25, 1},  -- AJOUTÉ
            titleColor = {1, 0.9, 0.2, 1},
            subtitleColor = {0.9, 0.7, 1, 1}
        },
        button = {
            normalColor = {0.4, 0.3, 0.5, 1},
            highlightColor = {0.5, 0.4, 0.6, 1},
            pressedColor = {0.35, 0.25, 0.45, 1},
            disabledColor = {0.25, 0.2, 0.35, 1},
            textColor = {1, 1, 1, 1}
        }
    },

    ["RedSilver"] = {  -- Thème Rouge et Argent
        name = "RedSilver",
        frame = {
            bgColor = {0.2, 0.05, 0.05, 0.98},
            borderColor = {0.7, 0.7, 0.8, 1}
        },
        card = {
            bgColor = {0.3, 0.1, 0.1, 0.9},
            borderColor = {0.8, 0.8, 0.9, 1},
            hoverColor = {0.35, 0.15, 0.15, 0.95},
            titleColor = {1, 1, 1, 1},
            descColor = {0.9, 0.7, 0.7, 1},
            labelColor = {0.8, 0.8, 0.9, 1}
        },
        header = {
            bgColor = {0.25, 0.08, 0.08, 1},  -- AJOUTÉ
            titleColor = {1, 1, 1, 1},
            subtitleColor = {0.9, 0.7, 0.7, 1}
        },
        button = {
            normalColor = {0.4, 0.4, 0.5, 1},
            highlightColor = {0.5, 0.5, 0.6, 1},
            pressedColor = {0.35, 0.35, 0.45, 1},
            disabledColor = {0.25, 0.25, 0.35, 1},
            textColor = {1, 1, 1, 1}
        }
    }
}
