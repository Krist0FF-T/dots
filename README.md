
# nix-dots

I ran the following command to initialize this:

```bash
nix flake init -t github:misterio77/nix-starter-config#minimal
```

# TODO
- [x] ignore power button and lid close
- [x] host my own nextcloud instance
- [ ] ssh: add authorized keys to user(s)
- [ ] easyeffects (audio)
- [ ] rebuild script
- [ ] fix fcitx gtk im warning
- [ ] nix-managed dotfiles
    - (though I'm not sure I want to rebuild on small config changes; symlinks work well)
    - (hot-reloading is nice in hyprland and quickshell)
    - [x] neovim (lazyvim)
    - [ ] hypr* (this would remove hot-reloading)
    - [ ] mpv (simple)
- [ ] clipboard history cliphist
    - [ ] image clipboard?
- [ ] try DWL
- [ ] try MangoWM

