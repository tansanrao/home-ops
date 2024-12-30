FROM ubuntu:24.04

# Install prerequisites
RUN apt-get update && apt-get install -y gpg wget curl \
  && install -dm 755 /etc/apt/keyrings \
  && wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | tee /etc/apt/keyrings/mise-archive-keyring.gpg 1> /dev/null \
  && echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=arm64] https://mise.jdx.dev/deb stable main" | tee /etc/apt/sources.list.d/mise.list \
  && apt-get update && apt-get install -y mise

# Activate mise
RUN echo 'eval "$(mise activate bash)"' >> ~/.bashrc

# Copy pwd into container
COPY . /work/home-ops

# Set working directory
WORKDIR /work/home-ops

# Install dependencies
RUN mise trust && mise install && mise run pip
