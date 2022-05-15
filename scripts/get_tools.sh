# install req
sudo apt install libusb-1.0-0-dev -y

# get sunxi-tools, branch f1c100s
cd /tmp
# clone sunxi-tools from github
git clone https://github.com/Icenowy/sunxi-tools.git -b f1c100s --depth=1
make -C sunxi-tools -j12
sudo make -C sunxi-tools install
cd -
