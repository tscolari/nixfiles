{ ... }:

{
  programs.nixvim = {
    opts = {
      spell = true;
      spelllang = "en_us";
    };

    extraConfigVim = ''
      " Spelling abbreviations
      iab requrie require
      iab emtpy empty
      iab emtpy? empty?
      iab intereset interest
      iab proeprty property
      iab panad panda
      iab pand panda
    '';

    autoCmd = [
      {
        event = [
          "BufRead"
          "BufNewFile"
        ];
        pattern = [
          "*.md"
          "*.rdoc"
          "*.markdown"
        ];
        command = "setlocal spell";
      }
      {
        event = "FileType";
        pattern = [ "gitcommit" ];
        command = "setlocal spell";
      }
    ];
  };
}
