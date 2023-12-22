# Start from a base Ubuntu image
FROM ubuntu:latest as builder

# Install necessary tools
RUN apt-get update && apt-get install -y \
  git \
  curl \
  python3 \
  python3-pip \
  python3-venv \
  openssh-server \
  sudo \
  ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip \
  && rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN cargo install eza

# Install nvm and Node.js
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
ENV NVM_DIR="/root/.nvm"
RUN . "$NVM_DIR/nvm.sh" && nvm install 20

# Clone Neovim repository and checkout master branch
RUN git clone https://github.com/neovim/neovim.git \
  && cd neovim \
  && make CMAKE_BUILD_TYPE=RelWithDebInfo \
  && make install \
  && cd .. \
  && rm -rf neovim

# Setup SSH server
RUN mkdir /var/run/sshd
RUN echo 'root:1234' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Install zsh and oh-my-zsh
RUN apt-get update && apt-get install -y zsh \
  && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir ~/.zsh-plugins \
  && cd ~/.zsh-plugins \
  && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  && git clone https://github.com/zsh-users/zsh-autosuggestions \
  && git clone https://github.com/marlonrichert/zsh-autocomplete.git \
  # && git clone https://github.com/wting/autojump.git \
  # && cd autojump \
  # && ./install.py \
  && echo "skip_global_compinit=1" >> ~/.zshenv

# Install tmux and tpm
RUN apt-get update && apt-get install -y tmux \
  && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm \
  && rm -rf /var/lib/apt/lists/*

# Install starship
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y

# Clone dotfiles and move to root
RUN git clone https://github.com/chojs23/neovim.dotfile.git; \
  git clone https://github.com/chojs23/dotfiles.git; \
  cp -av dotfiles/. /root/ && rm -rf dotfiles;\
  mv neovim.dotfile/* ~/.config/nvim/ && rm -rf neovim.dotfile;

# Install lazygit
RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*');\
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz";\
  tar xf lazygit.tar.gz lazygit;\
  install lazygit /usr/local/bin \
  && rm -rf lazygit.tar.gz lazygit

# Change shell to zsh
RUN chsh -s /usr/bin/zsh root

# Start from a base Ubuntu image
FROM ubuntu:latest

COPY --from=builder / /

WORKDIR /root

EXPOSE 22

# Run the SSH server
CMD ["/usr/sbin/sshd", "-D"]
