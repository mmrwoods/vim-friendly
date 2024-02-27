FROM debian:buster

LABEL name="vim-friendly"

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
    ssh git bash-completion bsdmainutils psmisc less rsync man-db vim neovim \
    ca-certificates

WORKDIR /opt/vim/pack/mmrwoods/opt/friendly

ENV GIT_EDITOR=vim
ENV GIT_PAGER=less

RUN echo set packpath+=/opt/vim >> /root/.vimrc
RUN echo packadd friendly >> /root/.vimrc

RUN mkdir -p /root/.config/nvim
RUN echo set packpath+=/opt/vim >> /root/.config/nvim/init.vim
RUN echo packadd friendly >> /root/.config/nvim/init.vim

RUN for cmd in vi vim view vimdiff; do update-alternatives --remove $cmd /usr/bin/nvim; done

CMD ["bash", "-l"]
