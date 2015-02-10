create database Packet;
use Packet;
-- tables
-- Table ARP
CREATE TABLE ARP (
    ID int    NOT NULL ,
    operation int    NOT NULL ,
    CONSTRAINT ARP_pk PRIMARY KEY (ID)
);

-- Table DHCP
CREATE TABLE DHCP (
    ID int    NOT NULL ,
    CONSTRAINT DHCP_pk PRIMARY KEY (ID)
);

-- Table DHCP4
CREATE TABLE DHCP4 (
    ID int    NOT NULL ,
    operation int    NOT NULL ,
    client_ip varchar(15)    NOT NULL ,
    your_ip varchar(15)    NOT NULL ,
    server_ip varchar(15)    NOT NULL ,
    gateway_ip varchar(15)    NOT NULL ,
    CONSTRAINT DHCP4_pk PRIMARY KEY (ID)
);

-- Table DHCP6
CREATE TABLE DHCP6 (
    ID int    NOT NULL ,
    CONSTRAINT DHCP6_pk PRIMARY KEY (ID)
);

-- Table Ethernet
CREATE TABLE Ethernet (
    ID int    NOT NULL ,
    source_mac varchar(17)    NOT NULL ,
    dest_mac varchar(17)    NOT NULL ,
    protocol int    NOT NULL ,
    CONSTRAINT Ethernet_pk PRIMARY KEY (ID)
);

-- Table HTTP
CREATE TABLE HTTP (
    ID int    NOT NULL ,
    body text    NOT NULL ,
    CONSTRAINT HTTP_pk PRIMARY KEY (ID)
);

-- Table HTTP_Request
CREATE TABLE HTTP_Request (
    ID int    NOT NULL ,
    URI varchar(50)    NOT NULL ,
    method char(10)    NOT NULL ,
    CONSTRAINT HTTP_Request_pk PRIMARY KEY (ID)
);

-- Table HTTP_Response
CREATE TABLE HTTP_Response (
    ID int    NOT NULL ,
    status_code int    NOT NULL ,
    CONSTRAINT HTTP_Response_pk PRIMARY KEY (ID)
);

-- Table ICMP
CREATE TABLE ICMP (
    ID int    NOT NULL ,
    type int    NOT NULL ,
    code int    NOT NULL ,
    CONSTRAINT ICMP_pk PRIMARY KEY (ID)
);

-- Table IP
CREATE TABLE IP (
    ID int    NOT NULL ,
    protocol int    NOT NULL ,
    CONSTRAINT IP_pk PRIMARY KEY (ID)
);

-- Table IP4
CREATE TABLE IP4 (
    ID int    NOT NULL ,
    source_ip varchar(15)    NOT NULL ,
    dest_ip varchar(15)    NOT NULL ,
    CONSTRAINT IP4_pk PRIMARY KEY (ID)
);

-- Table IP6
CREATE TABLE IP6 (
    ID int    NOT NULL ,
    source_ip varchar(29)    NOT NULL ,
    dest_ip varchar(29)    NOT NULL ,
    CONSTRAINT IP6_pk PRIMARY KEY (ID)
);

-- Table Meta
CREATE TABLE Meta (
    ID int    NOT NULL AUTO_INCREMENT,
    Size int    NOT NULL ,
    Timestamp timestamp    NOT NULL ,
    CONSTRAINT Meta_pk PRIMARY KEY (ID)
);

-- Table TCP
CREATE TABLE TCP (
    ID int    NOT NULL ,
    source_port int    NOT NULL ,
    dest_port int    NOT NULL ,
    control_flag int    NOT NULL ,
    CONSTRAINT TCP_pk PRIMARY KEY (ID)
);

-- Table UDP
CREATE TABLE UDP (
    ID int    NOT NULL ,
    source_port int    NOT NULL ,
    dest_port int    NOT NULL ,
    CONSTRAINT UDP_pk PRIMARY KEY (ID)
);





-- foreign keys
-- Reference:  DHCP4_DHCP (table: DHCP4)


ALTER TABLE DHCP4 ADD CONSTRAINT DHCP4_DHCP FOREIGN KEY DHCP4_DHCP (ID)
    REFERENCES DHCP (ID);
-- Reference:  DHCP6_DHCP (table: DHCP6)


ALTER TABLE DHCP6 ADD CONSTRAINT DHCP6_DHCP FOREIGN KEY DHCP6_DHCP (ID)
    REFERENCES DHCP (ID);
-- Reference:  DHCP_UDP (table: DHCP)


ALTER TABLE DHCP ADD CONSTRAINT DHCP_UDP FOREIGN KEY DHCP_UDP (ID)
    REFERENCES UDP (ID);
-- Reference:  Ethernet_Meta (table: Ethernet)


ALTER TABLE Ethernet ADD CONSTRAINT Ethernet_Meta FOREIGN KEY Ethernet_Meta (ID)
    REFERENCES Meta (ID);
-- Reference:  HTTP_Request_HTTP (table: HTTP_Request)


ALTER TABLE HTTP_Request ADD CONSTRAINT HTTP_Request_HTTP FOREIGN KEY HTTP_Request_HTTP (ID)
    REFERENCES HTTP (ID);
-- Reference:  HTTP_Response_HTTP (table: HTTP_Response)


ALTER TABLE HTTP_Response ADD CONSTRAINT HTTP_Response_HTTP FOREIGN KEY HTTP_Response_HTTP (ID)
    REFERENCES HTTP (ID);
-- Reference:  HTTP_TCP (table: HTTP)


ALTER TABLE HTTP ADD CONSTRAINT HTTP_TCP FOREIGN KEY HTTP_TCP (ID)
    REFERENCES TCP (ID);
-- Reference:  ICMP_IP (table: ICMP)


ALTER TABLE ICMP ADD CONSTRAINT ICMP_IP FOREIGN KEY ICMP_IP (ID)
    REFERENCES IP (ID);
-- Reference:  TCP_IP (table: TCP)


ALTER TABLE TCP ADD CONSTRAINT TCP_IP FOREIGN KEY TCP_IP (ID)
    REFERENCES IP (ID);
-- Reference:  Table_3_Ethernet (table: ARP)


ALTER TABLE ARP ADD CONSTRAINT Table_3_Ethernet FOREIGN KEY Table_3_Ethernet (ID)
    REFERENCES Ethernet (ID);
-- Reference:  Table_4_Ethernet (table: IP)


ALTER TABLE IP ADD CONSTRAINT Table_4_Ethernet FOREIGN KEY Table_4_Ethernet (ID)
    REFERENCES Ethernet (ID);
-- Reference:  Table_5_IP (table: IP6)


ALTER TABLE IP6 ADD CONSTRAINT Table_5_IP FOREIGN KEY Table_5_IP (ID)
    REFERENCES IP (ID);
-- Reference:  Table_6_IP (table: IP4)


ALTER TABLE IP4 ADD CONSTRAINT Table_6_IP FOREIGN KEY Table_6_IP (ID)
    REFERENCES IP (ID);
-- Reference:  UDP_IP (table: UDP)


ALTER TABLE UDP ADD CONSTRAINT UDP_IP FOREIGN KEY UDP_IP (ID)
    REFERENCES IP (ID);



-- End of file.

