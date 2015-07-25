import OSC
import time, random

try :
    """
    while 1: # endless loop
        co = OSC.OSCClient()
        co.connect( ('127.0.0.1', 8000) )
        rNum= OSC.OSCMessage()
        rNum.setAddress("/print")
        rNum.append(float(random.randint(2, 200)))
        print rNum
        co.send(rNum)
        time.sleep(5) # wait here some secs
        """
    while 1: # endless loop
        co = OSC.OSCClient()
        co.connect( ('127.0.0.1', 8000) )
        msg = OSC.OSCBundle()
        msg.setAddress("/print")
        msg.append(44)
        msg.append(4.5233) # float
        msg.append( "the white cliffs of dover" ) # string
        co.send(msg)
        print msg
        time.sleep(5)



except KeyboardInterrupt:
    print "Closing OSCClient"
    c.close()
    print "Done"





