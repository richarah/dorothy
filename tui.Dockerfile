FROM dorothy-common AS dorothy-tui
# No logout upon Oz exit
CMD nohup oz & /bin/bash
