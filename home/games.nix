{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # a Minecraft launcher (MultiMC fork)
    prismlauncher

    # (formerly minetest)
    # (try the game Glitch!)
    luanti

    # # really cool but too addictive
    # factorio-demo
    # mindustry

    # veloren
    # supertuxkart
    supertux
    # the-powder-toy # (really cool 2d sandbox)

    # 0ad
    # hedgewars
    # warzone2100
    # freeciv
  ];
}
