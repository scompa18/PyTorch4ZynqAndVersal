FROM arm64v8/fedora:38

RUN dnf -y update &&   \
    dnf install -y     \
    vim-minimal        \
    openblas-devel     \
    blas-devel         \
    m4                 \
    cmake              \
    python3-Cython     \
    python3-devel      \
    python3-yaml       \
    python3-pillow     \
    python3-setuptools \
    python3-numpy      \
    python3-cffi       \
    python3-wheel      \
    gcc-c++            \
    tar                \
    gcc                \
    git                \
    make               \
    tmux

RUN useradd -ms /bin/bash mluser && \
    echo "mluser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER mluser
ENV HOME /home/mluser
WORKDIR /home/mluser