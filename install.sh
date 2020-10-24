#!/bin/bash
sudo apt-get install python3-pip;
python3 -m pip install --upgrade pip;
sudo apt-get install ruby;
sudo apt-get install screen;
sudo apt-get install git;
mkdir ~/Tools;
mkdir ~/wordlist;
mkdir ~/tools;
pip3 install requests;
chmod +x trozonreco;
chmod +x trozonreco.sh;
mv trozonreco /usr/local/bin;
#tools
cd ~/tools;
go get -u github.com/tomnomnom/assetfinder;
go get github.com/tomnomnom/hacks/waybackurls;
go get github.com/hakluke/hakrawler;
GO111MODULE=on go get -u -v github.com/lc/gau;
go get -u github.com/tomnomnom/gf;
cd ~/;
mkdir ~/.gf;
git clone https://github.com/1ndianl33t/Gf-Patterns;
mv ~/Gf-Patterns/*.json ~/.gf;
rm -rf ~/Gf-Patterns;
wget https://raw.githubusercontent.com/devanshbatham/ParamSpider/master/gf_profiles/potential.json;
mv ./potential.json ~/.gf;
GO111MODULE=on go get -u -v github.com/projectdiscovery/httpx/cmd/httpx;
go get github.com/ffuf/ffuf;
go get github.com/haccer/subjack;
wget https://github.com/haccer/subjack/blob/master/fingerprints.json -o ~/tools/fingerprints.json
GO111MODULE=on go get -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder;
GO111MODULE=on go get -u -v github.com/hahwul/dalfox;
wget https://raw.githubusercontent.com/Mad-robot/recon-tools/master/dicc.txt -o ~/wordlist/dicc.txt;

GO111MODULE=on go get -u -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei
git clone https://github.com/tillson/git-hound ~/Tools/git-hound; cd /root/Tools/git-hound; go build; mv git-hound /root/go/bin/; cd ~;
git clone https://github.com/projectdiscovery/nuclei-templates ~/Tools/nuclei-templates;
git clone https://github.com/aboul3la/Sublist3r.git ~/tools/;;
cd ~/tools/Sublist3r/;
sudo pip install -r requirements.txt;
cd ~/tools/;
git clone https://github.com/maurosoria/dirsearch.git;
cd dirsearch;
chmod +x dirsearch.py;
cd ~/tools/;
sudo apt install nodejs -y;
apt install npm
npm install broken-link-checker -g;

go build .;

echo "
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
alias osmedeus='python3 ~/Tools/Osmedeus/osmedeus.py -m subdomain,portscan,vuln,git,burp,ip -t'
alias dirsearch='python3 ~/Tools/dirsearch/dirsearch.py -e php,asp,js,aspx,jsp,py,txt,conf,config,bak,backup,swp,old,db,sql -t 300 -u'
alias ffuf=~/go/bin/ffuf
alias httpx=~/go/bin/httpx
alias gf=~/go/bin/gf
alias waybackurls=~/go/bin/waybackurls
alias gau=~/go/bin/gau
alias nuclei=~/go/bin/nuclei
" >> ~/.bash_rc;


