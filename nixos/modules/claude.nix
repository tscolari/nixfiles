{ ... }:

{
  environment.etc."claude-code/managed-mcp.json" = {
    text = ''
      {
        "mcpServers": {
          "gopls-mcp": {
            "type": "stdio",
            "command": "gopls",
            "args": ["mcp"],
            "env": {
              "GOPATH": "''${HOME}/go",
              "GOCACHE": "''${HOME}/.cache/go-build"
            }
          },
          "go-dev-mcp": {
            "command": "godevmcp",
            "args": ["serve"]
          }
        }
      }
    '';

    mode = "0644";
  };
}
