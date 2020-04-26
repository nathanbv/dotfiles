ln -fs $(pwd)/.aliases $HOME
ln -fs $(pwd)/.zshrc $HOME
ln -fs $(pwd)/.i3 $HOME
rm -rf $HOME/.oh-my-zsh/custom/ ; ln -fs $(pwd)/.oh-my-zsh/custom/ $HOME/.oh-my-zsh/
