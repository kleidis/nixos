{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    extraConfig = {
        modi = "drun,run";
        icon-theme = "Papirus-Dark";
        show-icons = true;
        terminal = "alacritty";
        drun-display-format = "{icon} {name}";
        disable-history = true;
        hide-scrollbar = false;
        display-drun = "   Apps ";
        display-run = "   Run ";
        display-window = " 󰕰  Window";
        display-Network = " 󰤨  Network";
    };
    theme = builtins.toFile "catppuccin-mocha.rasi" ''
        * {
            bg-col:  #24273a;
            bg-col-light: #24273a;
            border-col: #24273a;
            selected-col: #24273a;
            blue: #8aadf4;
            fg-col: #cad3f5;
            fg-col2: #ed8796;
            grey: #6e738d;

            width: 600;
            font: "JetBrainsMono Nerd Font 14";
        }


        /**
        *
        * Author : Aditya Shakya (adi1090x)
        * Github : @adi1090x
        *
        * Rofi Theme File
        * Rofi Version: 1.7.3
        **/

        /*****----- Configuration -----*****/
        configuration {
            modi:                       "drun";
            show-icons:                 true;
            display-drun:               "";
            drun-display-format:        "{name}";
        }

        /*****----- Global Properties -----*****/

        /*****----- Main Window -----*****/
        window {
            transparency:                "real";
            location:                    center;
            anchor:                      center;
            fullscreen:                  false;
            width:                       600px;
            x-offset:                    0px;
            y-offset:                    0px;

            enabled:                     true;
            margin:                      0px;
            padding:                     0px;
            border:                      2px solid;
            border-radius:               20px;
            border-color:                @fg-col;
            background-color:            transparent;
            cursor:                      "default";
        }

        /*****----- Main Box -----*****/
        mainbox {
            enabled:                     true;
            spacing:                     20px;
            margin:                      0px;
            padding:                     20px;
            border:                      0px solid;
            border-radius:               0px 0px 0px 0px;
            border-color:                @selected;
            background-color:            @bg-col;
            children:                    [ "inputbar", "listview" ];
        }

        /*****----- Inputbar -----*****/
        inputbar {
            enabled:                     true;
            spacing:                     10px;
            margin:                      0px;
            padding:                     12px;
            border:                      0px solid;
            border-radius:               20px;
            border-color:                @selected;
            background-color:            @fg-col;
            text-color:                  @foreground;
            children:                    [ "prompt", "entry" ];
        }

        prompt {
            enabled:                     true;
            background-color:            inherit;
            text-color:                  inherit;
        }
        textbox-prompt-colon {
            enabled:                     true;
            expand:                      false;
            str:                         "::";
            background-color:            inherit;
            text-color:                  inherit;
        }
        entry {
            enabled:                     true;
            background-color:            inherit;
            text-color:                  inherit;
            cursor:                      text;
            placeholder:                 "Search...";
            placeholder-color:           inherit;
        }

        /*****----- Listview -----*****/
        listview {
            enabled:                     true;
            columns:                     2;
            lines:                       8;
            cycle:                       false;
            dynamic:                     true;
            scrollbar:                   false;
            layout:                      vertical;
            reverse:                     false;
            fixed-height:                true;
            fixed-columns:               true;

            spacing:                     5px;
            margin:                      0px;
            padding:                     0px;
            border:                      0px solid;
            border-radius:               0px;
            border-color:                @color1;
            background-color:            transparent;
            text-color:                  @color15;
            cursor:                      "default";
        }
        scrollbar {
            handle-width:                5px ;
            handle-color:                @selected;
            border-radius:               0px;
            background-color:            @background-alt;
        }

        /*****----- Elements -----*****/
        element {
            enabled:                     true;
            spacing:                     10px;
            margin:                      0px;
            padding:                     5px;
            border:                      0px solid;
            border-radius:               12px;
            border-color:                @selected;
            background-color:            transparent;
            text-color:                  white;
            cursor:                      pointer;
        }
        element normal.normal {
            background-color:            black / 0%;
            text-color:                  @foreground;
        }
        element selected.normal {
            background-color:            @fg-col;
            text-color:                  black;
        }
        element-icon {
            background-color:            transparent;
            text-color:                  inherit;
            size:                        32px;
            cursor:                      inherit;
        }
        element-text {
            background-color:            transparent;
            text-color:                  inherit;
            highlight:                   inherit;
            cursor:                      inherit;
            vertical-align:              0.5;
            horizontal-align:            0.0;
        }

        /*****----- Message -----*****/
        error-message {
            padding:                     15px;
            border:                      2px solid;
            border-radius:               12px;
            border-color:                @selected;
            background-color:            @background;
            text-color:                  @foreground;
        }
        textbox {
            background-color:            @background;
            text-color:                  @foreground;
            vertical-align:              0.5;
            horizontal-align:            0.0;
            highlight:                   none;
        }
    '';
  };
}