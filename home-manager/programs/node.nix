{ ... }:

{
  home = {
    sessionVariables = rec {
      NODE_PATH = "$HOME/.npm-packages/lib/node_modules";
    };

    file.".npmrc".text = ''
      prefix = $HOME/.npm-packages
    '';
  };
}
