ln -fs $(pwd)/.aliases $HOME
ln -fs $(pwd)/.gitconfig $HOME
ln -fs $(pwd)/.localrc $HOME
ln -fs $(pwd)/.gitignore_global $HOME
ln -fs $(pwd)/.zshrc $HOME
rm -rf $HOME/.oh-my-zsh/custom/ ; ln -fs $(pwd)/.oh-my-zsh/custom/ $HOME/.oh-my-zsh/
ln -fs $(pwd)/.minirc.dfl $HOME
ln -fs $(pwd)/.screenrc $HOME
ln -fs $(pwd)/.vimrc $HOME
ln -fs $(pwd)/.config/terminator/config $HOME/.config/terminator/
ln -fs $(pwd)/.config/redshift.conf $HOME/.config/
ln -fs $(pwd)/.i3 $HOME

# VSCode settings and extensions can also be retrieved from extension Settings Sync
ln -fs $(pwd)/.config/Code/User/keybindings.json $HOME/.config/Code/User/
ln -fs $(pwd)/.config/Code/User/settings.json $HOME/.config/Code/User/

sudo ln -fs $(pwd)/etc/profile.d/java_home.sh /etc/profile.d/
sudo ln -fs $(pwd)/etc/profile.d/only_left_click_on_touchpad.sh /etc/profile.d/

sudo ln -fs $(pwd)/etc/udev/rules.d/90-wfh-setup.rules /etc/udev/rules.d/
sudo ln -fs $(pwd)/etc/udev/wfh-setup.sh /etc/udev/

# You'll need to download and install the following font for terminator:
# https://www.jetbrains.com/lp/mono/
# sudo apt install command-not-found

# Install zfz
# git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# To make the terminator's CustomCommandsMenu plugin working you might need to do the following change:
# https://bugs.launchpad.net/terminator/+bug/1781706/comments/6

# To get the `sensors` command used by the `temp` alias
# sudo apt install lm-sensors
