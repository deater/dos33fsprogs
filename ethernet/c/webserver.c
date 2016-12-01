#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <fcntl.h>

#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <time.h>

#define BUFFER_SIZE	256

/* assume the max command we get is this big */
#define RECEIVE_BUFFER_SIZE	4096


/* Default port to listen on */
#define DEFAULT_PORT	80


#define MIME_HTML	0
#define MIME_TXT	1
#define MIME_PNG	2
#define MIME_JPG	3
#define MIME_MAX	4



struct mime_type {
	char	extension[5];
	char	string[32];
};

struct mime_type mime[MIME_MAX] = {
	{"html",	"text/html"},
	{"txt",		"text/plain"},
	{"png",		"image/png"},
	{"jpg",		"image/jpeg"},
};

static int detect_mime(char *filename) {

	int i,j;

	i=strlen(filename);
	while(i>0) {
		if (filename[i]=='.') break;
		i--;
	}
	i++;

	for(j=0;j<MIME_MAX;j++) {
		if (!strcmp(filename+i,mime[j].extension)) {
			printf("Found filetype %s\n",mime[j].string);
			return j;
		}
	}




	return MIME_HTML;
}

static int serve_file(int fd, char *filename) {

	int n,result,mime_type,out_size=0;
	char time_string[1000];
	time_t now = time(NULL);
	struct tm tm = *gmtime(&now);
	struct stat stat_buf;
	char out_buffer[4096];

	strftime(time_string, sizeof(time_string),
		"%a, %d %b %Y %H:%M:%S %Z", &tm);

	result=stat(filename,&stat_buf);

	mime_type=detect_mime(filename);

	if (strstr(filename,"teapot")) {
		char message418[]=
			"<html><head>\r\n"
			"<title>418 I'm a teapot</title>\r\n"
			"</head><body>\r\n"
			"<h1>I'm a Teapot</h1>\r\n"
			"<p>I'm a *little* teapot.<br />\r\n"
			"</p>\r\n"
			"</body></html>\r\n";

		sprintf(out_buffer,
			"HTTP/1.1 418 I'm a teapot\r\n"
			"Date: %s\r\n"
			"Server: VMW-web\r\n"
			"Content-Length: %d\r\n"
			"Connection: close\r\n"
			"Content-Type: text/html; charset=iso-8859-1\r\n"
			"\r\n"
			"%s",
			time_string,(int)strlen(message418),message418);
		out_size=strlen(out_buffer);

	} else if (result<0) {
		char message404[]=
			"<html><head>\r\n"
			"<title>400 Bad Request</title>\r\n"
			"</head><body>\r\n"
			"<h1>Bad Request</h1>\r\n"
			"<p>Your browser sent a request that this server could not understand.<br />\r\n"
			"</p>\r\n"
			"</body></html>\r\n";

		sprintf(out_buffer,
			"HTTP/1.1 400 Bad Request\r\n"
			"Date: %s\r\n"
			"Server: VMW-web\r\n"
			"Content-Length: %d\r\n"
			"Connection: close\r\n"
			"Content-Type: text/html; charset=iso-8859-1\r\n"
			"\r\n"
			"%s",
			time_string,(int)strlen(message404),message404);
		out_size=strlen(out_buffer);
	}

	else {
		char mod_string[1000];
		tm = *gmtime(&stat_buf.st_mtime);
		int in_fd,out_offset;
		char file_buffer[256];

		strftime(mod_string, sizeof(mod_string),
			"%a, %d %b %Y %H:%M:%S %Z", &tm);

		sprintf(out_buffer,
			"HTTP/1.1 200 OK\r\n"
			"Date: %s\r\n"
			"Server: VMW-web\r\n"
			"Last-Modified: %s\r\n"
			"Content-Length: %ld\r\n"
			"Content-Type: %s\r\n"
			"\r\n",
			time_string,
			mod_string,
			stat_buf.st_size,
			mime[mime_type].string);

			out_offset=strlen(out_buffer);

			in_fd=open(filename,O_RDONLY);
			if (in_fd<0) {
				fprintf(stderr,"Could not open %s\n",filename);
			} else {
				while(1) {
					result=read(in_fd,&file_buffer,256);
					if (result<=0) break;

					memcpy(out_buffer+out_offset,
						file_buffer,result);
					out_offset+=result;
				}

				close(in_fd);
			}
			out_size=out_offset;
	}


	/* Send a response */

	printf("Sending:\n");
	printf("%s\n",out_buffer);

	n = write(fd,out_buffer,out_size);
	if (n<0) {
		fprintf(stderr,"Error writing. %s\n",
			strerror(errno));
	}
	return 0;
}


int main(int argc, char **argv) {

	int socket_fd,new_socket_fd;
	struct sockaddr_in server_addr, client_addr;
	struct addrinfo hints,*server_info;
	int port=DEFAULT_PORT;
	int n;
	socklen_t client_len;
	char buffer[BUFFER_SIZE];
	char in[RECEIVE_BUFFER_SIZE];
	int i,result,in_ptr=0;
	char port_string[BUFFER_SIZE];

	if (argc>1) {
		port=atoi(argv[1]);
	}
	sprintf(port_string,"%d",port);


	printf("Starting server on port %d\n",port);

	memset(&hints, 0, sizeof(hints));
	hints.ai_family = AF_INET;
	hints.ai_socktype = SOCK_STREAM;

	/* Null means localhost */
	/* How can we get IP of default interface? */
	result=getaddrinfo(NULL,port_string,&hints,&server_info);
	if (result<0) {
		fprintf(stderr,"Error getaddrinfo!\n");
		return -1;
	}

	/* Open a socket to listen on */
	/* AF_INET means an IPv4 connection */
	/* SOCK_STREAM means reliable two-way connection (TCP) */
	socket_fd = socket(hints.ai_family, hints.ai_socktype, hints.ai_protocol);
	if (socket_fd<0) {
		fprintf(stderr,"Error opening socket! %s\n",
			strerror(errno));
		return -1;
	}

	/* Set up the server address to listen on */
	memset(&server_addr,0,sizeof(struct sockaddr_in));
	server_addr.sin_family=AF_INET;
	/* Convert the port we want to network byte order */
	server_addr.sin_port=htons(port);


	/* Bind to the port */
	if (bind(socket_fd, server_info->ai_addr,server_info->ai_addrlen)) {
		fprintf(stderr,"Error binding! %s\n", strerror(errno));
		return -1;
	}

	/* Tell the server we want to listen on the port */
	/* Second argument is backlog, how many pending connections can */
	/* build up */
	listen(socket_fd,5);

listen_connection:

	/* Call accept to create a new file descriptor for an incoming */
	/* connection.  It takes the oldest one off the queue */
	/* We're blocking so it waits here until a connection happens */
	client_len=sizeof(client_addr);
	new_socket_fd = accept(socket_fd,
		(struct sockaddr *)&client_addr,&client_len);
	if (new_socket_fd<0) {
		fprintf(stderr,"Error accepting! %s\n",strerror(errno));
	}


	in_ptr=0;

	while(1) {

		/* Someone connected!  Let's try to read BUFFER_SIZE-1 bytes */
		memset(buffer,0,BUFFER_SIZE);
		n = read(new_socket_fd,buffer,(BUFFER_SIZE-1));
		if (n==0) {
			fprintf(stderr,"Connection to client lost\n\n");
			break;
		}
		else if (n<0) {
			fprintf(stderr,"Error reading from socket %s\n",
				strerror(errno));
		}

		if (in_ptr+n>RECEIVE_BUFFER_SIZE) {
			fprintf(stderr,"Overflow receive buffer!\n");
			break;
		}

		memcpy(&in[in_ptr],buffer,n);
		in_ptr+=n;
		in[in_ptr]=0;

		/* See if last chars were CRLFCRLF (empty line) */
		/* Which indicates done talking */
		if ((in[in_ptr-1]=='\n') && (in[in_ptr-3]=='\n')) {
			break;
		}
	}


	/* Print the message we received */

	char filename[BUFSIZ];

	printf("Request from webserver:\n");
	i=0;
	int found_filename=0,file_ptr=0;
	while(i<strlen(in)) {

		if (!found_filename) {
			if (in[i]=='G') {
				printf("G"); i++;
				if (in[i]=='E') {
					printf("E"); i++;
					if (in[i]=='T') {
						printf("T"); i++;
		if (in[i]==' ') {
			printf(" "); i++;
			found_filename=1;
			while(in[i]!=' ') {
				filename[file_ptr]=in[i];
				printf("%c",in[i]);
				i++;
				file_ptr++;
				if (file_ptr>BUFSIZ) break;
			}
			filename[file_ptr]=0;
		}


					}
				}
			}
		}

		printf("%c",in[i]);
		i++;
	}

	if (!strcmp(filename,"/")) {
		printf("Mapping / to index.html\n");
		strcpy(filename,"/index.html");
	}

	printf("Sending back file: %s\n",filename);

	/* Skip leading / */
	serve_file(new_socket_fd,filename+1);

	printf("Exiting server\n\n");

	/* Try to avoid TIME_WAIT */
//	sleep(1);

	/* Close the sockets */
	close(new_socket_fd);

	goto listen_connection;

	close(socket_fd);

	return 0;
}


