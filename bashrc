export PATH=/usr/local/bin:$PATH
. /Users/vihari/.rbenvrc
. ~/.stripe-repos.sh
# BEGIN STRIPE NODE CONFIG
#      To undo the following behavior, comment it out, dont delete it;
#      'pay-server/scripts/frontend/install_node_modules' will just add it again.
#      Ask in #frontend-infra or #iteng if you have questions.
export PATH="node_modules/.bin:$PATH"
# END STRIPE NODE CONFIG
# BEGIN STRIPE NODE CONFIG
#      To undo the following behavior, comment it out, dont delete it;
#      'pay-server/scripts/frontend/install_node_modules' will just add it again.
#      Ask in #frontend-infra or #iteng if you have questions.
export PATH="./node_modules/.bin:$PATH"
# END STRIPE NODE CONFIG

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
