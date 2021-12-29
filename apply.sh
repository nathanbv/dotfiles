ln -fs $(pwd)/.aliases $HOME
ln -fs $(pwd)/.gitconfig $HOME
ln -fs $(pwd)/.gitignore_global $HOME
ln -fs $(pwd)/.zshrc $HOME
rm -rf $HOME/.oh-my-zsh/custom/ ; ln -fs $(pwd)/.oh-my-zsh/custom/ $HOME/.oh-my-zsh/
ln -fs $(pwd)/.minirc.dfl $HOME
ln -fs $(pwd)/.screenrc $HOME
ln -fs $(pwd)/.vimrc $HOME
ln -fs $(pwd)/.config/terminator/config $HOME/.config/terminator/
ln -fs $(pwd)/.i3 $HOME

# VSCode settings and extensions can also be retrieved from extension Settings Sync
ln -fs $(pwd)/.config/Code/User/keybindings.json $HOME/.config/Code/User/
ln -fs $(pwd)/.config/Code/User/settings.json $HOME/.config/Code/User/
