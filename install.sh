#!/bin/sh

set -e

if [ ! $INSTALL_PATH ] ; then
    INSTALL_PATH=$HOME
fi

WORK_PATH=$INSTALL_PATH/dotfiles_work

if [ -e $WORK_PATH ] ; then
    /bin/rm -rf $WORK_PATH
fi

git clone https://github.com/sota2502/dotfiles.git $WORK_PATH

cp $WORK_PATH/.screenrc $INSTALL_PATH
cp $WORK_PATH/.vimrc $INSTALL_PATH
cp $WORK_PATH/.zshrc $INSTALL_PATH
