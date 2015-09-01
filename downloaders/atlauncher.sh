#!/bin/bash
alias wgets='H="--header"; wget $H="Accept-Language: en-us,en;q=0.5" $H="Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" $H="Connection: keep-alive" -U "Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20100101 Firefox/10.0.2" --referer=/ '
echo "### Finding download link for ${1}"
echo "# Retrieving modpack page"
wgets ${1} -O /tmp/atl_dl_page
download_link=`grep -o -E "[\"']http:\/\/fs.atlcdn.net(.*)[\"']" /tmp/atl_dl_page`
if [ ! -z "${download_link}" ]; then
    echo "# Found link ${download_link}"
    wgets "${download_link//\"}" -O atl_server.zip
else
    echo "# Unable to find link, quitting"
    exit 1
fi


