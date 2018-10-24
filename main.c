#define SOCKET_ERR 1
#define INVALID_SOCKET 2

typedef int socket;

#include <winsock2.h>
#include <ws2tcpip.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <uinstd.h>
#include <string.h>
#include <netdb.h>
#include <errno.h>
#include <err.h>
#include <stdio.h>
#include <afxres.h>

int handle() {
    printf("[+] Ant starting up...");
    printf("[+] Attempting to make connection");

    socket Socket;
    struct sockaddr_in socket_addr_in;
    struct Socket sck ;

    sck(AF_INET, SOCK_STREAM, 0);
    socket_addr_in.sin_family = AF_INET;
    socket_addr_in.sin_port = htons(8081); //change if this port is in use
    socket_addr_in.sin_addr.S_un.S_addr = inet_addr("127.0.0.1");
    connect(sck, (struct sockaddr_in *) &socket_addr_in, sizeof(socket_addr_in));

    char req[3] = { 0x05, /* socks 5*/ 0x01, /* one auth*/ 0x00 /* no auth*/};
    send(sck, req, 3, MSG_DONTROUTE);
    char resp[2];
    recv(sck, resp, 2, 0);
    if(resp[1] != 0x00){
        printf("[!] Could not authenticate connection!");
        return -1;
    }

    printf("[+] Fetching info...");
    char *domain = "some_random_website.net";
    char domain_len = strlen(domain);
    short port = htons(8081);

    char temp_req[4] = {0x05, 0x01, 0x00, 0x003};

    char* req2[1] = {4 + 1 + domain_len + 2};
    memcpy(req2, temp_req, 4);
    memcpy(req2 + 4, &domain_len, 1);
    memcpy(req2 + 5, domain, domain_len);
    memcpy(req2 + 5 + domain_len, &port, 2);
    send(sck, (char *) req2, 4 + 1 + domain_len + 2, MSG_OOB);

}