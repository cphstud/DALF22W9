library(readr) 
library(stringr) 


Sys.setlocale("LC_ALL", 'en_GB.UTF-8')
Sys.setenv(LANG = "en_US.UTF-8")

logfile <- readLines("access.log.1", encoding = "UTF-8")
length(logfile)
tst <- logfile[1]
ntst <- c('93.162.98.150 - - [09/May/2022:08:20:46 +0000] "GET /?s=Pippi+langstr%C3%B8mpe HTTP/1.1" 200 6553 "https://www.talmedos.com/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.54 Safari/537.36')

#IP
iptxt <- str_match(tst,"^([0-9\\.]+) -.*")
#Date
datetxt <- str_match(tst,"\\[(.*)\\]")
realdate <- as.Date("09/Dec/2022 00:09:24",format="%d/%b/%Y %H:%M:%S")
realdate <- strptime("09/Dec/2022 00:09:24 sfd",format="%d/%b/%Y %H:%M:%S")
realdate <- as.Date("28/May/2022",format ="%d/%b/%Y")
realdate <- as.Date("Maj/28/2022",format ="%b/%d/%Y")
class(realdate)
print(realdate+12)

#if GET then find queries
if ( str_detect(ntst, "GET /\\?s")) {
  qw <- str_match(ntst,"GET /\\?s=(.*) HTTP")
  print(qw[[2]])
  str_replace(ntst,"%[A-Z][0-9]%[A-Z][0-9]","")
}


df <- data.frame(matrix(ncol = 3, nrow = 1))
coln <- c('IP','timestamp','words','os')
coln <- c('IP','timestamp','words')
coln <- c('IP','words')
names(df) <- coln
names(test) <- coln


for (i in logfile) {
  
  #print(i)
  if ( str_detect(i, "GET /\\?s")) {
    print("INTO")
    print(i)
    qw <- str_match(i,"GET /\\?s=(.*) HTTP")
    print(qw[2])
  #find ip
    ip <- str_match(i,"^([0-9\\.]+) -.*")
    #df['ip'] <- ip
    # find date
    datetxt <- str_match(i,"\\[(.*) \\+")
    print(datetxt)
    #realdate <- strptime("09/Dec/2022 00:09:24 sfd",format="%d/%b/%Y %H:%M:%S")
    realdate <- strptime(datetxt[2],format="%d/%b/%Y:%H:%M:%S")
    print(realdate)
    # now create vector
    #v <- c(ip[2],cat(realdate),qw[2])
    v <- c(ip[2],datetxt[2],qw[2])
    #v <- c(ip[2],qw[2])
    names(v) <- coln
    print(v)
    df <- rbind(df,v)
    }
}

