#!/bin/bash

cp -r ~/Layouts-Decoder-Plugin ~/.oh-my-zsh/plugins/
echo "source ~/.oh-my-zsh/plugins/Layouts-Decoder-Plugin/ldec.plugin.zsh" >> ~/.zshrc
rm ~/.oh-my-zsh/plugins/Layouts-Decoder-Plugin/installer.sh
exit