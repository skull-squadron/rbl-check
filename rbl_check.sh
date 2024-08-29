#!/bin/bash
#
# Copyright 2022 
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
)
domains=(
  0spam-killlist.fusionzero.com
  0spam.fusionzero.com
  0spamtrust.fusionzero.com
  access.redhawk.org
  accredit.habeas.com
  all.dnsbl.bit.nl
  all.rbl.jp
  all.s5h.net
  all.spamrats.com
  asn.routeviews.org
  aspath.routeviews.org
  aspews.ext.sorbs.net
  b.barracudacentral.org
  backscatter.spameatingmonkey.net
  bad.psky.me
  badnets.spameatingmonkey.net
  bb.barracudacentral.org
  bitonly.dnsbl.bit.nl
  bl.blocklist.de
  bl.drmx.org
  bl.mailspike.net
  bl.mav.com.br
  bl.scientificspam.net
  bl.score.senderscore.com
  bl.shlink.org
  bl.spamcop.net
  bl.spameatingmonkey.net
  bl.spamstinks.com
  bl.suomispam.net
  blackholes.mail-abuse.org
  blacklist.sci.kun.nl
  block.dnsbl.sorbs.net
  bsb.spamlookup.net
  cbl.abuseat.org
  ccess.redhawk.org
  combined.rbl.msrbl.net
  csi.cloudmark.com
  db.wpbl.info
  dnsbl-0.uceprotect.net
  dnsbl-1.uceprotect.net
  dnsbl-2.uceprotect.net
  dnsbl-3.uceprotect.net
  dnsbl.cobion.com
  dnsbl.inps.de
  dnsbl.justspam.org
  dnsbl.kempt.net
  dnsbl.net.ua
  dnsbl.rv-soft.info
  dnsbl.rymsho.ru
  dnsbl.sorbs.net
  dnsbl.spam-champuru.livedoor.com
  dnsbl.tornevall.org
  dnsbl.webequipped.com
  dnsbl.zapbl.net
  dnsblchile.org
  dnsrbl.swinog.ch
  dnswl.inps.de
  drone.abuse.ch
  dsn.rfc-ignorant.org
  dyna.spamrats.com
  dynip.rothen.com
  escalations.dnsbl.sorbs.net
  eswlrev.dnsbl.rediris.es
  feb.spamlab.com
  fnrbl.fast.net
  forbidden.icm.edu.pl
  free.v4bl.org
  geobl.spameatingmonkey.net
  gl.suomispam.net
  hil.habeas.com
  hostkarma.junkemailfilter.com
  httpbl.abuse.ch
  hul.habeas.com
  iadb.isipp.com
  iadb2.isipp.com
  images.rbl.msrbl.net
  ip.v4bl.org
  ipbl.zeustracker.abuse.ch
  ips.backscatterer.org
  ips.whitelisted.org
  ispmx.pofon.foobar.hu
  ix.dnsbl.manitu.net
  korea.services.net
  l1.bbfh.ext.sorbs.net
  l2.bbfh.ext.sorbs.net
  l3.bbfh.ext.sorbs.net
  l4.bbfh.ext.sorbs.net
  list.bbfh.org
  list.blogspambl.com
  list.dnswl.org
  list.quorum.to
  mail-abuse.blacklist.jippg.org
  mtawlrev.dnsbl.rediris.es
  multi.surbl.org
  netbl.spameatingmonkey.net
  netblock.pedantic.org
  netscan.rbl.blockedservers.com
  new.spam.dnsbl.sorbs.net
  nobl.junkemailfilter.com
  noptr.spamrats.com
  old.spam.dnsbl.sorbs.net
  opm.tornevall.org
  orvedb.aupads.org
  phishing.rbl.msrbl.net
  plus.bondedsender.org
  pofon.foobar.hu
  problems.dnsbl.sorbs.net
  proxies.dnsbl.sorbs.net
  psbl.surriel.com
  query.bondedsender.org
  rbl-plus.mail-abuse.org
  rbl.abuse.ro
  rbl.blockedservers.com
  rbl.choon.net
  rbl.dns-servicios.com
  rbl.efnet.org
  rbl.fasthosts.co.uk
  rbl.iprange.net
  rbl.lugh.ch
  rbl.schulte.org
  rbl.suresupport.com
  rbl.talkactive.net
  rbl2.triumf.ca
  recent.spam.dnsbl.sorbs.net
  relays.bl.kundenserver.de
  relays.dnsbl.sorbs.net
  relays.mail-abuse.org
  relays.nether.net
  rep.mailspike.net
  rsbl.aupads.org
  rwl.choon.net
  sa-accredit.habeas.com
  sa.senderbase.org
  safe.dnsbl.sorbs.net
  sbl-xbl.spamhaus.org
  sbl.nszones.com
  score.senderscore.com
  service.mailwhitelist.com
  singular.ttk.pte.hu
  sohul.habeas.com
  spam.dnsbl.anonmails.de
  spam.pedantic.org
  spam.rbl.blockedservers.com
  spam.rbl.msrbl.net
  spam.spamrats.com
  spamguard.leadmon.net
  spamlist.or.kr
  spamsources.fabel.dk
  st.technovision.dk
  swl.spamhaus.org
  tor.efnet.org
  torexit.dan.me.uk
  truncate.gbudb.net
  trusted.nether.net
  ubl.unsubscore.com
  unsure.nether.net
  v4.fullbogons.cymru.com
  virbl.bit.nl
  virbl.dnsbl.bit.nl
  virus.rbl.msrbl.net
  vote.drbl.caravan.ru
  vote.drbl.gremlin.ru
  wadb.isipp.com
  wbl.triumf.ca
  web.rbl.msrbl.net
  whitelist.sci.kun.nl
  wl.mailspike.net
  wl.nszones.com
  wl.shlink.org
  work.drbl.caravan.ru
  work.drbl.gremlin.ru
  z.mailspike.net
)

Version="1.0.1"
#black list check help func
Help() {
    printf "help\n"
    printf "[i ----> ip to check for blacklist]\n"
    printf "[f ----> file with list of ip to check]\n"
    printf "[v ----> version]\n"
    printf "[m ----> send check result via email]\n"
    printf "[h ----> help]\n"
}

[ -z "$1" ] && Help && exit 1
while getopts :i:f:v  FLAG; do
  case $FLAG in
    i)
      OPTERR=0
      if [[ "$OPTARG" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]];then
          IP_LIST=( "$OPTARG" )
      else
          echo "Enter the valid ip address.."
          exit 1
      fi
      ;;
    f)
      if [ -f "$OPTARG" ]; then
         IP_LIST=()
         while read -r ips; do
           if [[ "$ips" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
              IP_LIST+=("$ips")
           else
              echo "$ips is not an valid ip adddress."
              exit 1
           fi
         done < "$OPTARG"
      else
          echo "$OPTARG No such file or Directory"
          exit 1
      fi
     ;;
    v)
       printf "%s\n" "${Version}"
      ;;
    \?)
      Help
      exit 1
      ;;
    :)
      echo "Error: -${OPTARG} requires an argument."
      Help
      exit 1
      ;;
  esac
done


# ip check again rbl..
for IP in ${IP_LIST[*]}; do
  #////////////////////////////////////////////////////
  revv=$(echo "$IP"| awk -F "." '{print $4"."$3"."$2"."$1}')
  status=0
  #/////////////////////////////////////////////////////
  for domain in ${domains[*]}; do
      echo -en "\e[32m \e[1mChecking IP $IP in RBL ${domain}...              \e[0m\r"
      ipcheck=($(dig +short "$revv.${domain}"))
      if [[ -n "$ipcheck" ]]; then
          echo -e "\e[1m\e[31mIP $IP is Blacklisted in ${domain} \e[0m" status code "${ipcheck[*]}"
          status+=1
      fi
  done
  [[ $status -ne 0 ]] && echo -e "\e[32m\e[1mIP $IP is Not Blacklisted in RBL.... \e[0m"
done
#//////////////////////////////////////////////////////////////////////////
##################################################### end of script ############################################################
