# nvim

```bash
# MacOS
brew install neovim

# Other
python3 -m pip install --user --upgrade pynvim
python2 -m pip install --user --upgrade pynvim
```

Using [vim-plug](https://github.com/junegunn/vim-plug) to manage plugins:

```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
````

Create folder:
```bash
mkdir .config/ && cd $_
git clone https://github.com/Peskoo/nvim.git
```

install [COC](https://github.com/neoclide/coc.nvim):
```bash

# install nodejs
curl -sL install-node.vercel.app/lts | bash
```

Theme:
https://github.com/joshdick/onedark.vim
nvim .vim/colors/onedark.vim
nvim .vim/autoload/onedark.vim

Other links:
https://www.vimfromscratch.com/articles/vim-for-python
https://github.com/pdbpp/pdbpp

info:
.local/share/nvim/site/autoload/plug.vim
.local/share/nvim/plugged
