#!/usr/bin/env bash
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
RBL_DOMAINS=(
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
  dnsbl.justspam.org
  dnsbl.kempt.net
  dnsbl.net.ua
  dnsbl.rv-soft.info
  dnsbl.rymsho.ru
  dnsbl.spam-champuru.livedoor.com
  dnsbl.tornevall.org
  dnsbl.webequipped.com
  dnsbl.zapbl.net
  dnsblchile.org
  dnsrbl.swinog.ch
  drone.abuse.ch
  dsn.rfc-ignorant.org
  dyna.spamrats.com
  dynip.rothen.com
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
  nobl.junkemailfilter.com
  noptr.spamrats.com
  opm.tornevall.org
  orvedb.aupads.org
  phishing.rbl.msrbl.net
  plus.bondedsender.org
  pofon.foobar.hu
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
  relays.bl.kundenserver.de
  relays.mail-abuse.org
  relays.nether.net
  rep.mailspike.net
  rsbl.aupads.org
  rwl.choon.net
  sa-accredit.habeas.com
  sa.senderbase.org
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

VERSION='1.0.1'
IP_LIST=()

if [[ -t 1 && "$COLOR" != none ]] || [ "$COLOR" = always ]; then
  RED='\e[31;1m'
  GREEN='\e[32;1m'
  YELLOW='\e[33;1m'
  BLUE='\e[34;1m'
  RESET='\e[0m'
else
  RED=
  GREEN=
  YELLOW=
  BLUE=
  RESET=
fi

help() {
  cat <<HELP
Usage: $(basename "$0") [OPTION]...

Options
  -i IP      check IP in blacklists
  -f FILE    use file as list of IPs to check
  -v         print version
  -h         print this help
  
HELP
  exit 1
}

assert_valid_ip4_address() {
  local IP=$1
  local IFS=.
  local N
  set -- $1
  for N in "$1" "$2" "$3" "$4"; do
    if [[ "$N" -lt 0 || "$N" -gt 255 ]]; then
      echo >&2 "$IP is not an valid IPv4 adddress"
      exit 1
    fi
  done
}

check_ip() {
  local IP=$1
  local STATUS=0
  local RBL_DOMAIN OUTPUT
  for RBL_DOMAIN in "${RBL_DOMAINS[@]}"; do
    echo -en "${YELLOW}Checking IP $IP in RBL $RBL_DOMAIN ...$RESET                                    \r"
    OUTPUT=($(dig +short "$(tac -s. <<< "$IP.")${RBL_DOMAIN}"))
    if [ -n "${OUTPUT[*]}" ]; then
      if [[ "${OUTPUT[*]}" =~ 'connection timed out' ]]; then
        echo -e "${BLUE}$RBL_DOMAIN cannot be reached $RESET status code ${OUTPUT[*]}"
      else
        echo -e "${RED}IP $IP is blacklisted in RBL $RBL_DOMAIN $RESET status code ${OUTPUT[*]}"
        STATUS+=1
      fi
    fi
  done
  if [ "$STATUS" = 0 ]; then
    echo -e "${GREEN}IP $IP was not found on any RBL${RESET}                                 "
  else
    echo -e "${RED}IP $IP is blocked due to inclusion in $STATUS RBL(s)${RESET}                 "
  fi
}

[ -z "$1" ] && help
while getopts :i:f:v FLAG; do
  case "$FLAG" in
    i)
      OPTERR=0
      assert_valid_ip4_address "$OPTARG"
      IP_LIST+=("$OPTARG")
      ;;
    f)
      if [ ! -r "$OPTARG" ]; then
        echo "Error: $OPTARG file not found or unreadable"
        exit 1
      fi
      while read -r IP; do
        assert_valid_ip4_address "$IP"
        IP_LIST+=("$IP")
      done < "$OPTARG"
      ;;
    v)
      printf '%s\n' "$VERSION"
      ;;
    \?)
      help
      ;;
    :)
      echo "Error: -$OPTARG requires an argument."
      help
      ;;
  esac
done

# ip check again rbl..
for IP in "${IP_LIST[@]}"; do
  check_ip "$IP"
done
##################################################### end of script ############################################################
