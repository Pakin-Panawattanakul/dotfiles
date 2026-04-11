// somebar - dwl bar
// See LICENSE file for copyright and license details.

#pragma once
#include "common.hpp"

constexpr bool topbar = true;

constexpr int paddingX = 10;
constexpr int paddingY = 1;

// See https://docs.gtk.org/Pango/type_func.FontDescription.from_string.html
constexpr const char* font = "JetBrainsMono Nerd Font Propo Bold 10";

constexpr ColorScheme colorInactive = {Color(0xe0, 0xe2, 0xea), Color(0x14, 0x16, 0x1b)};
constexpr ColorScheme colorActive = {Color(0xb3, 0xf6, 0xc0), Color(0x07, 0x08, 0x0d)};
constexpr const char* termcmd[] = {"foot", nullptr};

static std::vector<std::string> tagNames = {
	"1", "2", "3",
	"4", "5", "6",
	"7", "8", "9",
};

constexpr Button buttons[] = {
	{ ClkStatusText,   BTN_RIGHT,  spawn,      {.v = termcmd} },
};
