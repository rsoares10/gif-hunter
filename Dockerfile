FROM debian:bullseye-slim

# Flutter dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    file \
    unzip \
    xz-utils

# Add developer user
RUN useradd -ms /bin/bash developer
USER developer

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git $HOME/flutter

# Add flutter tool to PATH
ENV PATH /home/developer/flutter/bin:$PATH

# Display installation status
RUN flutter doctor

# Enable flutter WEB
RUN flutter upgrade
RUN flutter config --enable-web

# Copy files to container
WORKDIR $HOME/app
COPY ./ ./
