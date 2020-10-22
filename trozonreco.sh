#!/bin/bash
#coded by R0X4R

if [ -z "$1" ]
  then
    echo "Target domain not supplied"
    echo "Usage : trozon target.com filename"
    exit 1
fi

if [ -z "$2" ]
  then
    echo "Output filename not supplied"
    echo "Usage : trozon target.com filename"
    exit 1
fi

if [ -z "$3" ]
  then
    echo "Tool not supplied either use waybackurls or gau"
    echo "Usage : trozon target.com filename waybackurls or gau"
    exit 1
fi

if [ ! -d "$2" ]; then
        mkdir $2
fi

RED="\e[31m"
BOLD="\e[1m"
NORMAL="\e[0m"
GREEN="\e[92m"

echo -e ${GREEN}"\n          .                                                      . "
echo -e ${GREEN}"        .n                   .                 .                  n. "
echo -e ${GREEN}"  .   .dP                  dP                   9b                 9b.    . "
echo -e ${GREEN}" 4    qXb         .       dX                     Xb       .        dXp     t "
echo -e ${GREEN}"dX.    9Xb      .dXb    __                         __    dXb.     dXP     .Xb "
echo -e ${GREEN}"9XXb._       _.dXXXXb dXXXXbo.                 .odXXXXb dXXXXb._       _.dXXP "
echo -e ${GREEN}" 9XXXXXXXXXXXXXXXXXXXVXXXXXXXXOo.           .oOXXXXXXXXVXXXXXXXXXXXXXXXXXXXP "
echo -e ${GREEN}"  v9XXXXXXXXXXXXXXXXXXXXXi-   -vOOO8b   d8OOOi-   -vXXXXXXXXXXXXXXXXXXXXXPi "
echo -e ${GREEN}"    v9XXXXXXXXXXXPi v9XXi   DIE    v98v8Pi  HUMAN   vXXPi v9XXXXXXXXXXXPi "
echo -e ${GREEN}"        -------       9X.          .db|db.          .XP       ------- "
echo -e ${GREEN}"                        )b.  .dbo.dPivviv9b.odb.  .dX( "
echo -e ${GREEN}"                      ,dXXXXXXXXXXXb     dXXXXXXXXXXXb. "
echo -e ${GREEN}"                     dXXXXXXXXXXXPi   .   v9XXXXXXXXXXXb "
echo -e ${GREEN}"                    dXXXXXXXXXXXXb   d|b   dXXXXXXXXXXXXb "
echo -e ${GREEN}"                    9XXbi   vXXXXXb.dX|Xb.dXXXXXi   vdXXP "
echo -e ${GREEN}"                     vi      9XXXXXX(   )XXXXXXP      vi "
echo -e ${GREEN}"                              XXXX X.vvi.X XXXX "
echo -e ${GREEN}"                              XP^Xivb   divX^XX "
echo -e ${GREEN}"                              X. 9  v   i  P )X "
echo -e ${GREEN}"                              vb  v       i  di "
echo -e ${GREEN}"                               v             i "

echo -e "${RED}\n                          "
echo -e "${RED}                            "
echo -e "${NORMAL}${BOLD}\n                           coded by ${GREEN}TROZON${NORMAL}${BOLD} with ${RED}<3"
sleep 2

cd $2/
echo -e "${NORMAL}${BOLD}\nStarting scan on ${RED}$1${NORMAL}${BOLD}... \n"
sleep 2

echo -e "${NORMAL}Starting ${GREEN}Assetfinder${NORMAL} on $1..."
assetfinder --subs-only $1 |sort -u > $2-assetfinder.txt
sleep 2

echo -e "${NORMAL}Starting ${GREEN}Sublist3r${NORMAL} on $1..."
python3 ~/tools/Sublist3r/sublist3r.py -d $1 -o $2-sublister.txt > /dev/null
sleep 2

echo -e "${BOLD}\nFiltering subdomains of ${RED}$1... \n ${NORMAL} "
cat $2-sublister.txt $2-assetfinder.txt |grep -v "*" |sort -u > $2-finalsubdomains.txt
sleep 2

echo -e "${NORMAL}Starting ${GREEN}Httprobe${NORMAL} on all filtered subdomains..."
cat $2-finalsubdomains.txt | sort -u | uniq -u | httprobe > $2-alive.txt
sleep 2

echo -e "${NORMAL}Starting ${GREEN}Get-titles${NORMAL} to collect all titles of all subdomains..."
cat $2-alive.txt | httpx -title > $2-gettitle.txt
sleep 2

echo -e "${NORMAL}Starting ${GREEN}subdomain takeover${NORMAL} scan on $1..."
subjack -w $2-finalsubdomains.txt -t 20 -ssl -c ~/tools/fingerprints.json -o $2-subjack.txt
subzy -targets $2-finalsubdomains.txt -hide_fails --verify_ssl -concurrency 20 | sort -u > $2-subzy.txt
sleep 2

echo -e "${NORMAL}${BOLD}Starting ${GREEN}$3${NORMAL}${BOLD} param output on $1... ${NORMAL} "
sleep 2
cat $2-finalsubdomains.txt | $3 > $2-$3.txt

echo -e "Starting ${GREEN}XSS${NORMAL} param filtering on $1... ${NORMAL} "
sleep 2
cat $2-$3.txt | gf xss > $2-xss.txt

echo -e "Starting ${GREEN}SSRF${NORMAL} param filtering on $1... ${NORMAL} "
sleep 2
cat $2-$3.txt | gf ssrf > $2-ssrf.txt

echo -e "Starting ${GREEN}SSTI${NORMAL} param filtering on $1... ${NORMAL} "
sleep 2
cat $2-$3.txt | gf ssti > $2-ssti.txt

echo -e "Starting ${GREEN}REDIRECT${NORMAL} param filtering on $1... ${NORMAL} "
sleep 2
cat $2-$3.txt | gf redirect > $2-redirect.txt

echo -e "Starting ${GREEN}SQLi${NORMAL} param filtering on $1... ${NORMAL} "
sleep 2
cat $2-$3.txt | gf sqli > $2-sqli.txt

echo -e "Starting ${GREEN}LFI${NORMAL} param filtering on $1... ${NORMAL} "
sleep 2
cat $2-$3.txt | gf sqli > $2-lfi.txt

echo -e "Starting ${GREEN}RCE${NORMAL} param filtering on $1... ${NORMAL} "
sleep 2
cat $2-$3.txt | gf sqli > $2-rce.txt

echo -e "Starting ${GREEN}Directory Fuzzing${NORMAL} on $1... ${NORMAL} "
sleep 2
ffuf -w ~/wordlist/dicc.txt -u https://$1/FUZZ > $2-Dirfuzz.txt
~/tools/dirsearch/dirsearch.py dir -u $1/ -e php,aspx,docx,pdf,txt,js,json > $2-Dirsearch.txt

echo -e "Starting ${GREEN}Hakrawler for js files ${NORMAL} on $1... ${NORMAL} "
sleep 2
hakrawler -depth 4 -js -plain -url $1 > $2-jsfiles.txt

echo -e "Starting ${GREEN}Hakrawler for Links ${NORMAL} on $1... ${NORMAL} "
sleep 2
hakrawler -depth 4 -js -linkfinder -plain -url $1 | tee $2-jslinks.txt

echo -e "Starting ${GREEN}Git Hound ${NORMAL} on $1... ${NORMAL} "
sleep 2
git-hound --subdomain-file $2-finalsubdomains.txt --threads 50 | tee $2-githound.txt

echo -e "Starting ${GREEN}Broken Link Checker ${NORMAL} on $1... ${NORMAL} "
sleep 2
blc -rof --filter-level 3 https://$1/ | tee $2-brokenlinks.txt

echo -e "Starting ${GREEN}Running Dalfox ${NORMAL} on $1... ${NORMAL} "
sleep 2
cat $2-xss.txt | dalfox pipe | tee $2-dalfox.txt

sleep 2
echo -e "${BOLD}\nAll your outputs are save in ${GREEN}$2/ \n"