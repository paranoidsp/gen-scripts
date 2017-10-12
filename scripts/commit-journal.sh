#/bin/bash
echo '==========================================================================' | tee -a ~paranoidsp/.commit_journal.log
date | tee -a ~paranoidsp/.commit_journal.log
echo '---------------' | tee -a ~paranoidsp/.commit_journal.log
cd ~/git/lit
git add --all . | tee -a ~paranoidsp/.commit_journal.log
echo '---------------' | tee -a ~paranoidsp/.commit_journal.log
git commit -m "Machine Commit - $(date +%H:%M-%d/%m/%y)" | tee -a ~paranoidsp/commit_journal.log
echo '---------------' | tee -a ~paranoidsp/.commit_journal.log
git pull | tee -a ~paranoidsp/.commit_journal.log
echo '---------------' | tee -a ~paranoidsp/.commit_journal.log
git push | tee -a ~paranoidsp/.commit_journal.log
echo '---------------' | tee -a ~paranoidsp/.commit_journal.log
echo "Pushed Successfully." | tee -a ~paranoidsp/.commit_journal.log
echo '---------------' | tee -a ~paranoidsp/.commit_journal.log
notify-send 'Commmit Journal' 'Committed the Journal at $(date).'
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++' | tee -a ~paranoidsp/.commit_journal.log
