{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # a Minecraft launcher (MultiMC fork)
    prismlauncher

    # (formerly minetest)
    # (try the game Glitch!)
    unstable.luanti

    # # really cool but too addictive
    # factorio-demo
    # mindustry

    # veloren
    superTuxKart
    unstable.supertux
    the-powder-toy # (little 2d sandbox)

    # 0ad
    # hedgewars
    warzone2100
    # freeciv
  ];
}
