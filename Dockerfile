FROM dwang28/python3_selenium:1.1

#================================================
# Installations
#================================================

RUN apt-get update && apt-get install -y nginx

RUN pip3 install django==1.11.0

#============================
# Get Ready
#============================
CMD service nginx start

#============================
# Clean up
#============================
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

