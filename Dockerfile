FROM "golang"

RUN sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list &&\
    apt update &&\
    apt install -y vim &&\
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &&\
    curl -fLo ~/.vimrc https://raw.githubusercontent.com/hxzhao527/vimrc/master/vimrc &&\
    vim +'PlugInstall --sync' +qa

