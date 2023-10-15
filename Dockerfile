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

RUN git clone https://github.com/pytorch/pytorch --recursive && cd pytorch

RUN cd pytorch; git checkout v2.0.1; git submodule update --init --recursive

RUN cd pytorch; pip3 install -r requirements.txt

# Patch compilation error
RUN sed -i '18 i #include <stdexcept>' pytorch/c10/util/Registry.h
RUN sed -i -e '535d;536d' pytorch/caffe2/CMakeLists.txt
RUN sed -i "3 i #include <cstdint>" pytorch/torch/csrc/jit/passes/quantization/quantization_type.h
RUN sed -i "4 i #include <stdexcept>" pytorch/torch/csrc/jit/runtime/logging.cpp
RUN sed -i "4 i #include <stdexcept>" pytorch/torch/csrc/lazy/core/multi_wait.cpp

RUN export USE_CUDA=0;         \
    export USE_DISTRIBUTED=0;  \
    export USE_CUDNN=0;        \
    export USE_FBGEMM=0;       \
    export USE_KINETO=0;       \
    export USE_NUMPY=0;        \
    export BUILD_TEST=0;       \
    export USE_MKLDNN=0;       \
    export USE_ITT=0;          \
    export USE_NNPACK=0;       \
    export USE_TENSORPIPE=0;   \
    export USE_GLOO=0;         \
    export USE_MPI=0;          \
    export USE_SYSTEM_NCCL=0;  \
    export BUILD_CAFFE2_OPS=0; \
    export BUILD_CAFFE2=0;     \
    export USE_OPENMP=0;       \
    cd pytorch; python3 setup.py bdist_wheel

RUN cp pytorch/dist/*.whl .