FROM dwang28/python3_selenium:1.0

#================================================
# Installations
#================================================

RUN apt-get update && apt-get install -y \
	wget zip unzip \
    git

#============================
# Get Ready
#============================
WORKDIR /usr/src/app


#============================
# Clean up
#============================
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

