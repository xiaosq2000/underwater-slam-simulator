FROM osrf/ros:noetic-desktop-full

LABEL maintainer="xiaosq2000@gmail.com"

# CUDA_VERSION 11.6
ENV NV_CUDA_CUDART_VERSION 11.6.55-1
ENV NV_CUDA_COMPAT_PACKAGE cuda-compat-11-6
ENV NV_CUDA_LIB_VERSION 11.6.0-1
ENV NV_NVTX_VERSION 11.6.55-1
ENV NV_LIBNPP_VERSION 11.6.0.55-1
ENV NV_LIBNPP_PACKAGE libnpp-11-6=${NV_LIBNPP_VERSION}
ENV NV_LIBCUSPARSE_VERSION 11.7.1.55-1
ENV NV_LIBCUBLAS_PACKAGE_NAME libcublas-11-6
ENV NV_LIBCUBLAS_VERSION 11.8.1.74-1
ENV NV_LIBCUBLAS_PACKAGE ${NV_LIBCUBLAS_PACKAGE_NAME}=${NV_LIBCUBLAS_VERSION}
ENV NV_LIBNCCL_PACKAGE_NAME libnccl2
ENV NV_LIBNCCL_PACKAGE_VERSION 2.12.10-1
ENV NCCL_VERSION 2.12.10-1
ENV NV_LIBNCCL_PACKAGE ${NV_LIBNCCL_PACKAGE_NAME}=${NV_LIBNCCL_PACKAGE_VERSION}+cuda11.6
ENV NV_CUDA_CUDART_DEV_VERSION 11.6.55-1
ENV NV_NVML_DEV_VERSION 11.6.55-1
ENV NV_LIBCUSPARSE_DEV_VERSION 11.7.1.55-1
ENV NV_LIBNPP_DEV_VERSION 11.6.0.55-1
ENV NV_LIBNPP_DEV_PACKAGE libnpp-dev-11-6=${NV_LIBNPP_DEV_VERSION}
ENV NV_LIBCUBLAS_DEV_VERSION 11.8.1.74-1
ENV NV_LIBCUBLAS_DEV_PACKAGE_NAME libcublas-dev-11-6
ENV NV_LIBCUBLAS_DEV_PACKAGE ${NV_LIBCUBLAS_DEV_PACKAGE_NAME}=${NV_LIBCUBLAS_DEV_VERSION}
ENV NV_LIBNCCL_DEV_PACKAGE_NAME libnccl-dev
ENV NV_LIBNCCL_DEV_PACKAGE_VERSION 2.12.10-1
ENV NV_LIBNCCL_DEV_PACKAGE ${NV_LIBNCCL_DEV_PACKAGE_NAME}=${NV_LIBNCCL_DEV_PACKAGE_VERSION}+cuda11.6

RUN echo "Acquire::http::proxy \"${HTTP_PROXY}\";" >> /etc/apt/apt.conf && \
    echo "Acquire::https::proxy \"${HTTP_PROXY}\";" >> /etc/apt/apt.conf  
COPY keyrings/* /etc/apt/keyrings/
RUN apt-get update && \
    apt-get install -qy --no-install-recommends \
        ca-certificates \
        dirmngr \
        gnupg2 && \
    rm -rf /var/lib/apt/lists/* 
RUN apt-key add /etc/apt/keyrings/3bf863cc.pub && \
    echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64 /" >> /etc/apt/sources.list.d/cuda.list
RUN apt-get update && \
    apt-get install -qy --no-install-recommends \
        cuda-cudart-11-6=${NV_CUDA_CUDART_VERSION} \
        ${NV_CUDA_COMPAT_PACKAGE} \
        cuda-libraries-11-6=${NV_CUDA_LIB_VERSION} \
        ${NV_LIBNPP_PACKAGE} \
        cuda-nvtx-11-6=${NV_NVTX_VERSION} \
        libcusparse-11-6=${NV_LIBCUSPARSE_VERSION} \
        ${NV_LIBCUBLAS_PACKAGE} \
        ${NV_LIBNCCL_PACKAGE} \
        libtinfo5 libncursesw5 \
        cuda-cudart-dev-11-6=${NV_CUDA_CUDART_DEV_VERSION} \
        cuda-command-line-tools-11-6=${NV_CUDA_LIB_VERSION} \
        cuda-minimal-build-11-6=${NV_CUDA_LIB_VERSION} \
        cuda-libraries-dev-11-6=${NV_CUDA_LIB_VERSION} \
        cuda-nvml-dev-11-6=${NV_NVML_DEV_VERSION} \
        ${NV_LIBNPP_DEV_PACKAGE} \
        libcusparse-dev-11-6=${NV_LIBCUSPARSE_DEV_VERSION} \
        ${NV_LIBCUBLAS_DEV_PACKAGE} \
        ${NV_LIBNCCL_DEV_PACKAGE} && \
    rm -rf /var/lib/apt/lists/*
RUN sed -i '$d' /etc/apt/apt.conf && \
    sed -i '$d' /etc/apt/apt.conf
RUN apt-mark hold ${NV_LIBCUBLAS_PACKAGE_NAME} ${NV_LIBNCCL_PACKAGE_NAME} ${NV_LIBCUBLAS_DEV_PACKAGE_NAME} ${NV_LIBNCCL_DEV_PACKAGE_NAME}

RUN ln -s cuda-11.6 /usr/local/cuda

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,graphics,utility,display
