#================================================
# Python 3 Selenium
#
# Based on images pimuzzo/selenium-python-xvfb
# https://hub.docker.com/r/pimuzzo/selenium-python-xvfb/
#================================================

FROM ubuntu:14.04

ENV BROWSER Firefox
ENV DISPLAY :99

#================================================
# Installations
#================================================

RUN apt-get update && apt-get install -y $BROWSER \
        build-essential libssl-dev python-setuptools \
        vim xvfb xz-utils zlib1g-dev \
        python3-pip

# this is for python 2
# RUN easy_install pip
# RUN pip install selenium pyvirtualdisplay requests unittest-xml-reporting

# for python 3
RUN pip3 install selenium pyvirtualdisplay requests unittest-xml-reporting



#==================
# Install Geckodriver (webdriver for firefox)
#==================
RUN mkdir /usr/bin/geckodriver && \
	wget -P /usr/bin/geckodriver https://github.com/mozilla/geckodriver/releases/download/v0.19.1/geckodriver-v0.19.1-linux64.tar.gz && \
	tar -xvzf /usr/bin/geckodriver/geckodriver-v0.19.1-linux64.tar.gz -C /usr/bin/geckodriver && \
	rm /usr/bin/geckodriver/geckodriver-v0.19.1-linux64.tar.gz && \
	chmod +x /usr/bin/geckodriver/geckodriver

ENV PATH="${PATH}:/usr/bin/geckodriver"



#==================
# Vim highlight
#==================

RUN echo "syntax on" >> /etc/vim/vimrc

#==================
# Xvfb + init scripts
#==================
ADD libs/xvfb_init /etc/init.d/xvfb
RUN chmod a+x /etc/init.d/xvfb

ADD libs/xvfb-daemon-run /usr/bin/xvfb-daemon-run
RUN chmod a+x /usr/bin/xvfb-daemon-run


#============================
# Clean up
#============================
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

