#setup requirements for the program and run it
#ideal for the first time running on your computer

#remove Gemfile.lock (disabled as .gitignore file was working)
#rm Gemfile.lock
#install Bundle
gem install bundle
#install the Ruby gems for the program
bundle install
#clear the screen
clear
#run the program
ruby main.rb $1