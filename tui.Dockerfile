FROM dorothy-common AS dorothy-tui
# No logout upon Oz exit
CMD oz && /bin/bash
