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
VERSION='1.0.1'
NAMESERVER='8.8.8.8'
IP_LIST=()
COLOR=auto
RBL_DOMAINS=(
  bl.mav.com.br
  rbl2.triumf.ca
  wbl.triumf.ca
  drone.abuse.ch
  httpbl.abuse.ch
  ipbl.zeustracker.abuse.ch
  rbl.lugh.ch
  dnsrbl.swinog.ch
  rbl.blockedservers.com
  netscan.rbl.blockedservers.com
  spam.rbl.blockedservers.com
  list.blogspambl.com
  csi.cloudmark.com
  dnsbl.cobion.com
  v4.fullbogons.cymru.com
  rbl.dns-servicios.com
  0spam-killlist.fusionzero.com
  0spam.fusionzero.com
  0spamtrust.fusionzero.com
  accredit.habeas.com
  hil.habeas.com
  hul.habeas.com
  sa-accredit.habeas.com
  sohul.habeas.com
  iadb.isipp.com
  iadb2.isipp.com
  wadb.isipp.com
  hostkarma.junkemailfilter.com
  nobl.junkemailfilter.com
  dnsbl.spam-champuru.livedoor.com
  service.mailwhitelist.com
  sbl.nszones.com
  wl.nszones.com
  dynip.rothen.com
  score.senderscore.com
  bl.score.senderscore.com
  feb.spamlab.com
  all.spamrats.com
  dyna.spamrats.com
  noptr.spamrats.com
  spam.spamrats.com
  bl.spamstinks.com
  rbl.suresupport.com
  psbl.surriel.com
  ubl.unsubscore.com
  dnsbl.webequipped.com
  spam.dnsbl.anonmails.de
  bl.blocklist.de
  relays.bl.kundenserver.de
  spamsources.fabel.dk
  st.technovision.dk
  eswlrev.dnsbl.rediris.es
  mtawlrev.dnsbl.rediris.es
  pofon.foobar.hu
  ispmx.pofon.foobar.hu
  singular.ttk.pte.hu
  dnsbl.rv-soft.info
  db.wpbl.info
  all.rbl.jp
  spamlist.or.kr
  bad.psky.me
  rbl.choon.net
  rwl.choon.net
  fnrbl.fast.net
  truncate.gbudb.net
  rbl.iprange.net
  dnsbl.kempt.net
  spamguard.leadmon.net
  bl.mailspike.net
  rep.mailspike.net
  wl.mailspike.net
  ix.dnsbl.manitu.net
  combined.rbl.msrbl.net
  images.rbl.msrbl.net
  phishing.rbl.msrbl.net
  spam.rbl.msrbl.net
  virus.rbl.msrbl.net
  web.rbl.msrbl.net
  relays.nether.net
  trusted.nether.net
  unsure.nether.net
  all.s5h.net
  bl.scientificspam.net
  korea.services.net
  bl.spamcop.net
  backscatter.spameatingmonkey.net
  badnets.spameatingmonkey.net
  bl.spameatingmonkey.net
  geobl.spameatingmonkey.net
  netbl.spameatingmonkey.net
  bl.suomispam.net
  gl.suomispam.net
  rbl.talkactive.net
  dnsbl-0.uceprotect.net
  dnsbl-1.uceprotect.net
  dnsbl-2.uceprotect.net
  dnsbl-3.uceprotect.net
  dnsbl.zapbl.net
  all.dnsbl.bit.nl
  bitonly.dnsbl.bit.nl
  virbl.dnsbl.bit.nl
  virbl.bit.nl
  blacklist.sci.kun.nl
  whitelist.sci.kun.nl
  cbl.abuseat.org
  orvedb.aupads.org
  rsbl.aupads.org
  ips.backscatterer.org
  b.barracudacentral.org
  bb.barracudacentral.org
  list.bbfh.org
  plus.bondedsender.org
  query.bondedsender.org
  dnsblchile.org
  list.dnswl.org
  bl.drmx.org
  rbl.efnet.org
  tor.efnet.org
  mail-abuse.blacklist.jippg.org
  dnsbl.justspam.org
  blackholes.mail-abuse.org
  rbl-plus.mail-abuse.org
  relays.mail-abuse.org
  netblock.pedantic.org
  spam.pedantic.org
  access.redhawk.org
  ccess.redhawk.org
  dsn.rfc-ignorant.org
  asn.routeviews.org
  aspath.routeviews.org
  rbl.schulte.org
  sa.senderbase.org
  bl.shlink.org
  wl.shlink.org
  sbl-xbl.spamhaus.org
  swl.spamhaus.org
  multi.surbl.org
  dnsbl.tornevall.org
  opm.tornevall.org
  free.v4bl.org
  ip.v4bl.org
  ips.whitelisted.org
  forbidden.icm.edu.pl
  rbl.abuse.ro
  uribl.abuse.ro
  vote.drbl.caravan.ru
  work.drbl.caravan.ru
  vote.drbl.gremlin.ru
  work.drbl.gremlin.ru
  dnsbl.rymsho.ru
  list.quorum.to
  dnsbl.net.ua
  rbl.fasthosts.co.uk
  torexit.dan.me.uk
)


###############################################@##@#### functions ####@@########################################################

help() {
  cat <<HELP
Usage: $(basename "$0") {-i IP | -f FILE}... [OPTION]...

Required arguments (one or more of the following)
  -i IP      check IP in blacklists
  -f FILE    use file as list to check, one IP per line

Options
  -c         always print using ANSI terminal colors
  -C         never print using ANSI terminal colors
  -h         print this help
  -n NS      use NS as resolver
  -N         use system resolver
  -v         print version
  
HELP
  exit 1
}

die() {
  echo >&2 "Error: $@"
  exit 1
}

assert_valid_ip4_address() {
  local IP=$1
  local IFS=.
  local N
  set -- $1
  for N in "$1" "$2" "$3" "$4"; do
    if [[ "$N" -lt 0 || "$N" -gt 255 ]]; then
      die "$IP is not an valid IPv4 adddress"
    fi
  done
}

check_ip() {
  local IP=$1 STATUS=0 RBL_DOMAIN OUTPUT
  for RBL_DOMAIN in "${RBL_DOMAINS[@]}"; do
    echo -en "${YELLOW}Checking IP $IP in RBL $RBL_DOMAIN ...$RESET                                    \r"
    OUTPUT=($(dig ${NAMESERVER:+@}${NAMESERVER} +short "$(tac -s. <<< "$IP.")${RBL_DOMAIN}"))
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

parse_args() {
  [ -z "$1" ] && help

  local FLAG OPTARG OPTERR IP COLOR_SET= NS_SET=
  
  while getopts cC:i:nN:f:v FLAG; do
    case "$FLAG" in
      i)
        OPTERR=0
        assert_valid_ip4_address "$OPTARG"
        IP_LIST+=("$OPTARG")
        ;;
      f)
        [ -r "$OPTARG" ] || die "$OPTARG file not found or unreadable"
        while read -r IP; do
          assert_valid_ip4_address "$IP"
          IP_LIST+=("$IP")
        done < "$OPTARG"
        ;;
      c)
        [ -z "$COLOR_SET" ] || die 'Color option already set'
        COLOR=always
        COLOR_SET=1
        ;;
      C)
        [ -z "$COLOR_SET" ] || die 'Color option already set'
        COLOR=never
        COLOR_SET=1
        ;;
      N)
        [ -z "$NS_SET" ] || die 'nameserver option already set'
        NAMESERVER=
        NS_SET=1
        ;;
      n)
        [ -z "$NS_SET" ] || die 'nameserver option already set'
        NAMESERVER="$OPTARG"
        NS_SET=1
        ;;
      v)
        printf '%s\n' "$VERSION"
        ;;
      \?)
        help
        ;;
      :)
        echo >&2 "Error: -$OPTARG requires an argument"
        echo >&2
        help
        ;;
    esac
  done

  if [ "${#IP_LIST[@]}" = 0 ]; then
    echo >&2 'Error: Must specify one or more -i IP or -f FILE options'
    echo >&2
    help
  fi
}

set_colors() {
  if [ "$COLOR" = always ] || [[ "$COLOR" = auto && -t 1 ]]; then
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
}

check_all_ips() {
  local IP
  for IP in "$@"; do
    check_ip "$IP"
  done
}

######################################################### main #################################################################

parse_args "$@"
set_colors
check_all_ips "${IP_LIST[@]}"

##################################################### end of script ############################################################
