FROM dorothy-common AS dorothy-tui
# Do not require X resources
RUN echo "alias oz='oz --no-splash --no-x-resources --no-window-system'" >> ~/.bashrc
RUN echo "source ~/.bashrc" >> /bin/bash 
CMD oz && /bin/bash
