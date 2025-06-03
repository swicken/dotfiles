#!/usr/bin/env bash

set -e

echo "🔗 Symlinking .gitconfig and .zshrc..."
ln -sf "$HOME/dotfiles/.gitconfig" "$HOME/.gitconfig"
ln -sf "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"

echo "🔗 Symlinking VS Code Insiders settings..."
VSCODE_USER_DIR="$HOME/Library/Application Support/Code - Insiders/User"
mkdir -p "$VSCODE_USER_DIR"
ln -sf "$HOME/dotfiles/vscode-insiders/settings.json" "$VSCODE_USER_DIR/settings.json"
ln -sf "$HOME/dotfiles/vscode-insiders/keybindings.json" "$VSCODE_USER_DIR/keybindings.json"
ln -sfn "$HOME/dotfiles/vscode-insiders/snippets" "$VSCODE_USER_DIR/snippets"

echo "⬇️ Restoring VS Code Insiders extensions..."
if [ -f "$HOME/dotfiles/vscode-insiders/extensions.txt" ]; then
    xargs -n 1 code-insiders --install-extension < "$HOME/dotfiles/vscode-insiders/extensions.txt"
else
    echo "No VS Code extensions file found, skipping."
fi

echo "✅ Dotfiles setup complete!"

# Optional: Add more config setup here as you add more dotfiles in the future.
echo "🔄 Reloading shell..."
exec zsh
echo "🔄 Reloading VS Code Insiders..."