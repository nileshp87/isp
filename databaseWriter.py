#!/bin/python2.7

import dpkt
import binascii
import socket
import mysql.connector

def mac_to_ascii( mac_addr ):
    mac_addr = binascii.hexlify(mac_addr)
    s = list()
    for i in range(12/2) : 	# mac_addr should always be 12 chars, we work in groups of 2 chars
        s.append( mac_addr[i*2:i*2+2] )
    r = ":".join(s)		# I know this looks strange, refer to http://docs.python.org/library/stdtypes.html#sequence-types-str-unicode-list-tuple-bytearray-buffer-xrange
    return r

db = mysql.connector.connect(user='root',password='password',host='127.0.0.1',database='Packet')
dbwriter = db.cursor()
f = open('/tmp/fifolisteners/br-lan_0')
#f = open('/home/nileshp/code/isp/test.pcap')
pcap = dpkt.pcap.Reader(f)
i = 0
for ts, buf in pcap:
    metadata.Size = len(buf)
    metadata.Timestamp = ts
    addMetadata = "INSERT INTO Meta (Size, Timestamp) VALUES (" + meta.Size + ","  + \
        meta.Timestamp + ");"
    dbwriter.execute(addMetadata)
    
    try:
        eth = dpkt.ethernet.Ethernet(buf)




    i += 1
    print str(i)
    eth = dpkt.ethernet.Ethernet(buf)
    print '\tEthernet: ', mac_to_ascii(eth.src), ',', mac_to_ascii(eth.dst), str(eth.type)
    try:
        ip4 = eth.data
        top = "\t\tIP4: " + socket.inet_ntoa(ip4.src) + ", " + socket.inet_ntoa(ip4.dst) + ", " + str(ip4.p)
        print top
        try:
            tcp = ip.data
            top = "\t\t\tTCP: " + str(tcp.flags) + ", " + str(tcp.sport) + ", " + str(tcp.dport)
            print top
        except Exception:
            try:
                icmp = ip.data
                top = "\t\t\tICMP: " + str(icmp.code)
                print top
            except Exception:
                try:
                    udp = ip.data
                    top = "\t\t\tUDP: " + str(sport) + ", " + str(dport)
                    print top
                    try:
                        dhcp = udp.data
                        top = "\t\t\t\tDHCP: " + str(dhcp.op) + ", " + socket.inet_ntoa(dhcp.ciaddr)+ ", " + socket.inet_ntoa(dhcp.yiaddr)+ ", " + socket.inet_ntoa(dhcp.siaddr)+ ", " + socket.inet_ntoa(dhcp.giaddr)
                    except Exception:
                    	pass
                except Exception:
                    pass
    except Exception:
        try:
        	top = "\t\tARP: " + str(eth.arp.op)
        	print top
        except Exception:
            try:
                ip6 = eth.data
                top = "\t\tIP6: " + socket.inet_ntop(socket.AF_INET6,ip6.src) + ", " + socket.inet_ntop(socket.AF_INET6,ip6.dst) + ", " + str(ip6.v_fc_flow)
                print top
            except Exception: