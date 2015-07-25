#!/usr/bin/env python2.7

import urllib
import urllib2
import time
import string
import OSC

#Requesting the page
substring_la="LA:"
substring_lo="LO"


while True:
    url = "http://www.opensats.net/ajax/opensats/satellites/positions.php?hash=c486fadd059dfee979d241904feb7888&units=imperial&geocoords=decimal&timezone=America%2FLos_angeles&n=25544%2C-1%2C-2"
    req = urllib2.Request(url)
    response = urllib2.urlopen(url)
    data = response.read()
    storedData = str(data)
    #print storedData
    #print storedData.count("LA:")

    if substring_la in storedData and substring_lo in storedData:
      latestIndex_la = storedData.rindex(substring_la, 0, len(storedData))
      latestIndex_lo = storedData.rindex(substring_lo, 0, len(storedData))

      laNos = storedData.count(substring_la, 0, len(storedData))
      loNos = storedData.count(substring_lo, 0, len(storedData))

      lastLA = storedData[latestIndex_la+3: latestIndex_la+10]
      lastLO = storedData[latestIndex_lo+3: latestIndex_lo+10]

      #conversion
      LA = float(lastLA)
      LO = float(lastLO)

      print " "
      #print "Found", laNos, "Latitude points. ", "The index of latest Latitude point is: ", latestIndex_la, ".  LA: ", float(lastLA)
      print "LAT: ", LA, "  LONG: ", LO

      #time.sleep(3)


      co = OSC.OSCClient()
      co.connect( ('127.0.0.1', 8000) )
      rNum= OSC.OSCMessage()
      rNum.setAddress("/print")
      rNum.append(LA)
      rNum.append(LO)
      #print rNum
      co.send(rNum)

      time.sleep(6)


