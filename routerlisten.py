#!/bin/python

import argparse
import subprocess
import os

def getInterfaces():
    try: 
        return subprocess.check_output("ssh root@" + arguments.IP + \
            " -C ls /sys/class/net", shell=True).decode("utf-8")
    except subprocess.CalledProcessError:
        return False

def listInterfaces():
    interfaces = getInterfaces()
    if not interfaces:
        print("SSH call failed, either there's no path to the host" + 
            " or your keys aren't setup correctly, try running setup")
    else:
        print('Available Interfaces:\n\t' + interfaces.replace('\n','\n\t'))

def setupRouter():
    print("Not yet implemented")

def hasInterface():
    interfaces = getInterfaces().split("\n")
    return arguments.interface in interfaces

def captureRouter(): 
    import atexit
    atexit.register(cleanup)
    try: 
        os.system("mkdir /tmp/fifolisteners > /dev/null 2>&1")
        ssh_command = "ssh root@" + arguments.IP + " tcpdump -s 0 -U -n -w - -i " + \
            arguments.interface + " " + arguments.filter + " | tee"
        for i in range(arguments.numfifos):
            os.system("mkfifo /tmp/fifolisteners/" + arguments.interface + "_" + str(i))
            ssh_command += " /tmp/fifolisteners/" + arguments.interface + "_" + str(i)
        ssh_command += " > /dev/null"
        print("Spawning SSH, with fifo at /tmp/fifolisteners/" + \
            arguments.interface + ", press CTRL+C to exit")
        os.system(ssh_command)
        #os.system("ssh root@" + arguments.IP + \
        #    " \"tcpdump -s 0 -U -n -w - -i " + arguments.interface + " " + \
        #    arguments.filter + "\" | tee /tmp/fifolisteners/" + arguments.interface + \
        #    "*")

    except subprocess.CalledProcessError:
        print("SSH call failed, either there's no path to the host" + 
            " or your keys aren't setup correctly, try running setup")

def cleanup():
    print("Exiting...")
    os.system("rm -f /tmp/fifolisteners/" + arguments.interface + "*")

parser = argparse.ArgumentParser(description='Setup ability to perform" + \
    " remote packet capture on a router')
parser.add_argument('command', choices=['list','setup','capture'])
parser.add_argument('IP', action='store', help='the IP of the target router')
parser.add_argument('-f','--filter', required=False, help='optional filter" + \
    " to append to tcp dump', default="not port 22")
parser.add_argument('-i','--interface', required=False, help='the interface' + \
    " to listen on, use with capture command")
parser.add_argument('-n','--numfifos', required=False, help='the number of' + \
    " fifos to create", default=1, type=int)

arguments = parser.parse_args()

if arguments.command == 'list':
    listInterfaces()
    exit(0)

if arguments.command == 'setup':
    setupRouter()
    exit(0)

if arguments.command == 'capture':
    if arguments.interface == None:
        print("You must specify an interface to listen on.")
        listInterfaces()
        exit(0)
    if not hasInterface():
        print("That interface does not exist on the target.")
        listInterfaces()
        exit(0)
    captureRouter()
    exit(0)
