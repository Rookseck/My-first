#Credit: https://github.com/Area69Lab
#setup.sh VNC_USER_PASSWORD VNC_PASSWORD NGROK_AUTH_TOKEN

#disable spotlight indexing
sudo mdutil -i off -a

#Create new account
sudo dscl . -create /Users/alone
sudo dscl . -create /Users/alone UserShell /bin/zsh
sudo dscl . -create /Users/alone RealName "Alone"
sudo dscl . -create /Users/alone UniqueID 1001
sudo dscl . -create /Users/alone PrimaryGroupID 80
sudo dscl . -create /Users/alone NFSHomeDirectory /Users/alone
sudo dscl . -passwd /Users/alone $1
sudo dscl . -passwd /Users/alone $1
sudo createhomedir -c -u alone > /dev/null

#Git config
#git config --global user.name ""
#git config --global user.email



echo "initializing user session"
sudo cp -rf ./init-user /Users/alone
echo 'source ~/init-user' | sudo tee -a /Users/alone/.zshrc > /dev/null

sudo chown alone /Users/alone/.zshrc

#echo "Recovering data from "
#rsync -aPv -e "ssh -i /Users/alone/.ami.pem" $4 /Users/alone/

#echo "copying install_zsh script"
#sudo cp -rf ./install_zsh /Users/alone/
#sudo cp -rf ./fix-zsh-perm /Users/alone/

#echo "save to .zshrc for later use"
#echo 'source ~/install_zsh' | sudo tee /Users/alone/.zshrc

#Enable RM access for everyone
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -allowAccessFor -allUsers -privs -all

#install ngrok
brew install --cask ngrok

brew install vim
brew install emacs

#configure ngrok and start it
ngrok authtoken $3
ngrok tcp 22 --region=in &

killall Finder
