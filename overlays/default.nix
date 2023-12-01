# The following is the overlays/default.nix file.
# you may copy paste it into a file then include it in your flake.nix
# to add new overlays you should follow 
# the directions inside the comment blocks.
# it is done this way for convenience but you could do it another way.
# unfortunately, you cannot define multiple overlays 
# imported with the same name....

/*
This file imports overlays defined in the following format.
Plugins will still only be downloaded if included in a category.
You may copy paste this example into a new file and then import that file here.
*/
# Example overlay:
/*
importName: inputs: let
  overlay = self: super: { 
    ${importName} = {
      # define your overlay derivations here
    };
  };
in
overlay
*/
# the reason for this is that you cannot import multiple overlays under the same name.
# This unfortunately also applies to ones inherited from previous nixCats packages.
# So this way you at least name them all in one place.
# And this is what it does.
inputs: let 
  overlaySet = {

    # this is how you would add another overlay file
    # for if your customBuildsOverlay gets too long
    nixCatsBuilds = import ./customBuildsOverlay.nix;

  };
in
# then it calls the functions we imported with their name here as importName
# and turns that into a list by getting just the values of overlaySet
builtins.attrValues (builtins.mapAttrs (name: value: (value name inputs)) overlaySet)
